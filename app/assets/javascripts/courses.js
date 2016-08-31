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
});
