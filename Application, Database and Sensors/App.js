var express = require('express');
var app = express();
var bodyParser = require('body-parser');
//const Db = require("./DB");
const { createSecureContext } = require('tls');
var mqtt =require('mqtt');
var bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
var datafromMQTT = "";
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost:27017/contentDB', {useNewUrlParser: true, useUnifiedTopology: true});

// we create a scheme first 
const appSchema = new mongoose.Schema({
    userID: String,
    email: String,
    password: String,
    Username: String,
    temperature: Number,
    windSpeed: Number,
    humidity: Number,
    timeToDry: Number
})

const dataB = mongoose.model("ApplicationScema",appSchema);
var user0 = new dataB({
    email:"theemail",
    Username: "theusername",
    password: "thepassword",
});

//user0.save();
// Create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false });
var mqclient  = mqtt.connect('mqtt://localhost:1883')
var net= require('net');
const { send } = require('process');
var port=3000;
var uname;
var client= new net.Socket();// add your phone's IP and port
var sunrise, sunset;
var sendthis="";

mqclient.on('connect', function () {
    mqclient.subscribe('project/time', function (err) {
      if (!err) {
        //client.publish('coe457/hello', 'Hello COE457 from node.js')
        console.log("MQTT started");
      }
    })
    mqclient.subscribe('project/sensor');
    mqclient.subscribe('project/bestweather');
    mqclient.subscribe('project/currentweather');

  })
   
  mqclient.on('message', function (topic, message) 
  {
    // message is Buffer
    console.log(message.toString());
    client.end();
    datafromMQTT = JSON.parse(message.toString());
    console.log(datafromMQTT);
    // dataB.updateOne({username: uname}, {
    //     weather:
    //             {
    //                 temperature: datafromMQTT.besttimetemp,
    //                 windSpeed: datafromMQTT.besttimewspd,
    //                 humidity: datafromMQTT.besttimehumidity,
    //                 timeToDry: datafromMQTT.waitforhowmanyhours
    //             }
    // }, (err,user) => {
    //     if (err){ 
    //         console.log(err) 
    //     } 
    //     else{ 
    //         console.log("Updated Data Successfully");
    //     } 
    // });
    console.log("the name is"+uname);
    dataB.updateOne({ Username: uname },  {
                        temperature: datafromMQTT.besttimetemp,
                        windSpeed: datafromMQTT.besttimewspd,
                        humidity: datafromMQTT.besttimehumidity,
                        timeToDry: datafromMQTT.waitforhowmanyhours
                    }, function (erro, user) {
        if (erro) {
            console.log('Failure'+erro);
        }
        else {
           // console.log(updateusername);
            console.log("Location Updated");
            //console.log(loginqs);
        }
});
});
  
  


app.set('port', process.env.PORT || 3000);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(express.static(__dirname + '/'));

app.get('/', (req, res) => { 
	// if(req.session.page_views){
    //     req.session.page_views++;
    //     res.send("Welcome Back!");
    //     } else {
    //     req.session.page_views = 1;
    //     res.send("Hello! We hope you will enjoy it")
    //     }
    
    res.send("Welcome!");
});
app.get('/start', (req,res)=>{
    console.log("Init Node Red")//to initiate node red and start receiving data
    //window.location.href = "127.0.0.1:1880/start"
    res.redirect("http://127.0.0.1:1880/start");
});
app.get('/start/location', (req,res)=>{
    //start injecting node red whenver this route is called
    //using lat and long
    var latlong={
        latitude:{},
        longitude:{}
    };
    var options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
      };
      
      function success(pos) {
        latlong ={
            latitude: pos.coords.latitude,
            longitude: pos.coords.longitude
        }

      }
      
      function error(err) {
        console.warn(`ERROR(${err.code}): ${err.message}`);
      }
      
      navigator.geolocation.getCurrentPosition(success, error, options);
    res.type('json');
    console.log(latlong);
    res.send(latlong);
});
app.get("/login", function (req, res) {

    res.redirect("login.html");
});

app.get("/register", function (req, res) {

    res.redirect("register.html");
});
app.get("/start/checkCurrentTime", function (req, res) {

    var temp = req.query.temperature;
    var hum = req.query.humidity;
    var wspd = req.query.windSpeed;
    var desc = req.query.description;
    var time = new Date.now();


    if (temp <= 15 || hum >= 65 || desc == "Rain"){
        res.send("Not a suitable time to dry cloth");
    } else {
        if (wspd >= 5){
            dataB.updateOne({Username: uname}, {
          
                        
                            temperature: temp,
                            windSpeed: wspd,
                            humidity: hum,
                            timeToDry: (Date.now()+(2*60*60*1000))
                        
            }, (req,res) => {
                if (err){ 
                    console.log(err) 
                } 
                else{ 
                    console.log("Updated Data Successfully"); 
                } 
            });
           // res.send("Requierd time is two hours!");
        }
        else if (wspd <= 2){
            dataB.updateOne({Username: uname}, {
           
                            temperature: temp,
                            windSpeed: wspd,
                            humidity: hum,
                            timeToDry: (Date.now()+(4*60*60*1000))
            }, (req,res) => {
                if (err){ 
                    console.log(err) 
                } 
                else{ 
                    console.log("Updated Data Successfully"); 
                } 
            });
            //res.send("Requierd time is four hours!");
        }
        else{
            var tmp = Date.now()+(3*60*60*1000);
            var tw= {
                temperature: temp,
                windSpeed: wspd,
                humidity: hum,
                timeToDry: tmp
            }
            dataB.updateOne({Username: uname}, {

                            temperature: temp,
                            windSpeed: wspd,
                            humidity: hum,
                            timeToDry: tmp
            }, (req,res) => {
                if (err){ 
                    console.log(err) 
                } 
                else{ 
                    console.log("Updated Data Successfully"); 
                    mqclient.send('project/time',`${tmp}`);
                    mqclient.send('project/bestweather',`${tw}`);
                } 
            });
            //res.send("Requierd time is three hours!");
        }
    }

});

app.get("/start/checkNextFour", function (req, res) {
  
    var temp = [req.query.h1.temperature,req.query.h2.temperature,req.query.h3.temperature,req.query.h4.temperature];
    var hum  = [req.query.h1.humidity,req.query.h2.humidity,req.query.h3.humidity,req.query.h4.humidity];
    var wspd = [req.query.h1.windSpeed,req.query.h2.windSpeed,req.query.h3.windSpeed,req.query.h4.windSpeed];
    var time = [req.query.h1.dt,req.query.h2.dt,req.query.h3.dt,req.query.h4.dt];
  
    maxtemp=temp[0];
    minhum=hum[0];
    maxwspd=wspd[0];
  
  


   function getmaxandmin()  
  {
    for (var i=0;i<4;i++)
    {
        if (temp[i]>maxtemp)
            maxtemp=temp[i]; //highest temp over the next 4 hours
        if (hum[i]<minhum)
            minhum=hum[i];  //lowest humidity over the next 4 hours
        if (wspd[i]>maxwspd)        
          {  maxwspd=wspd[i]; //highest windspeed over the next 4 hours 
             bt=i; 
          }
    }
    return bt;
  }
  
  var besttime=getmaxandmin();
  
  //if the weather condition are not suitable, send a message
  if (maxtemp <= 15 || minhum >= 65 || desc == "Rain" ||!dt){
    res.send("Not a suitable time to dry cloth");
  } 
  else //we update our database
  {
      var w = {
        temperature: temp[besttime],
        windSpeed: wspd[besttime],
        humidity: hum[besttime],
        timeToDry: time[besttime]
      }
    dataB.updateOne({Username: uname}, {

                    temperature: temp[besttime],
                    windSpeed: wspd[besttime],
                    humidity: hum[besttime],
                    timeToDry: time[besttime]
                
    }, (req,res) => {
        if (err){ 
            console.log(err) 
        } 
        else{ 
            console.log("Updated Data Successfully");
            mqclient.send('project/time',`${time[besttime]}`);
            mqclient.send('project/bestweather',`${w}`);


        } 
    });
    
  
  }
  
  })
app.post("/login", urlencodedParser, async function (req, res) {
    console.log(req.body.username);
    dataB.findOne({ Username: req.body.username },  async function (erro, user) {
        if (erro) {
            console.log('Failure'+erro);
        }
        else {
            console.log("the password is "+user.password);
            const samepass = await bcrypt.compare(req.body.password,user.password);
            if (samepass) {
                // we go to the main page from here -------------------                        
                        res.redirect("/start");
                        uname =user.username;
                        return;
                    }
                    
                }
        
});

});

app.post("/register", urlencodedParser ,  async function (req, res) {
    console.log(req.body.username);
    var user = await dataB.findOne({ Username: req.body.username });
    if (user) {
        console.log("Oops..User already exists!");
        res.redirect("/login.html");

    } else {
        console.log("New");
        const salt =  await bcrypt.genSalt(10);
        req.body.password = await bcrypt.hash(req.body.password, salt);
        function uuid() {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
              var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
              return v.toString(16);
            });
          }
          
          var useRID=uuid();//something like: "ec0c22fa-f909-48da-92cb-db17ecdb91c5" 
        
        
        user = new dataB({userID: useRID,
            email:req.body.email,
            password: req.body.password,
            Username: req.body.username
        });

                uname = req.body.username; 
                user.save();

        console.log("New User Added.");
        //res.send("");
        res.redirect('/start');
    }
});

app.get('/start/sensors', (req, res) =>{
    //var msg = {data:sendthis};
    res.send(sendthis);
    console.log("this is a try, "+sendthis);
});
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
  })

// app.get('/weather/user/:user/:latlon', async (request, response) => {
//     console.log(request.params);
//     const latlon = request.params.latlon.split(',');
//     console.log(latlon);
//     const lat = latlon[0];
//     const lon = latlon[1];
//     console.log(lat, lon);
//     const api_key = process.env.API_KEY;
//     const weather_url = `api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${api_key}`;
    
//     const weather_response = await fetch(weather_url);
//     const weather_data = await weather_response.json();
//     response.json(weather_data);
//     Db.updateOne({userID: req.params.user},{
//         current:{
//             currentLatitude: lat,
//             currentLongitude:lon,
//             temperature: weather_data.main.temp,
//             windSpeed: weather_data.wind.speed,
//             CurrentDate: new Date.now()
//         }
//     }, (err, docs)=>{
//         if (err){ 
//             console.log(err) 
//         } 
//         else{ 
//             console.log("Updated Docs : ", docs); 
//         } 
//     });
//   });

client.connect(5555, '192.168.1.138', function() 
{
    console.log("connected to the logger");

});


client.on('data', function(data) 
{
    try{
        
    var sensor = JSON.parse(data.toString());
        console.log(sensor);
      //console.log("the accelerometer reading is :"+sensor.accelerometer.value);
        //if (acc.accelerometer.value[1] > value_which_we_need_to_test_and_find)//[1] x-axis [2] y-axis [0] z-axis 
        //console.log("the light is:"+sensor.light.value);

        if ( (sensor.accelerometer.value[1]>2.5) ||(sensor.accelerometer.value[1]<-1)||(sensor.accelerometer.value[2]>8)||(sensor.accelerometer.value[2]<7) )
          {  //console.log("stop moving");
             sendthis="stop moving";
             
        }
        else
            {
                    if (sensor.light.value<10)
                       {   // console.log("lighting is bad for drying cloths");
                            sendthis="bad lighting";
                        }
                    else
                    {
                        console.log("lighting is good for drying cloths");
                        sendthis="good lighting";
                        
                    }    
        }

      //  res.send(sendthis);
 
}  
catch(err){
    console.log(err.message);}
});