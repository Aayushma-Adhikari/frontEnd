import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class decryption extends StatefulWidget {
  const decryption({super.key});

  @override
  State<decryption> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<decryption> {
  // ignore: non_constant_identifier_names
  TextEditingController final_textcontroller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController sinal_textcontroller = TextEditingController();
  File? selectedImage;
  String base64Image = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Decode"), backgroundColor: Color(0xFF0C2A2A)),
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
                controller: final_textcontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Secret Key',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        final_textcontroller.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ))),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C2A2A),
                    padding: const EdgeInsets.all(8)),
                child: (const Text('Decode'))),
          ],
        ),
      ),
      // ignore: prefer_const_constructors
    );
  }
}
