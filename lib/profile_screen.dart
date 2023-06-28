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
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Center(
                  child: ref.watch(profileViewModel).loading == false
                      ? Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: ref.watch(profileViewModel).image == null
                              ? ClipOval(
                                  child: Image.network(
                                    ref.watch(profileViewModel).imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/user_icon.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(ref
                                        .watch(profileViewModel)
                                        .image!
                                        .path),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/user_icon.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        )
                      : const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(profileViewModel).pickImage(context);
                },
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                ref.read(profileViewModel).deleteProfilePhoto(context);
              },
              child: const Text('Delete Profile Photo')),
        ],
      ),
    );
  }
}
