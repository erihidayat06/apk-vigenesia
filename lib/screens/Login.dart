//import '/../Constant/const.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dio/dio.dart';
import 'package:org/Constant/const.dart';
import 'MainScreens.dart';
import 'Register.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import '/../Models/Login_Model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? nama;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

// Fungsi Login
  Future<LoginModels?> postLogin(String email, String password) async {
    var dio = Dio();
    String baseurl =
        url; // ganti dengan IP address kamu / tempat kamu menyimpan backend

    Map<String, dynamic> data = {"email": email, "password": password};

    try {
      final Response response = await dio.post(
        "$baseurl/api/login/",
        data: data,
        options: Options(headers: {'Content-type': 'application/json'}),
      );

      print("Response -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        final loginModel = LoginModels.fromJson(response.data);
        return loginModel;
      } else {
        // Jika responsenya tidak 200 OK, mungkin kamu ingin melakukan sesuatu di sini.
        // Contohnya, menampilkan pesan kesalahan atau melempar exception.
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed To Load $e");
      // Jika terjadi kesalahan selama request, kamu bisa melakukan sesuatu di sini.
      // Contohnya, menampilkan pesan kesalahan atau melempar exception.
    }

    return null; // Mengembalikan null jika terjadi kesalahan.
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // <-- Berfungsi Untuk  Bisa Scroll
        child: SafeArea(
          // < -- Biar Gak Keluar Area Screen HP
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Security System-Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50), // <-- Kasih Jarak Tinggi : 50px
                Center(
                  child: Form(
                    key: _fbKey,
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
                                labelText: "Email"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            obscureText:
                                true, // <-- Buat bikin setiap inputan jadi bintang " * "
                            name: "password",
                            controller: passwordController,

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Dont Have Account ? ',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                TextSpan(
                                    text: 'Sign Up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new Register()));
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                var result = await postLogin(
                                  emailController.text,
                                  passwordController.text,
                                );

                                if (result != null) {
                                  setState(() {
                                    nama = result.data?.nama;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MainScreens(nama: nama!),
                                      ),
                                    );
                                  });
                                } else {
                                  Flushbar(
                                    message: "Check Your Email / Password",
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.redAccent,
                                    flushbarPosition: FlushbarPosition.TOP,
                                  ).show(context);
                                }
                              },
                              child: Text("Sign In"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
