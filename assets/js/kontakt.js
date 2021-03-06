function getParameterByName(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
    results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}
$(function () {
  var param_rcp = getParameterByName('rcp');
  if(param_rcp !== "" && param_rcp !== null && param_rcp !== undefined) {
    var rcp_option = $('#recipient>option[value=' + param_rcp + ']');
    if(rcp_option.length === 1) {
      rcp_option.attr('selected', true);
      $('#recipient_option_choose').removeAttr('selected');
        $('select').formSelect();
    } else {
      $('select').formSelect();
    }
  } else {
      $('select').formSelect();

  }
});