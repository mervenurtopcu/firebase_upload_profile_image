import 'package:firebase_upload_profile_image/profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
         Stack(
           alignment: Alignment.bottomCenter,
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 13),
               child: Center(
                 child: Container(
                   height: 130,
                     width: 130,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(
                       color: Colors.black,
                     ),
                   ),
                   child: ClipOval(
                      child: ref.watch(profileViewModel).image != null
                          ? Image.file(
                        File(ref.watch(profileViewModel).image!.path).absolute,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/ic_person.jpg',
                        fit: BoxFit.cover,
                      ),
                   ),
                 ),
               ),
             ),
             InkWell(
               onTap: (){
                  ref.read(profileViewModel).pickImage(context);
               },
               child: CircleAvatar(
                 radius: 14,
                 backgroundColor: Colors.black,
                 child:Icon(Icons.add,size:18,color: Colors.white,),
               ),
             )
           ],
         )
        ],
      ),
    );
  }
}
