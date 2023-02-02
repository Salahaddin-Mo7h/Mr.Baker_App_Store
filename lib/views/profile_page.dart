import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_baker/core/color.dart';
import 'package:mr_baker/core/constant.dart';
import 'package:mr_baker/views/widgets/edit_address_dialog.dart';
import 'package:mr_baker/views/widgets/user_address.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
            height: screenSize.height * 1.3,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Get.back(),
                    ),
                    const Spacer(),
                    const Text(
                      'My profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                //user profile card
                Container(
                  width: screenSize.width,
                  margin: EdgeInsets.only(top: screenSize.height * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        width: screenSize.width,
                        height: screenSize.height * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FirebaseAuth.instance.currentUser!.displayName!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    FirebaseAuth.instance.currentUser!.email!,
                                    style: TextStyle(
                                      color: greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //user address
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(userUid).get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return Container(
                      width: screenSize.width,
                      margin: EdgeInsets.only(top: screenSize.height * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Address Detail',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              EditAdressDialog(
                                snapshot: snapshot,
                                nameController: nameController,
                                addressController: addressController,
                                noHpController: noHpController,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            padding: const EdgeInsets.all(20.0),
                            width: screenSize.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                              child: Column(
                                children: [
                                  Address(
                                    screenSize: screenSize,
                                    addressText: snapshot.data!['displayName'],
                                  ),
                                  Address(
                                    screenSize: screenSize,
                                    addressText: (snapshot.data!['address'] == '') ? 'khartoum 12217' : snapshot.data!['address'],
                                  ),
                                  Address(
                                    screenSize: screenSize,
                                    addressText: (snapshot.data!['no_handphone'] == '') ? ' 09123456789 ' : snapshot.data!['no_handphone'],
                                    isBottom: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
