# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggle_fav = (nb, is_fav, elem) ->
  type = if is_fav then 'DELETE' else 'POST'
  $.ajax(url: '/favorites', type: type, data: { number: nb }).done (res) ->
    elem.attr('data-fav', (!is_fav).toString())

string_to_bool = (str) ->
  (str == 'true')

ready = ->
  $('a[data-nb]').click (e) ->
    e.preventDefault()
    nb = $(this).data('nb')
    is_fav = string_to_bool($(this).attr('data-fav'))
    toggle_fav(nb, is_fav, $(this))

$(document).ready(ready)
$(document).on('page:load', ready)
