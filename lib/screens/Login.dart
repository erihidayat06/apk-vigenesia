import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    title:
    'First App';
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.home),
        title: Text('Visi Generasi Indonesia'),
      ), //AppBar
      body: SingleChildScrollView(
          child: Container(
              color: Colors.redAccent,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login Area-Security System',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ), //Text
                    SizedBox(height: 20), //awal script textfield email
                    Center(
                      child: Form(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: "email",
                                controller: emailController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: OutlineInputBorder(),
                                    labelText: "Email"), //InputDecoration
                              ), //FormBuilderTextField

                              //awal script textfield password
                              SizedBox(
                                height: 20,
                              ), //SizedBox
                              FormBuilderTextField(
                                obscureText:
                                    true, //buat bikin stiap input jd bintang
                                name: "password",
                                controller: passwordController,

                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    border: OutlineInputBorder(),
                                    labelText: "Password"), //InputDecoration
                              ), //akhir script textfield password //FormulaBuilderTextField

                              SizedBox(
                                height: 30,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Donct Have Account ?',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    TextSpan(
                                        text: 'Sign up',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new Register()));
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blueAccent))
                                  ],
                                ),
                              ),
                              SizedBox(height: 40),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    onPressed: () {
                                      //PINDAH KE HALAMAN SIMPLE
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new MainScreen()));
                                    },
                                    child: Text("Sign In")),
                              )
                            ],
                          ), //Column
                        ), //Awakhir script textfield emal //container
                      ), //form
                    ), //center
                  ],
                ), //Column
              ))), //Center //Container //SingleChildScrollView
    ); //Scaffold
  }
}
