function close() {
  $(".crosshair").removeClass('active');
  $(".menu").removeClass('fadeIn');
  $.post('http://rcore_entity_menu/close',JSON.stringify({}))
}

var app = new Vue({
  el: '#app',
  data: {
    visible: false,
    menu: {}
  },
  methods: {
    onClick: function (itemName) {
      $.post('http://rcore_entity_menu/click',JSON.stringify({
        item: itemName
      }));
      close()
    }
  },
  computed: {
  }
});

$(document).ready(function(){
  window.addEventListener('message', function(event){

    if(event.data.menu){
      if(event.data.action == 'turnoff'){
        $(".crosshair").removeClass('active');
        $(".menu").removeClass('fadeIn');
      }

      if(event.data.action == 'turnon'){
        app.menu = event.data.menu;
        $(".crosshair").addClass('active');
        $(".menu").addClass('fadeIn');
      }
    }

  });

  var closeKeys = [113, 27, 90];

  $(document.body).bind("keyup", function (key) {
    if (closeKeys.includes(key.which)) {
      close()
    }
  });

});
