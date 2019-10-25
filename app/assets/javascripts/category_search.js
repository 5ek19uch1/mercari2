$(function(){
  $("#category-fire").hover(function(){
    $(".category-list__parent").addClass("show1");
    // $('.category-list__grandchild').remove();
    var parentList = $('.show1').children('.category-list__parent');
    parentList.show();
  },function(){
    $('.category-list').mouseleave(function(){
      $('.category-list__parent,.category-list__child, .category-list__grandchild').removeClass("show1");
      $('.category-list__parent').children('.category-list__parent').hide();
    });
  });
});



$(function(){
// childrenのリスト追加
  function childrenListHTML(child){
    var html = `<li class="category-list__child__li" id="${child.id}">
                ${child.name}
                </li>`;
    return html;
  }
  $(".category-list__parent__li").mouseover(function(){
    setTimeout(function(){
      $('.category-list__child__li').remove();//親と紐づいた子供カテゴリーの中身を消す
  },30); //リスト表示の点滅の軽減用

    $(".category-list__child").addClass("show1");
    var childrenList = $('.show1').children(".category-list__child");
    childrenList.show();
    var id = this.id
      $.ajax({
      type: 'GET',
      url: 'category_children',
      data: {parent_id: id},
      dataType: 'json'
    }).done(function(children){
      children.forEach(function(child){
        var childList = childrenListHTML(child);
        $(".category-list__child").append(childList);
      })
    },function(){
      $('.category-list').mouseleave(function(){
        $('.category-list__child').removeClass("show1");
        $('.category-list__grandchild').removeClass("show1");
        $('.category-list__child').children('.category-list__child').hide();
      });
    });
  });


  // 孫の表示
  function grandchildrenListHTML(child){
    var html = `<li class="category-list__grandchild__li" id="${child.id}">
                ${child.name}
                </li>`;
    return html;
  }
  
  $(document).on("mouseover", ".category-list__child__li", function () {

    setTimeout(function(){
    $('.category-list__grandchild__li').remove();//親（ここでは子供）と紐づいた子供（孫）カテゴリーの中身を消す
  },30);//リスト表示の点滅の軽減用

    $('.category-list__grandchild').addClass("show1");
    var grandchildrenList = $('.show1').children(".category-list__grandchild");
    grandchildrenList.show();
    var id = this.id

    $.ajax({
      type: 'GET',
      url: 'category_grandchildren',
      data: {parent_id: id},
      dataType: 'json'
    }).done(function(children){
      children.forEach(function(child){
        var grandchildList = grandchildrenListHTML(child);
        $(".category-list__grandchild").append(grandchildList);
      })
    },function(){
      $('.category-list__child').mouseover(function(){
        $('.category-list__grandchild').removeClass("show1");
        $('.category-list__grandchild').children('.category-list__grandchild').hide();
      });
      $('.category-list__parent').mouseover(function(){
        $('.category-list__grandchild').removeClass("show1");
      });
    })
  })
});
