L.mapbox.accessToken = 'pk.eyJ1IjoibWFsYXRhc2kiLCJhIjoiZWVlMGIwNTdkM2QzYzMyMzJlYzNlNzc3ZThmYTQ5MzIifQ.Wot8Oy7PsFlLec8QjqoozA';

var marker;

function set_initial_location() {
  navigator.geolocation.getCurrentPosition(show_map);
}

function show_map(position) {
  var latitude = $('#incident_latitude').val();
  var longitude = $('#incident_longitude').val();
  var readOnly = Boolean($('#incident_readonly').val());
  if (!latitude) {
	  latitude = position.coords.latitude;
  } 
  if (!longitude) {
	  longitude = position.coords.longitude;	
  }
  var map = L.mapbox.map('map', 'mapbox.streets').setView([latitude, longitude], 16);
  set_up_marker(latitude,longitude, map, readOnly);
}

function set_up_marker(latitude,longitude, map, readOnly) {
	marker = L.marker([latitude, longitude], {
    icon: L.mapbox.marker.icon({
      'marker-color': '#8EC400'
    }),
    draggable: !readOnly
}).addTo(map);

marker.on('dragend', ondragend);	

}



function ondragend() {
	var m = marker.getLatLng();
	document.getElementById('incident_latitude').value = m.lat;
	document.getElementById('incident_longitude').value = m.lng;
}
	

set_initial_location();