// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'mqtt.dart';
import 'Animation/FadeAnimation.dart';
/**import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:build_runner/build_runner.dart';**/
/* Sample Program to use the class */


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COE 457 Project Flutter Part',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void dispose() {
    print("dispose");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/light-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/light-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Username",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyMenuPage()),
                              );
                            },
                              child:FadeAnimation(2, Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ]
                                    )
                                ),
                                child: Center(
                                  child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              )),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyRegisterPage()),
                          );
                        },
                        child:FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Center(
                            child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      ),
                      SizedBox(height: 70,),
                      FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
class MyRegisterPage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //String title;

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/light-1.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/light-2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Username",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                        child:FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Center(
                            child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
class MyMenuPage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  //String title;

  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Menu.jpeg'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
            RaisedButton(
              color: Colors.lightGreen[300],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TempPage()),
                );
              },
              child: const Text('Weather Updates', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              color: Colors.lightGreen[300],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerInfoPage()),
                );
              },
              child: const Text('Timer for Drying Clothes', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              color: Colors.lightGreen[300],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              child: const Text('Best Drying Time', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              color: Colors.lightGreen[300],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LightPage()),
                );
              },
              child: const Text('Light Sensor', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Menu for Drying Clothes"),
        backgroundColor: Colors.green,
        shadowColor: Colors.greenAccent,
      ),
    );
  }
}

// ignore: must_be_immutable
class TempPage extends StatefulWidget {

  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {


  double getTempc=25.0;
  double windspeed=2.0;
  int hum=60;

  void _onMessage(String topic, String payload){
    print('my own onMessage '+topic+':'+payload);
    var object=json.decode(payload);
    print(object);
    getTempc=object['temperature'];
    windspeed=object['windSpeed'];
    hum=object['humidity'];
    print(getTempc);
    print(hum);
    print(windspeed);
  }

  MQTTClient cl;

  void setUpMQTT() async {
    // create an MQTT client.
    cl = new MQTTClient('192.168.4.197', '1883', _onMessage);
    await cl.connect();
  }


  void initState() {
    super.initState();
    setUpMQTT();
  }

  void dispose() {
    print("dispose");
    super.dispose();
  }

  void _update_get() async {

    setState(() {
      cl.subscribe('project/currentweather', MqttQos.atMostOnce);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Weather Conditions'),
        backgroundColor: Colors.deepOrange,
          shadowColor: Colors.deepOrangeAccent,
      ),
      body: Center (
        child: Card(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          const ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('Temperature: (in Celsius)', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ),
            Text(
              '$getTempc',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          const ListTile(
            leading: Icon(Icons.thermostat_outlined),
            title: Text('Humidity ( in %) ', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ),
            Text(
              '$hum',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.waves),
              title: Text('WindSpeed ( in m/s)', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            Text(
              '$windspeed',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.location_city),
              title: Text('City', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            Text(
              'Dubai',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          RaisedButton(
            onPressed: () {
              _update_get();
            },
            child: const Text('Update', style: TextStyle(fontSize: 20)),
          ),
          ]),
      ),
    ),
    ); // Pop from stack
  }
}
class TimerInfoPage extends StatefulWidget {
  @override
  _TimerInfoPageState createState() => _TimerInfoPageState();
}

class _TimerInfoPageState extends State<TimerInfoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Conditions and Time Taken'),
        backgroundColor: Colors.black,
        shadowColor: Colors.grey,
      ),
      body: Center (
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('Temp', style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
            ),
                DataColumn(
                  label: Text('Wind Speed', style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                ),
                DataColumn(
                  label: Text('Humidity', style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                ),
              ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('> 25 C = +60mins')),
                      DataCell(Text('> 2.0 m/s= -60mins')),
                      DataCell(Text('< 60 % = +60mins')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('< 25 C = +120mins')),
                      DataCell(Text('< 2.0 m/s= -30mins')),
                      DataCell(Text('> 60 % = +120mins')),
                    ],
                  ),
                  ],
            ),
              RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimerPage()),
                  );
                },
                child: const Text('Head on to Timer!', style: TextStyle(fontSize: 20),),
              ),
            ]),
      ),
    ); // Pop from stack
  }
  
}
class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>{
  //SecondPage({Key key, this.title}) : super(key: key);
  //final String title;
  int _counter=10;
  void _onMessage(String topic, String payload){
    print('my own onMessage '+topic+':'+payload);
    var object=json.decode(payload);
    _counter=object['time'];
    print(_counter);
  }

  MQTTClient cl;

  void setUpMQTT() async {
    // create an MQTT client.
    cl = new MQTTClient('192.168.4.197', '1883', _onMessage);
    await cl.connect();
  }


  void initState() {
    super.initState();
    // initialize MQTT
    setUpMQTT();
  }

  void dispose() {
    print("dispose");
    super.dispose();
  }
  //SecondPage({Key key, this.title}) : super(key: key);
  //final String title;
  void _update_get() async {
    setState(() {
      cl.subscribe('project/time', MqttQos.atMostOnce);
    });
  }
  Timer _timer;

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Page'),
        backgroundColor: Colors.black,
        shadowColor: Colors.grey,
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_counter > 0)
                ? Text("")
                : Text(
              "DONE! The cloth is dry",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents
                children: <Widget>[
                  Text(
                    '$_counter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    ' Minutes Left',
                      style: TextStyle(
                        fontSize: 48,
                  ),
                  ),
                ],
            ),
            RaisedButton(
              color: Colors.grey,
              onPressed: () => _startTimer(),
              child: Text("Add cloth for drying"),
            ),
            RaisedButton(
              color: Colors.grey,
              onPressed: () => _update_get(),
              child: Text("Update Timer Value"),
            ),
          ],
        ),
      )
    ); // Pop from stack
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>{
  //ThirdPage({Key key, this.title}) : super(key: key);
  //final String title;
  var get_tempc = '';
  var currtemp={};
  double besttemp;
  double bestwind;
  int minhum;
  int time;
  void _onMessage(String topic, String payload) {
    print('my own onMessage ' + topic + ':' + payload);
    var object = json.decode(payload);
    print(object);
    besttemp = object['besttimetemp'];
    minhum = object['minhumidity'];
    bestwind = object['besttimewspd'];
    time=object['waitforhowmanyhours'];
  }


  MQTTClient cl;

  void setUpMQTT() async {
    // create an MQTT client.
    cl = new MQTTClient('192.168.4.197', '1883', _onMessage);
    await cl.connect();
  }


  void initState() {
    super.initState();
    // initialize MQTT
    setUpMQTT();
  }

  void dispose() {
    print("dispose");
    super.dispose();
  }
  //SecondPage({Key key, this.title}) : super(key: key);
  //final String title;
  void _update_get() async {

    setState(() {
      get_tempc = '';
      cl.subscribe('project/bestweather', MqttQos.atMostOnce);
    });
  }
  @override
  Widget build (BuildContext context) {
    return  Scaffold(
        appBar:  AppBar(
          title: Text('Best Time to Dry in the Next 4 Hours!'),
          backgroundColor: Colors.deepPurple,
          shadowColor: Colors.deepPurpleAccent,
        ),
        body: Center(
        child: Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        const ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text('Highest Temperature:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          subtitle: Text('in C', style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
        ),
          Text(
              '$besttemp',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
          ),
        const ListTile(
        leading: Icon(Icons.thermostat_outlined),
        title: Text('Minimum Humidity', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        subtitle: Text('in %', style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
         ),
          Text(
            '$minhum',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          const ListTile(
              leading: Icon(Icons.waves),
              title: Text('Best WindSpeed', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              subtitle: Text('in m/s', style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
            ),
          Text(
            '$bestwind',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.waves),
            title: Text('Best Time', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            subtitle: Text('in ? hours from now: ', style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic)),
          ),
          Text(
            '$time',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
          ),
          RaisedButton(
            onPressed: () {
              _update_get();
            },
            child: const Text('Update', style: TextStyle(fontSize: 20)),
          ),
          ]),
          ),
        ),
    );// Pop from stack
  }
}
class LightPage extends StatefulWidget {
  @override
  _LightPageState createState() => _LightPageState();
}

class _LightPageState extends State<LightPage>
{
  String message='good lighting';
  void _onMessage(String topic, String payload) {
    print('my own onMessage ' + topic + ':' + payload);
    var object = json.decode(payload);
    print(object);
    message = payload;
    print(message);
  }

  MQTTClient cl;

  void setUpMQTT() async {
    // create an MQTT client.
    cl = new MQTTClient('192.168.4.197', '1883', _onMessage);
    await cl.connect();
  }

  void initState() {
    super.initState();
    // initialize MQTT
    setUpMQTT();
  }

  void dispose() {
    print("dispose");
    super.dispose();
  }
  //SecondPage({Key key, this.title}) : super(key: key);
  //final String title;
  void _update_get() async {

    setState(() {
      cl.subscribe('project/sensor', MqttQos.atMostOnce);
    });
  }
  Widget build (BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text('Light Sensor'),
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Card(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '$message',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                  ),
                ),
                RaisedButton(
                  color:Colors.deepPurple[200],
                  onPressed: () {
                    _update_get();
                  },
                  child: const Text('Update', style: TextStyle(fontSize: 20)),
                ),
              ]),
        ),
      ),
    );// Pop from stack
  }
}
