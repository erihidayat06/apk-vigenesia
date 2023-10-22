import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vigenesia/screens/Login.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register Your Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50),
                _Name(),
                SizedBox(height: 50),
                _Profesi(),
                SizedBox(height: 50),
                _Email(),
                SizedBox(height: 50),
                _Password(),
                SizedBox(height: 50),
                _tombolDaftar(),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _Name() {
    return TextFormField(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(),
          labelText: "Nama"),
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _Profesi() {
    return TextFormField(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(),
          labelText: "Profesi"),
      controller: profesiController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Profesi tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _Email() {
    return TextFormField(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(),
          labelText: "Email"),
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _Password() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(),
          labelText: "Password"),
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _tombolDaftar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()))
      }, child: Text("Daftar")),
    )
  }

}
