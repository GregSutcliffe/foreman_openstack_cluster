function cluster_selected(element){
  var cluster = $(element).val();
  var info = $('[id$="hostgroup_id"]').val();
  console.log(info);
  return;
  //if (subnet_id == '' || $('#host_ip').size() == 0) return;
  //// We do not query the proxy if the host_ip field is filled in and contains an
  //// IP that is in the selected subnet
  //var drop_text = $(element).children(":selected").text();
  //if (drop_text.length !=0 && drop_text.search(/^.+ \([0-9\.\/]+\)/) != -1) {
  //  var details = drop_text.replace(/^.+\(/, "").replace(")","").split("/");
  //  if (subnet_contains(details[0], details[1], $('#host_ip').val()))
  //    return;
  //}
  //var attrs = attribute_hash(["subnet_id", "host_mac", 'organization_id', 'location_id']);
  //$(element).indicator_show();
  //var url = $(element).data('url');
  //$.ajax({
  //  data: attrs,
  //  type:'post',
  //  url: url,
  //  complete: function(){  $(element).indicator_hide();},
  //  success: function(data){
  //    $('#host_ip').val(data.ip);
  //  }
  //})
}
