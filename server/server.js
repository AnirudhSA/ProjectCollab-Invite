const admin = require("firebase-admin");
const serviceAccount = require("../server/serviceAccountKey.json");
const API_KEY = "AIzaSyBjAape1jAvvv1mjfJZAi4NpaVeeNpjSpg";
const request = require("request");
const jwt = require("jsonwebtoken");
const http = require("http")
const app = require("express")();
const bodyParser = require("body-parser")
const sgMail = require("@sendgrid/mail")

sgMail.setApiKey("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")

const msg = {
  "from" : {
    "email" : "anican047@gmail.com",
    "name" : "ReSHARE",
  },
  "subject" : "Forgot Password Authentication",
  "personalizations" : [{
      "to" : [{
        "email" : ""
      }],
      "dynamic_template_data" :{
        "link" : ""
      }
    }],
  "template_id" : "d-3c11aed91bf54902b886152b0ffe2e8f",
}


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://dynamic-links-demo-fbaa0.firebaseio.com"
});

app.use(bodyParser.json())

app.post("/forgotPasswordEmail",async(req,res)=>{

  console.log(req.body);
msg.personalizations[0].to[0].email = req.body.email;
// var secretKey = "7^]'09===,.kllaksd62";
// var userToken = jwt.sign(req.body.email,secretKey,{algorithm : "HS256",expiresIn : 300});
var deeplink = "https://reshare.com?route="+req.body.route+"&email="+req.body.email;
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





request({
url : "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key="+API_KEY,
method : "POST", json : true , body 
},async(error,response)=>{
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
            msg.personalizations[0].dynamic_template_data.link = response.body.shortLink;
            sgMail.send(msg);
        }
    }
}
);

res.send({"message" : "Invitation was sent"})
});

const port = process.env.PORT||8000
app.listen(port,()=>{
  console.log(`Server is running on port ${port}`);
});