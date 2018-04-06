class HomesController < ApplicationController
  def index
    @arr =[
      ["11", "経済学", "523", "グレーヴァ香子"],
      ["43", "財政社会学", "245", "慶応太郎"],
      ["24", "経済学", "123", "福沢諭吉"],
      ["55", "ミクロ", "412", "藤沢康成"]

      ];
  # 配列をJsonへ変換する
    @arr_json = @arr.to_json.html_safe
  end
end
