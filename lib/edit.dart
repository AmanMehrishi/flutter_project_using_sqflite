import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task1/mainprofile.dart';
import 'package:task1/user.dart';
import 'package:task1/userpreferences.dart';
import 'package:task1/appbar_widget.dart';
import 'package:task1/button_widget.dart';
import 'package:task1/profile_widget.dart';
import 'package:task1/textfield_widget.dart';
import 'package:path/path.dart' as Path;
import 'package:task1/utils/database_helper.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DatabaseHelper helper = DatabaseHelper();
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController int1Controller = TextEditingController();
  TextEditingController int2Controller = TextEditingController();
  TextEditingController int3Controller = TextEditingController();
  TextEditingController aboutController = TextEditingController();


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
    child: Builder(
      builder: (context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: 'image/propic.png',
              isEdit: true,
              onClicked: () async {
                final image = await ImagePicker()
                    .pickImage(source: ImageSource.gallery);

                if (image == null) return;

                final directory = await getApplicationDocumentsDirectory();
                final name = Path.basename(image.path);
                final imageFile = File('${directory.path}/$name');
                final newImage =
                await File(image.path).copy(imageFile.path);


              },
            ),
            const SizedBox(height: 24),
        TextField(
          controller: nameController,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          onChanged: (value) {
            debugPrint('Something changed in Title Text Field');
            updateName();
          },
          decoration: InputDecoration(
              labelText: 'Full Name',

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),
            const SizedBox(height: 24),
            TextField(
              controller: int1Controller,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              onChanged: (value) {
                debugPrint('Something changed in Interest 1 Text Field');
                updateInt1();
              },
              decoration: InputDecoration(
                  labelText: 'Enter Interest 1',

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
            const SizedBox(height: 24,),
            TextField(
              controller: int2Controller,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              onChanged: (value) {
                debugPrint('Something changed in Interest 2 Text Field');
                updateInt2();
              },
              decoration: InputDecoration(
                  labelText: 'Enter Interest 2',

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
            const SizedBox(height: 24,),
            TextField(
              controller: int3Controller,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              onChanged: (value) {
                debugPrint('Something changed in Interest 3 Text Field');
                updateInt3();
              },
              decoration: InputDecoration(
                  labelText: 'Enter Interest 3',

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: aboutController,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              onChanged: (value) {
                debugPrint('Something changed in About Text Field');
                updateAbout();
              },
              decoration: InputDecoration(
                  labelText: 'Enter Description',

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
              child: Text(
                'Save',
                textScaleFactor: 1.5,
              ),
              onPressed: () {
                setState(() {
                  debugPrint("Save button clicked");
                  _save();
                });
              },
            ),
          ],
        ),
      ),
    ),
  );

  void updateName()
  {
    user?.name = nameController.text;

  }
  void updateAbout()
  {
    user?.about = aboutController.text;
  }
  void updateInt1()
  {
    user?.interest1 = int1Controller.text;
  }
  void updateInt2()
  {
    user?.interest2 = int2Controller.text;
  }
  void updateInt3()
  {
    user?.interest3 = int3Controller.text;
  }

  void _save() async
  {
    Navigator.pop(context,true);
    int result;

    if(user?.id != null)
      {
        result = await helper.updateProfile(user!);
      }else{
      result = await helper.insertProfile(user!);
    }

    if(result != 0)
      {
        _showAlertDialog('Status', 'Profile Updated Successfully');
      }
    else{
      _showAlertDialog('Status', 'Problem Updating Profile');
    }
    
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}