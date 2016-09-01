$(function() {
  // Set icons for accordion
  const sectionIcons = {
    header: "glyphicon glyphicon-menu-left",
    activeHeader: "glyphicon glyphicon-menu-down"
  };
  // Sets proper url for lesson creation
  $('.new-lesson-card').click(function( event ){
    var lessonUrl = $( event.currentTarget ).data('lesson-url');
    $('#newLessonForm').attr('action', lessonUrl);
  });
  // Sets proper url/target for section/lesson updating, adds current data from db to update form
  $('.glyphicon-pencil').click(function( event ){
    var parentNode = $( event.currentTarget ).parent()
    var updateUrl = parentNode.data('update-url');
    var modalTarget = $( event.currentTarget ).data('target') + 'Form';
    if (/lessons/i.test(updateUrl)) {
      $( modalTarget + ' #lesson_title' ).val( parentNode.data('title') );
      $( modalTarget + ' #lesson_subtitle' ).val( parentNode.data('subtitle') );
      $( modalTarget + ' #lesson_additional_notes' ).val( parentNode.data('additional-notes') );
    } else {
      $( modalTarget + ' #section_title' ).val( parentNode.data('title') );
    }
    $( modalTarget ).attr('action', updateUrl);
  });
  // Accordions sections
  $('.sections').accordion({
    header: "> div > div.section-item-header",
    heightStyle: "content",
    icons: sectionIcons,
    collapsible: true
  });
  // Make lessons and sections sortable, put new order in db
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
