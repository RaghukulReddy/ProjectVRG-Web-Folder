
<!DOCTYPE html>
<html lang="en">
<head>
<title>
loadUser()
</title>
<!-- <script data-ad-client="ca-pub-9308275412654195" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script> -->
<meta http-equiv="refresh" content="7.5,url='content_game=true.html'"/>
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no"/>
<link href="https://fonts.googleapis.com/css?family=Aldrich" rel="stylesheet" type="text/css"/>
</head>
<body onContextMenu="return false">
<div class="containergautham">
<p id="loadUsername" style="text-align:center;"></p><br>
<p><span class="typed-text"></span><span class="cursor">&nbsp;</span></p>
</div>
<script>
const typedTextSpan = document.querySelector(".typed-text");
const cursorSpan = document.querySelector(".cursor");
const textArray = ["loading ..."];
const typingDelay = 200;
const erasingDelay = 100;
const newTextDelay = 2000;
let textArrayIndex = 0;
let charIndex = 0;

function type() {
if (charIndex < textArray[textArrayIndex].length) {
if(!cursorSpan.classList.contains("typing")) cursorSpan.classList.add("typing");
typedTextSpan.textContent += textArray[textArrayIndex].charAt(charIndex);
charIndex++;
setTimeout(type, typingDelay);
} 
else {
cursorSpan.classList.remove("typing");
setTimeout(erase, newTextDelay);
}
}

function erase() {
if (charIndex > 0) {
if(!cursorSpan.classList.contains("typing")) cursorSpan.classList.add("typing");
typedTextSpan.textContent = textArray[textArrayIndex].substring(0, charIndex-1);
charIndex--;
setTimeout(erase, erasingDelay);
} 
else {
cursorSpan.classList.remove("typing");
textArrayIndex++;
if(textArrayIndex>=textArray.length) textArrayIndex=0;
setTimeout(type, typingDelay + 1100);
}
}

document.addEventListener("DOMContentLoaded", function() { 
if(textArray.length) setTimeout(type, newTextDelay + 250);
});
</script>
</body>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-database.js"></script>
<script>
const firebaseConfig = {apiKey: "AIzaSyBdTC_Yuk-HIvpMZI9G_SJZ_G4Yuvyy3Jg",authDomain: "dbmsprojectone.firebaseapp.com",projectId: "dbmsprojectone",storageBucket: "dbmsprojectone.appspot.com", messagingSenderId: "803492942678",
appId: "1:803492942678:web:b08a765ab3aded91043cf7"}; firebase.initializeApp(firebaseConfig);

</script>
<style>p{font-family:'Aldrich';color:white;font-size: 25px;}body{background-color:black;color:coral;}

.containergautham {
height: 100vh;
display: flex;
justify-content: center;
align-items: center;
margin-top:-200px;
}
.containergautham p {
font-size: 3rem;
padding: 0.5rem;
font-weight: bold;
letter-spacing: 0.1rem;
text-align: center;
overflow: hidden;
}
.containergautham p span.typed-text {
font-weight: normal;
color: palevioletred;
}
.container p span.cursor {
display: inline-block;
background-color: #ccc;
margin-left: 0.1rem;
width: 3px;
animation: blink 1s infinite;
}
.containergautham p span.cursor.typing {
animation: none;
}
@keyframes blink {
0%  { background-color: #ccc; }
49% { background-color: #ccc; }
50% { background-color: transparent; }
99% { background-color: transparent; }
100%  { background-color: #ccc; }
}
@font-face{
font-family:heaters;
src: url(Heaters.otf);
}
html{user-select: none;
scroll-behavior: auto;}

</style>
<script>
var fDb = firebase.database();
var reference = fDb.ref('users');
reference.on('value',function(snapshot){
snapshot.forEach(function(userSnapShots){
document.getElementById('loadUsername').innerHTML="Hola, " + userSnapShots.val().txtUsername + " => The game is "; 
document.title=userSnapShots.val().txtUsername;
})})
firebase.auth().onAuthStateChanged(firebaseUser=>{
if(firebaseUser){
console.log('you are logged in and being redirected')
}
else{
window.location.replace('index.html')
}
})
</script>
</html>