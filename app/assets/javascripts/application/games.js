$(document).ready(function() {
  if ($('.game-index .headers').length) {
    var sticky = new Waypoint.Sticky({
      element: $('.game-index .headers')[0]
    });
  }
});
