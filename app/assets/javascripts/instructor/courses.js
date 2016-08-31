$(function() {
  const sectionIcons = {
    header: "glyphicon glyphicon-menu-left",
    activeHeader: "glyphicon glyphicon-menu-down"
  };
  $('.sections').accordion({
    header: "> div > div.section-item-header",
    heightStyle: "content",
    icons: sectionIcons,
    collapsible: true
  });
  $('.lessons').sortable({
    update: function(event, ui) {
      $.ajax({
        type: 'PUT',
        dataType: 'json',
        url: ui.item.data('update-url'),
        data: { lesson : { row_order_position : ui.item.index() } }
      });
    }
  });
  $('.sections').sortable({
    update: function(event, ui) {
      $.ajax({
        type: 'PUT',
        dataType: 'json',
        url: ui.item.data('update-url'),
        data: { section : { row_order_position : ui.item.index() } }
      });
    }
  });
});
