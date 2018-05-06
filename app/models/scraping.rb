require 'nokogiri'
require 'capybara'
require 'capybara/poltergeist'

class Scraping
  attr_reader :email, :password, :c_user_id, :univ_name, :session
  def initialize(args)
    @email = args[:email]
    @password = args[:password]
    @c_user_id = args[:c_user_id]
    @univ_name = args[:univ_name]
    @session = create_session
  end

  def create_session
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 1000)
    end
    Capybara.default_selector = :xpath
    session = Capybara::Session.new(:poltergeist)
    session.driver.headers =
      { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X)' }
    session
  end

  def scrape_timetables
    case univ_name
    when 'keio' then
      keio_scraping
    else
      puts 'uncorrect univ name'
      session.driver.quit
      false
    end
  end

  def keio_scraping
    session.visit 'https://auth.keio.jp/'
    # login
    session.find("//*[@id='username']").send_keys(email)
    session.find("//*[@id='password']").send_keys(password)
    # click login button
    session.find("//*[@id='login']/section[5]/button").click
    # when login failed
    if session.current_url != 'https://portal.keio.jp/koid/'
      session.driver.quit
      false
    end
    # click button
    session.find("//*[@id='b_menu']/li[2]").click
    session.find("//*[@id='b_menu']/li[2]/ul/li[1]").click
    sleep(2)
    session.visit 'https://gslbs.adst.keio.ac.jp/student/schedule/View_Schedule.php'
    sleep(2)
    html = session.html
    doc = Nokogiri::HTML.parse(html)

    # get subjects
    spring_subjects = doc.search('/html/body/center/table[2]').search('.calendar')
    autumn_subjects = doc.search('/html/body/center/table[3]').search('.calendar')

    save_classes(spring_subjects, 0)
    save_classes(autumn_subjects, 1)
    session.driver.quit
  end

  def save_classes(subjects, type)
    # カラム名生成のため変数
    n = 11
    s = 1
    start = 11
    subjects.each do |subject|
      unless subject.inner_text.blank?
        array = []
        subject.inner_text.each_line { |line| array << line.delete(' ') }
        class_name = array[1]

        timetable = SchoolTimetable.where(class_name: class_name)
        if timetable.blank?
          SchoolTimetable.create(
            class_name: class_name,
            class_time: n,
            class_room: subject.search('.room').inner_text.gsub('教室', ''),
            professor_name: array[2],
            class_type: type,
            user_ids: [c_user_id]
          )
        else
          TakingClass.create(
            user_id: c_user_id,
            school_timetable_id: timetable[0].id
          )
        end
      end

      if s == 6
        start += 10
        n = start
        s = 1
      else
        n += 1
        s += 1
      end
    end
  end
end
