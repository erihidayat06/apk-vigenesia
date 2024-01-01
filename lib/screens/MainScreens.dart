import 'dart:convert';

import 'package:org/Constant/const.dart';

import '/../Models/Motivasi_Model.dart';
import '/../Screens/EditPage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'Login.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;

class MainScreens extends StatefulWidget {
  final String? nama;
  const MainScreens({Key? key, this.nama}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  String baseurl =
      url; // ganti dengan ip address kamu / tempat kamu menyimpan backend
  String? id;
  var dio = Dio();
  TextEditingController titleController = TextEditingController();

// Upload data Motivasi
  Future<dynamic> sendMotivasi(String isi) async {
    try {
      Map<String, dynamic> data = {
        "isi_motivasi": isi,
      };

      var response = await dio.post('$baseurl/api/dev/POSTmotivasi',
          data: data,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));

      print("Response -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("Error: ${response.statusCode}");
        throw Exception(
            'Failed to send motivation - Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error during sending motivation: $e');
      throw Exception('Failed to send motivation - $e');
    }
  }

  List<MotivasiModel> listproduk = [];

// Mengambil data motivasi dari database
  Future<List<MotivasiModel>> getData() async {
    try {
      var response = await dio.get('$baseurl/api/Get_motivasi/');

      print("${response.data}");

      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        var listMotivasi =
            getUsersData.map((i) => MotivasiModel.fromJson(i)).toList();
        return listMotivasi;
      } else {
        print("Error: ${response.statusCode}");
        throw Exception(
            'Failed to load - Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error during data retrieval: $e');
      throw Exception('Failed to load - $e');
    }
  }

// Hapus Motivasi
  Future<Map<String, dynamic>?> deletePost(String id) async {
    try {
      Map<String, dynamic> data = {"id": id};

      var response = await dio.delete(
        '$baseurl/api/dev/DELETEmotivasi',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("---> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("Error: ${response.statusCode}");
        throw Exception(
            'Failed to update - Server returned ${response.statusCode}');
      }
    } catch (e) {
      print('Error during update: $e');
      throw Exception('Failed to update - $e');
    }
  }

// List data
  Future<void> _getData() async {
    try {
      var data = await getData();
      setState(() {
        listproduk = data;
      });
    } catch (e) {
      print('Error during data retrieval: $e');
      // handle the error as needed
    }
  }

  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // <-- Berfungsi Untuk  Bisa Scroll
        child: SafeArea(
          // < -- Biar Gak Keluar Area Screen HP
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // <-- Berfungsi untuk  atur nilai X jadi tengah
                  children: [
                    SizedBox(
                      height: 40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hallo  ${widget.nama}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            child: Icon(Icons.logout),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Login()));
                            })
                      ],
                    ),

                    SizedBox(height: 20), // <-- Kasih Jarak Tinggi : 50px
                    FormBuilderTextField(
                      controller: isiController,
                      name: "isi_motivasi",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              var response = await sendMotivasi(
                                  isiController.text.toString());

                              if (response != null) {
                                Flushbar(
                                  message: "Berhasil Submit",
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.greenAccent,
                                  flushbarPosition: FlushbarPosition.TOP,
                                ).show(context);
                                _getData();
                              } else {
                                // Handle jika response == null
                                print(
                                    "Gagal mengirim motivasi. Response is null.");
                              }
                            } catch (error) {
                              // Handle kesalahan selama pengiriman motivasi
                              print("Error during submission: $error");
                              Flushbar(
                                message: "Gagal Submit: $error",
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.redAccent,
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            }
                          },
                          child: Text("Submit"),
                        )),

                    SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {
                        _getData();
                      },
                    ),
                    FutureBuilder(
                        future: getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<MotivasiModel>> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                for (var item in snapshot.data!)
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(item.isiMotivasi.toString()),
                                              Row(
                                                children: [
                                                  TextButton(
                                                    child: Icon(Icons.settings),
                                                    onPressed: () {
                                                      String id;
                                                      String isi_motivasi;
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                EditPage(
                                                                    id: item.id,
                                                                    isi_motivasi:
                                                                        item.isiMotivasi),
                                                          ));
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Icon(Icons.delete),
                                                    onPressed: () async {
                                                      try {
                                                        var value =
                                                            await deletePost(
                                                                item.id!);
                                                        if (value != null) {
                                                          Flushbar(
                                                            message:
                                                                "Berhasil Delete",
                                                            duration: Duration(
                                                                seconds: 2),
                                                            backgroundColor:
                                                                Colors
                                                                    .redAccent,
                                                            flushbarPosition:
                                                                FlushbarPosition
                                                                    .TOP,
                                                          ).show(context);
                                                          _getData(); // Panggil _getData setelah penghapusan berhasil
                                                        } else {
                                                          // Handle jika value == null
                                                          print(
                                                              "Gagal menghapus. Response is null.");
                                                        }
                                                      } catch (error) {
                                                        print(
                                                            "Error during deletion: $error");
                                                        Flushbar(
                                                          message:
                                                              "Gagal Delete: $error",
                                                          duration: Duration(
                                                              seconds: 5),
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          flushbarPosition:
                                                              FlushbarPosition
                                                                  .TOP,
                                                        ).show(context);
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isEmpty) {
                            return Text("No Data");
                          } else {
                            return CircularProgressIndicator();
                          }
                        })
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
