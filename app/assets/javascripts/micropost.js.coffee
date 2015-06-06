updateCountdown = ->
  remaining = 255 - jQuery("#micropost_area").val().length
  jQuery("#counter").text remaining + " characters remaining"

jQuery ->
  updateCountdown()
  $("#micropost_area").change updateCountdown
  $("#micropost_area").keyup updateCountdown