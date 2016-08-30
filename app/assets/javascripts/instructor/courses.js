// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
// Need to implement ES6 transpiling in order to DRY this up (ES6 allows setting object keys dynamically)
$(function() {
  $('.lessons').sortable({
    update: function(event, ui) {
      $.ajax({
        type: 'PUT',
        url: ui.item.data('update-url'),
        dataType: 'json',
        data: { lesson : { row_order_position : ui.item.index() } }
      });
    }
  });
  $('.sections').sortable({
    update: function(event, ui) {
      $.ajax({
        type: 'PUT',
        url: ui.item.data('update-url'),
        dataType: 'json',
        data: { section : { row_order_position : ui.item.index() } }
      });
    }
  });
});
