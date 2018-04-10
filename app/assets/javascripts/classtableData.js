$(function(){
  var arrJson = $(".arr_json").val();
  // arr_jsonをパースし配列にする
  var arr = JSON.parse(arrJson);
  // tbodyの作成
  var html;
  for (i = 1; i < 7; i++) {
      var tr =
        `
        <tr>
          <th>${i}</th>
            <td id="${i}1"></td>
            <td id="${i}2"></td>
            <td id="${i}3"></td>
            <td id="${i}4"></td>
            <td id="${i}5"></td>
            <td id="${i}6"></td>
        </tr>
        `
  html += tr
  }
  $('tbody').append(html)
  //tdへデータの挿入
  arr.forEach(function(v){
    var id_number = "#" + v[0]
    $(id_number).append(`<p class="td__class_name" data-professor-name="${v[3]} ">${v[1]}</p>` + `<p>${v[2]}</p>`);
  });

  //授業名、教授名の連携
  $('table').on('click', 'tbody td', function(){
    if ($(this).children("p")[0]){
      //border調整
      $('tbody td').css("border", "none")
      $(this).css("border", "0.5px solid #FAFAFA")
      //クリックされた時間割のデータ取得
      var class_name = $(this).find(".td__class_name").text()
      var id = $(this).attr("id")
      var professor_name = $(this).find(".td__class_name").data("professorName")
      //取得したデータに基づいてテキスト変更
      $(".class-name").text(class_name)
      $(".professor-name").text(professor_name + "君")
    }
  });
});
