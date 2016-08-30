// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
$(function() {
  const sortableObjects = ["lessons", "sections"]
  let ajaxParams = {
    type: 'PUT',
    dataType: 'json'
  };
  for (let sortObject of sortableObjects) {
    $(document.getElementsByClassName(sortObject)).sortable({
      update: function(event, ui) {
        ajaxParams.url = ui.item.data('update-url');
        if (sortObject == "lessons") {
          ajaxParams.data = { lesson : { row_order_position : ui.item.index() } };
        } else if (sortObject == "sections") {
          ajaxParams.data = { section : { row_order_position : ui.item.index() } };
        }
        $.ajax(ajaxParams);
      }
    });
  }
});
