import 'dart:html';
import 'dart:web_gl';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Login extends StatefulWidget{
  const Login ({Key? key}) : super(key:key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    title :
    'First App';
    return Scaffold(
      appBar: AppBar(
      //leading: Icon(Icons.home),
      title: Text('Visi Generasi Indonesia'),
      ), //AppBar
      body: SingleChildScrollView(
        child: container(
          Color: colors.redAccent,
          height: MediaQuery.of(context).size.height,
          child: center(
            child:column(
              mainAxisAligment:MainAxisAligment.center,
              children: [
                Text(
                  'Login Area-Security System',
                  style:
                  TextStyle(fontsize: 22, fontweight:fontweight.w500),
                ), //Text
                SizedBox(height:20), //awal script textfield email
                Center(
                  child: Form(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name : "email";
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(),
                              labelText: "Email"), //InputDecoration
                          ), //FormBuilderTextField

                          //awal script textfield password
                          SizedBox(
                            height:20,
                          ), //SizedBox
                          FormBuilderTextField(
                            obscureText:
                            true, //buat bikin stiap input jd bintang
                            name: "password",
                            controller: passwordCntroller,

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left:10),
                              border: OutlineInputBorder(),
                              labelText: "Password"),//InputDecoration
                          ), //akhir script textfield password //FormulaBuilderTextField 
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
