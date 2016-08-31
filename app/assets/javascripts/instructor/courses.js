$(function() {
  const sortableObjects = ["lessons", "sections"];
  const sectionIcons = {
    header: "glyphicon glyphicon-menu-left",
    activeHeader: "glyphicon glyphicon-menu-down"
  };
  var ajaxParams = {
    type: 'PUT',
    dataType: 'json'
  };
  $('.sections').accordion({
    header: "> div > div.section-item-header",
    heightStyle: "content",
    icons: sectionIcons,
    collapsible: true
  });
  for (let sortObject of sortableObjects) {
    $(document.getElementsByClassName(sortObject))
    .sortable({
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
