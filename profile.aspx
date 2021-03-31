<!doctype html5>
<html lang="en-US">
<head>
<title>
</title>
<meta charset="utf-8">
<meta name="description" content="personal dbmsproject">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Syne+Mono&display=swap" rel="stylesheet">
</head>
<body>
<div class="profile-content"><center>
<img id="loadUserImage()" style="width:50;height:50;border-radius:100%;" draggable="false" oncontextmenu="return false"><br>
<p id="loadUsername">loadUser()</p>
<br>
<p>Account Settings</p>
<p style="color:#fffc00;font-size:13px">Reset Password - <span style="font-size:10px;">[ you should re-authenticate after resetting password ]</span></p>
<input id="txtEmail" type="email" placeholder="Email" style="padding:8px;width:50%;border-radius:6px;border:none;outline:none;background-color:#333;color:#fff;font-family:'syne mono';" autocomplete="off" spellcheck="false" maxlength="65" draggable="false" oncontextmenu="return false"/><br/>
<button id="submitResetEmail" style="margin-top:10px;border:none;padding:10px;outline: none;background-color:#333;color:#fff;border-radius:4px;font-family:'syne mono';">Reset</button><br><br>
<p style="color:#fffc00;font-size:13px">Delete Account - <span style="font-size:10px;">[ your account will be removed from our servers ]</span></p>
<button id="removeData" style="margin-top:5px;border:none;padding:10px;outline: none;background-color:#333;color:#fff;border-radius:4px;font-family:'syne mono';">Remove</button>
</center>
</div>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-database.js"></script>
<script>
const firebaseConfig = {apiKey: "AIzaSyBdTC_Yuk-HIvpMZI9G_SJZ_G4Yuvyy3Jg",authDomain: "dbmsprojectone.firebaseapp.com",projectId: "dbmsprojectone",storageBucket: "dbmsprojectone.appspot.com", messagingSenderId: "803492942678",
appId: "1:803492942678:web:b08a765ab3aded91043cf7"}; firebase.initializeApp(firebaseConfig);
firebase.auth().onAuthStateChanged(firebaseUser=>{
if(firebaseUser){
const removeData = document.getElementById('removeData');
const removeUser = firebase.auth().currentUser;
removeData.addEventListener('click',e=>{
    if(confirm('Are you sure ? remove account')){
    console.log('dbms_project account removing started');
    removeData.delete().then(function(response){
        console.log(response);
        console.log('success removing account');
        firebase.auth().signOut();
    })
    .catch(function(error){
        console.log(error.message)
        console.log('error removing account')
    })
}
else{
 console.log('user cancelled removing operation');
}
})
const email = document.getElementById('txtEmail');
const submitReset = document.getElementById('submitResetEmail');
submitReset.addEventListener('click',e=>{
const txtEmail = email.value;
firebase.auth().sendPasswordResetEmail(txtEmail).then(function(){
console.log('email sent to respective email');
alert('email sent successfully');
firebase.auth().signOut();
})
.catch(function(error){
console.log(error.message);
alert(error.message);
console.log('failed to send password reset email');
})
})
console.log('user '+firebaseUser+' entered profile ');
var txtEmail = document.getElementById('txtEmail');
var user = firebase.auth().currentUser;
if( user != null){
var fDb = firebase.database();
var reference = fDb.ref('users');
reference.on('value',function(snapshot){
snapshot.forEach(function(userSnapShots){
document.getElementById('loadUsername').innerHTML=userSnapShots.val().txtUsername;
document.title=userSnapShots.val().txtUsername;
})
})
user.providerData.forEach(function(profile){
console.log('Email :- '+ profile.email);
/*document.getElementById('loadUsername').innerHTML = profile.email;*/
})}}
else{window.location.replace('index.html');}

})


/* database rules */
/* integrated already above gautham ! 
nullShots SnapShots ! 
var dbref = firebase.database();
var reference = dbref.ref('');
reference.on('value',function(snapshot){
snapshot.forEach(function(userSnapShot){
// [innerHTML,href,src]
// innerHTML = example.demo1
// href = example.demo2
// src = example.demo3
coded by Gautham Mummadi 2021 
https://github.com/gautham786!
Repo :- (updated) dbRef -> ajax-request-firebase-api-doc-auth-dbref-null-forEach-innerLoader
Repo :- status => {'private'};
})
}) */
/* change password and re-authenticate user by gautham_mummadi */
/* typeScript null Shot concept */
</script>
</body>
<style>
input[type=email]:focus{
box-shadow: 0 0 4px #fffc00;
color:#fffc00;
}
body{
font-family:'Syne Mono';
user-select: none;
background-color:#000;
color:#fff;
}::selection{color:#fffc00;
background-color:none;}
.profile-content{
text-align:center;
margin-top:50px;
}
</style>
</html>