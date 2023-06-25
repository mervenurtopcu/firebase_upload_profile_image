import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
class ProfileViewModel extends ChangeNotifier {

  final picker  = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);

    if(pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
    }

  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);

    if(pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
    }
  }
  void pickImage(context) {
    showDialog(context: context,
        builder: (BuildContext context) => AlertDialog(
      title: const Text('Choose an option'),
      content: Container(
    height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                pickCameraImage(context);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
            ),
            ListTile(
              onTap: () {
                pickGalleryImage(context);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
            ),
          ],
        ),
    ),
    ));
  }
}
final profileViewModel =
ChangeNotifierProvider((ref) => ProfileViewModel());