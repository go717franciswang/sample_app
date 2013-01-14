# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
update_count = ->
    char_left = 140 - $('#micropost_content').val().length
    char_left = 0 if char_left < 0
    $('#char_count').text(char_left)

jQuery ->
    update_count()
    $('#micropost_content').keydown (e) ->
        update_count()
