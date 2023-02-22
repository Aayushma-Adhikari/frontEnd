import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class secondscreen extends StatefulWidget {
  const secondscreen({super.key});

  @override
  State<secondscreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<secondscreen> {
  // ignore: non_constant_identifier_names
  final _textcontroller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _textcontroller1 = TextEditingController();
  File? selectedImage;
  String base64Image = "";
  String output = 'Initial';
  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  String userposts = '';
  String userpost = '';
  String url = '';
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Encode"), backgroundColor: Color(0xFF0C2A2A)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 60,
              // ignore: prefer_const_constructors
              backgroundColor: Color.fromARGB(0, 6, 3, 2),
              child: Padding(
                padding: const EdgeInsets.all(8), // Border radius
                child: ClipOval(
                    child: selectedImage != null
                        ? Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )
                        : Image.network(
                            'https://t4.ftcdn.net/jpg/04/81/13/43/360_F_481134373_0W4kg2yKeBRHNEklk4F9UXtGHdub3tYk.jpg',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                chooseImage("camera");
              },
              child: const Text(" Image from Camera"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0C2A2A),
                  padding: const EdgeInsets.all(8)),
            ),
            ElevatedButton(
              onPressed: () {
                chooseImage("Gallery");
              },
              child: const Text("Image from Gallery"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0C2A2A),
                  padding: const EdgeInsets.all(8)),
            ),
            const SizedBox(height: 8),
            TextField(
                controller: _textcontroller1,
                onChanged: (value) {
                  userposts = value;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Message',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textcontroller1.clear();
                      },
                      padding: const EdgeInsets.all(8),
                      icon: const Icon(Icons.clear),
                    ))),
            const SizedBox(height: 8),
            TextField(
                controller: _textcontroller,
                onChanged: (value) {
                  userpost = value;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Secret Key',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textcontroller.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ))),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  String apiUrl = "http://127.0.0.1:3789/encode";

                  String image = base64Image;
                  var response = await http.post(
                    Uri.parse(apiUrl),
                    body: jsonEncode({
                      'text_to_encode': userpost,
                      'password': userposts,
                      'image_path': image
                    }),
                    headers: {'Content-Type': 'application/json'},
                  );
                  print(userpost);
                  print(userposts);
                  print(image);
                  if (response.statusCode == 200) {
                    var encodedData = jsonDecode(response.body);
                    setState(() {
                      output = encodedData['encoded_image'].toString();

                      encodedData['encoded_image'].toString();
                      print('sucessful');
                      print(response.body);
                    });
                  } else {
                    print('error');
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C2A2A),
                    padding: const EdgeInsets.all(8)),
                child: (const Text('Encode'))),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  print(_textcontroller1.text);
                  print(userpost);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C2A2A),
                    padding: const EdgeInsets.all(8)),
                child: (const Text('Save'))),
          ],
        ),
      ),
      // ignore: prefer_const_constructors
    );
  }
}
