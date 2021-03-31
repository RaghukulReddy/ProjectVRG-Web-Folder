<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<script src="https://kit.fontawesome.com/b9f8ead5bd.js"></script>
<link href="https://fonts.googleapis.com/css?family=Syne+Mono&display=swap" rel="stylesheet" />
<script src="https://fonts.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
<title>dbms project</title>
<style>
body {
font-family: 'Syne Mono', sans-serif;
background-color:#fff;color:black;
user-select:none;
}
.navbar,
.navbar-brand {
font-family: 'Syne Mono', sans-serif;
}

.jumbotron {
background-image: url("./img/travelimagetransparent2.png");
background-repeat: no-repeat;
background-size: contain;
}

#map {
height: 400px;
margin:0 auto;
width:95%;
padding:10px;
border-radius:15px;
}
</style>
</head>

<body>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-database.js"></script>
<center>
<h1 style="text-align:center;margin-top:40px;" id="loadUsername">loadUser()</h1>
<pre style="text-align:center;color:#000;">search restaurants or hotels nearby</pre>
<pre style="text-align:center;color:#000;font-size:12px;">Team => { gautham, gopi, saiKrishna } </pre>
<div><button id="lightTheme">Light</button>&nbsp;<button id="nightTheme">Dark</button></div>
<p id="showLightText" style="color:#e95353;margin-top:10px;">Page is in light !</p>
<!-- <form onsubmit="return getPlaces()"> -->
<input id='search' type="text" name="dbmsQuery"
placeholder="search restaurants" style="width:40%;padding:10px;text-align:center;border-radius:25px;
outline:none;margin-top:10px;border:none;background-color:#fff;color:#000;box-shadow:0px 0px 4px #000;" autocomplete="off" 
spellcheck="false" maxlength="50"/>
<!-- </form> -->

<br/><br/>
<section class='map'>
<div id='map'></div>
</section>
</center>
<style>
::selection{
color:#000;
background-color:#fffc00;
}
input:focus{
outline:#fffc00;
background-color:#fffc00;
}
#lightTheme,#nightTheme{
padding:6px;
background-color: #000;
color:white;
border: none;
width:auto;
border-radius:4px;
box-shadow: 0 0 4px #000;
cursor: pointer;
outline:none;
}
</style>
<script>
document.title="team_Dark Hunters"
</script>
<!-- INFO SECTION -->
<div class="container mt-5">
<div class="row">
<div class="col-md-4 offset-md-4 text-center ">
<h1 class='display-5' id='locationName'></h1>
</div>
</div>
<div class="row">
<div class="col-md-6 text-center mt-3">
<div id='hotel-header'></div>
<div id='hotels' style="color:black"></div>

</div>
<div class="col-md-6 text-center mt-3">
<div id='restaurant-header'></div>
<div id='restaurants' style="color:black"></div>
</div>
</div>

</div>
<!-- PICTURE SECTION -->
<div class="container" style="border-radius:10px;">
<div class="row mt-5 mb-5">
<div class="col-md-8 offset-md-2">
<div id='images' style="border:10px;"></div>
</div>
</div>

</div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"
integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
crossorigin="anonymous"></script>

<!-- GOOGLEMAPS SCRIPT -->
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA2O3egqOVawDdIbQ78fOERoWyw_9GyZFA&callback=initMap&libraries=places"></script>
</body>
<script>
var map;
var infoWindow;

function initMap() {
var options = {
zoom: 6,
/*styles: [
{ elementType: "geometry", stylers: [{ color: "#242f3e" }] },
{ elementType: "labels.text.stroke", stylers: [{ color: "#242f3e" }] },
{ elementType: "labels.text.fill", stylers: [{ color: "#746855" }] },
{
featureType: "administrative.locality",
elementType: "labels.text.fill",
stylers: [{ color: "#d59563" }],
},
{
featureType: "poi",
elementType: "labels.text.fill",
stylers: [{ color: "#d59563" }],
},
{
featureType: "poi.park",
elementType: "geometry",
stylers: [{ color: "#263c3f" }],
},
{
featureType: "poi.park",
elementType: "labels.text.fill",
stylers: [{ color: "#6b9a76" }],
},
{
featureType: "road",
elementType: "geometry",
stylers: [{ color: "#38414e" }],
},
{
featureType: "road",
elementType: "geometry.stroke",
stylers: [{ color: "#212a37" }],
},
{
featureType: "road",
elementType: "labels.text.fill",
stylers: [{ color: "#9ca5b3" }],
},
{
featureType: "road.highway",
elementType: "geometry",
stylers: [{ color: "#746855" }],
},
{
featureType: "road.highway",
elementType: "geometry.stroke",
stylers: [{ color: "#1f2835" }],
},
{
featureType: "road.highway",
elementType: "labels.text.fill",
stylers: [{ color: "#f3d19c" }],
},
{
featureType: "transit",
elementType: "geometry",
stylers: [{ color: "#2f3948" }],
},
{
featureType: "transit.station",
elementType: "labels.text.fill",
stylers: [{ color: "#d59563" }],
},
{
featureType: "water",
elementType: "geometry",
stylers: [{ color: "#17263c" }],
},
{
featureType: "water",
elementType: "labels.text.fill",
stylers: [{ color: "#515c6d" }],
},
{
featureType: "water",
elementType: "labels.text.stroke",
stylers: [{ color: "#17263c" }],
},
],
*/
center: {
lat: 53.35014,
lng: -6.266155
}
// disableDefaultUI: true
};
map = new google.maps.Map(document.getElementById("map"), options);

var input = document.getElementById("search");
var searchBox = new google.maps.places.SearchBox(input);

map.addListener("bounds_changed", function() {
searchBox.setBounds(map.getBounds());
});

var markers = [];

searchBox.addListener("places_changed", function() {
var places = searchBox.getPlaces();

function getPlaces(){
var places = searchBox.getPlaces();
}
// PRESENTING PICTURE OF THE DESTINATION
let img =
"<img src='" +
places[0].photos[0].getUrl() +
"' alt='location' class='img-fluid'/>";

document.getElementById("images").innerHTML = img;

// PRESENTING NAME OF THE DESTINATION
document.getElementById("locationName").innerHTML = places[0].name;

let location = {
lat: places[0].geometry.location.lat(),
lng: places[0].geometry.location.lng()
};

// GET DATA FROM THE DESIRED LOCATION
getRestaurants(location);
getHotels(location);

if (places.length === 0) {
return;
}

// RESET PREVOIUS MARKERS
markers.forEach(function(m) {
m.setMap(null);
});
markers = [];

var bounds = new google.maps.LatLngBounds();

places.forEach(function(p) {
if (!p.geometry) return;

markers.push(
new google.maps.Marker({
map: map,
title: p.name,
position: p.geometry.location
})
);

if (p.geometry.viewport) {
bounds.union(p.geometry.viewport);
} else {
bounds.extend(p.geometry.location);
}
map.fitBounds(bounds);
});
});
}
// FUNCTION TO GET RESTAURANTS IN THE AREA
function getRestaurants(location) {
let targetLocation = new google.maps.LatLng(location.lat, location.lng);

let request = {
location: targetLocation,
radius: "1500",
type: ["restaurant"]
};

service = new google.maps.places.PlacesService(map);
service.nearbySearch(request, callback);
}
// FUNCTION TO GET HOTELS IN THE AREA
function getHotels(location) {
let targetLocation = new google.maps.LatLng(location.lat, location.lng);

let request = {
location: targetLocation,
radius: "1500",
type: ["lodging"]
};

service = new google.maps.places.PlacesService(map);
service.nearbySearch(request, callbackHotels);
}

function callback(results, status) {
if (status == google.maps.places.PlacesServiceStatus.OK) {
places = [];

for (let i = 0; i < results.length; i++) {
places.push(results[i]);
}
// PRESENTING MARKERS LABEL
places.forEach(place => {
let content = `<h4>${place.name}</h4>
<p>${place.vicinity}</p>
<h4>Rating: ${place.rating}</h4>`;

var marker = new google.maps.Marker({
position: place.geometry.location,
map: map,
title: place.name,
icon: { url: "http://maps.google.com/mapfiles/ms/icons/green-dot.png" }
});

var infoWindow = new google.maps.InfoWindow({
content: content
});

bindInfoWindow(marker, map, infoWindow, content);
marker.setMap(map);
});
}

function bindInfoWindow(marker, map, infoWindow, html) {
marker.addListener("click", function() {
infoWindow.setContent(html);
infoWindow.open(map, this);
});
}

// api for list of restaurants
let str = "<ul class='list-group list-group-flush'>";

for (let i = 0; i < 5; i++) {
str += "<li class='list-group-item'>" + places[i].name + "</li>";
}
str += "</ul>";

document.getElementById("hotel-header").innerHTML =
'<h3>Hotels <img src="http://maps.google.com/mapfiles/ms/icons/green-dot.png" alt="Hotels"></h3>';
document.getElementById("restaurants").innerHTML = str;
}

function callbackHotels(results, status) {
if (status == google.maps.places.PlacesServiceStatus.OK) {
places = [];

for (let i = 0; i < results.length; i++) {
places.push(results[i]);
}

places.forEach(place => {
let content = `<h3 style='color:black;font-size:15px'>${place.name}</h3>
<p style='color:black;font-sizeL:12px;'>${place.vicinity}<br>
Rating: ${place.rating}</p>`;
var marker = new google.maps.Marker({
position: place.geometry.location,
map: map,
title: place.name,
icon: { url: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" }
});
var infoWindow = new google.maps.InfoWindow({
content: content
});
bindInfoWindow(marker, map, infoWindow, content);
marker.setMap(map);
});
}
function bindInfoWindow(marker, map, infoWindow, html) {
marker.addListener("click", function() {
infoWindow.setContent(html);
infoWindow.open(map, this);
});
}
// api for list of hotels
let str = "<ul class='list-group list-group-flush'>";
for (let i = 0; i < 5; i++) {
str += "<li class='list-group-item' style='overflow-y:auto;'>" + places[i].name + "</li>";
}
str += "</ul>";
document.getElementById("restaurant-header").innerHTML =
'<h3>Restaurants <img src="http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" alt="Restaurants"></h3>';
document.getElementById("hotels").innerHTML = str;
}

/* firebase client side scripting */
const firebaseConfig = {apiKey: "AIzaSyBdTC_Yuk-HIvpMZI9G_SJZ_G4Yuvyy3Jg",authDomain: "dbmsprojectone.firebaseapp.com",projectId: "dbmsprojectone",storageBucket: "dbmsprojectone.appspot.com", messagingSenderId: "803492942678",
appId: "1:803492942678:web:b08a765ab3aded91043cf7"}; firebase.initializeApp(firebaseConfig);
/* firebase client side scripting */
firebase.auth().onAuthStateChanged(firebaseUser=>{
if(firebaseUser){
var fDb = firebase.database();
var reference = fDb.ref('users');
reference.on('value',function(snapshot){
snapshot.forEach(function(userSnapShots){
document.getElementById('loadUsername').innerHTML="Hi, " + userSnapShots.val().txtUsername;
document.title="Light Theme"
})
})
}
else{
console.log('logging out, because you are not logged in to our servers')
window.location.replace('index.html')
}
}) 

/* handle theme of the Buttons by Gautham Reddy ! */
$(document).ready(function(){
$("#showLightText").hide()
$("#lightTheme").click(function(){
    $("#showLightText").show()
setTimeout(function(){
$("#showLightText").hide()
},1000)
})
$("#nightTheme").click(function(){
window.location.replace('gmaps_theme=night.aspx')
})
})
</script>
</html>