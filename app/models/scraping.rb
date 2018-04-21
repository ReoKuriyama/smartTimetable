require 'nokogiri'
require 'capybara'
require 'capybara/poltergeist'

# session.save_screenshot 'screenshot.png'

class Scraping
  def self.get_classes(email, password)
    # poltergist setting
    Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 })
    end
    Capybara.default_selector = :xpath
    session = Capybara::Session.new(:poltergeist)

    session.driver.headers =
      { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X)' }
    # keio.jp
    session.visit 'https://auth.keio.jp/'
    # login
    session.find("//*[@id='username']").send_keys(email)
    session.find("//*[@id='password']").send_keys(password)
    # click login button
    session.find("//*[@id='login']/section[5]/button").click

    # click button
    session.find("//*[@id='b_menu']/li[2]").click
    session.find("//*[@id='b_menu']/li[2]/ul/li[1]").click

    # switch tab
    # session.switch_to_window(session.windows.last)

    sleep(2)

    session.visit 'https://gslbs.adst.keio.ac.jp/student/schedule/View_Schedule.php'

    sleep(2)

    session.save_screenshot 'screenshot.png'

    html = session.html
    doc = Nokogiri::HTML.parse(html)

    # get subjects
    spring_subjects = doc.search('/html/body/center/table[2]').search('.calendar')
    autumn_subjects = doc.search('/html/body/center/table[3]').search('.calendar')

    # カラム名生成のため変数
    n = 11
    s = 1
    start = 11
    autumn_subjects.each do |subject|
      unless subject.inner_text.blank?
        timetable = SchoolTimetable.new
        array = []
        subject.inner_text.each_line { |line| array << line.delete(' ') }
        timetable.class_time = n
        timetable.class_name = array[1]
        timetable.class_room = subject.search('.room').inner_text.gsub('教室', '')
        timetable.professor_name = array[2]
        timetable.class_type = 1
        timetable.save
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
    session.driver.quit
  end
end
