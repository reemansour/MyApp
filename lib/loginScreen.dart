import 'dart:convert';

import 'package:Project/homeScreen.dart';
import 'package:Project/main.dart';
import 'package:Project/response_model.dart';
import 'package:Project/send_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Data.dart';
import 'package:http/http.dart' as http;
import 'routes.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  First_screen createState() => First_screen();
}

class First_screen extends State<FirstScreen> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<Response_Model> future;

  Response_Model obj = Response_Model();

  Future<Response_Model> sendData(Send_Data SData) async {
    try {
      final response = await http.post(
        ///lookup server
        Uri.parse('https://reqres.in/api/users?page=2'),

        ///send data
        body: SData.toJson(),
      );
      print('status code: ${response.statusCode}');
      print('Response Model ${jsonDecode(response.body)}');
      setState(() {
        return obj = Response_Model.fromJson(jsonDecode(response.body));
      });
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String data = 'screen Argument';
    return Scaffold(
      appBar: AppBar(
        title: Text('First App'),
        backgroundColor: Colors.red[800],
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Data Not Found'));
                } else
                  return PageView(
                      controller: PageController(),
                      children:[
                     Padding(

                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: [
                            Container(
                              height: 200,
                                width: 200,
                                color: Colors.transparent,
                                padding: EdgeInsets.all(10),
                                 child: Image.asset('assets/ShoppinCart.png')
                          ),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'User Name',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                //forgot password screen
                              },
                              textColor: Colors.blue,
                              child: Text('Forgot Password'),
                            ),
                            Container(
                                height: 50,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  child: Text('Login'),
                                  onPressed: () {
                                    print(nameController.text);
                                    print(passwordController.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MainScreen()));
                                  },
                                )),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Text('Does not have account?'),
                                FlatButton(
                                  textColor: Colors.blue,
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {

                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ))
                          ],
                        )),
                            ]
                  );
            }
          }),
    );
  }
}
