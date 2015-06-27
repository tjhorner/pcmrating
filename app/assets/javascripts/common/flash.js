// =======================================================================
// Fancy jQuery Notifications
//
// Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
//
//
// Requires: jquery
//
// Author: Michael Luckeneder (https://github.com/mluckeneder)
//
//
// =======================================================================

(function( $ ){
  var $closeTimeout;



  var setupNotificationBehavior = function(){
    $(".flash").click(function(){
      $(this).slideUp('slow');
    });
    $('.flash').slideDown('slow');
  };


  $.FancyNotifications = function() {
    setupNotificationBehavior();
  };

  $.FancyNotifications.error = function(message){
    this.showMessage("error", message);
  };

  $.FancyNotifications.alert = function(message){
    this.showMessage("alert", message);
  };

  $.FancyNotifications.notice = function(message){
    this.showMessage("notice", message);
  };

  $.FancyNotifications.showMessage = function(type,message){
    if(message && message.length > 0) {
      var $div = $("<div></div>");
      $div.attr("class","flash");
      $div.attr("id", "flash_"+type);
      $div.hide();
      $div.html(message);

      $('body').prepend($div);

      setupNotificationBehavior();
    }
  };

  $.FancyNotifications.close = function(){
    clearTimeout($closeTimeout);
    $('.flash').slideUp('slow',function(){ $(this).remove();});
  };

})( jQuery );