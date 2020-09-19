const admin = require("firebase-admin");
const serviceAccount = require("../server/serviceAccountKey.json");
const API_KEY = "AIzaSyBjAape1jAvvv1mjfJZAi4NpaVeeNpjSpg";
const request = require("request");
const jwt = require("jsonwebtoken");
const http = require("http")
const app = require("express")();


app.post("/fp_email",(req,res)=>{

var secretKey = "7^]'09===,.kllaksd62";
var userToken = jwt.sign(req.body,secretKey,{algorithm : "HS256",expiresIn : 300});
var deeplink = "https://reshare.com?route=forgotpassword&token="+userToken;
var body = {
  "dynamicLinkInfo" : {
    "domainUriPrefix" : "https://anirudh99.page.link",
    "link" : deeplink,
    "androidInfo" : {
      "androidPackageName" : "com.anirudh.flutter_chat"
  }},
  "suffix" : {
    "option" : "UNGUESSABLE" 
    }
}

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://dynamic-links-demo-fbaa0.firebaseio.com"
});



request({
url : "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key="+API_KEY,
method : "POST", json : true , body 
},function(error,response){
    if(error){
        console.log("Error :",error);
    }
    else{
      if(response&&response.statusCode!=200)
      {
        console.log("Error :",response.body);
      }
        else
        {
            console.log("Dynamic Link Successfully Created :",response.body);
        }
    }
}
);

});

app.listen(process.env.PORT||3000);