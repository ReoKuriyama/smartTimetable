$(function(){
  var arrJson = $(".arr_json").val();
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
  function insertTdData(season){
    arr[season].forEach(function(tt){
      var id_number = "#" + tt['class_time']
      $(id_number).append(`
        <p class="td__class_name" data-professor-name="${tt['professor_name']} ">${tt['class_name']}</p>` + `<p>${tt['class_room']}</p>
        `);
      });
  }

  insertTdData('spring');

// border clear
  function borderClear(){
      $('tbody td').css("border", "none")
  }
  // 授業名、教授名の連携
  $('table').on('click', 'tbody td', function(){
    if ($(this).children("p")[0]){
      //border調整
      borderClear();
      $(this).css("border", "0.5px solid #FAFAFA")
      //クリックされた時間割のデータ取得
      var class_name = $(this).find(".td__class_name").text()
      var id = $(this).attr("id")
      var professor_name = $(this).find(".td__class_name").data("professorName")
      //取得したデータに基づいてテキスト変更
      $(".class-name").text(class_name)
      $(".professor-name").text(professor_name)
    }
  });

  // 春秋切り替え
    var switchNumber = 0
    $('thead').on('click', '#switch', function(){
      borderClear();
      switchNumber += 1;
      $('tbody td').empty();
      if (switchNumber %2 == 0) {
        insertTdData('spring');
        $(this).text('春').css('color', '#f0c0f5')
      } else {
      insertTdData('autumn');
      $(this).text('秋').css('color', '#e6ae7b')
    }
    })
});
