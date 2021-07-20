import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:crud_project/constants/controller.dart';
import 'package:crud_project/controllers/NotificationController.dart';
import 'package:crud_project/controllers/noteController.dart';
import 'package:crud_project/screens/cart.dart';
import 'package:crud_project/screens/chatRoom.dart';
import 'package:crud_project/theme/app_color_styles.dart';
import 'package:crud_project/widget/cardwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _userName = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int selectedPage = 0;
  late List<bool> isSelected;
  ClientRole _role = ClientRole.Audience;

  @override
  void initState() {
    isSelected = [false, true];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("홈"),
        actions: [
          IconButton(
            icon: Icon(Icons.cake),
            onPressed: () => Get.offAll(()=>Cart()),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              prefixIcon: Icon(Icons.laptop),
                              hintText: 'Channel Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Channel name is a required field';
                              } else {
                                return null;
                              }
                            },
                            controller: audioController.channelName,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              prefixIcon: Icon(Icons.person),
                              hintText: 'User Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'User name is a required field';
                              } else {
                                return null;
                              }
                            },
                            controller: _userName,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ToggleButtons(

                    borderRadius: BorderRadius.circular(15),
                    borderWidth: 2,
                    borderColor: Colors.black,
                    selectedBorderColor: Colors.black,
                    selectedColor: Colors.white,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.87 / 2,
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text('Audience',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.87 / 2,
                        padding: EdgeInsets.all(8),
                        child: Center(child: Text('Broadcaster')),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                        selectedPage = index;
                      });
                      if (selectedPage == 0) {
                        setState(() {
                          _role = ClientRole.Audience;
                        });
                      } else {
                        setState(() {
                          _role = ClientRole.Broadcaster;
                        });
                      }
                      print(selectedPage);
                    },
                    fillColor: Colors.grey,
                    isSelected: isSelected,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.16,
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                            onPressed:(){
                              //noteController.addList();
                              audioController.makeChannel();
                              audioController.addChannelToFirebase();
                              Get.offAll(()=>ChatRoom(_role),arguments:audioController.channelName.text);
                            } ,
                      child: Text(
                        'Join',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.16,
                    child: RaisedButton(
                      color: MyColor.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                            onPressed:(){
                              authController.signOut();
                            } ,
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),





      // body : Column(
      //   children: [
      //     TextField(
      //       controller: audioController.channelName,
      //     ),
      //     // TextField(
      //     //   controller : noteController.title,
      //     // ),
      //     TextButton(
      //       child : Text("등록"),
      //       onPressed:(){
      //         //noteController.addList();
      //         audioController.makeChannel();
      //         audioController.addChannelToFirebase();
      //         Get.to(()=>ChatRoom(),arguments:audioController.channelName.text);
      //       } ,
      //     ),
      //     TextButton(
      //       child : Text("로그아웃"),
      //       onPressed:(){
      //         authController.signOut();
      //       } ,
      //     ),
      //
      //     SizedBox(
      //       height : 30,
      //     ),
      //   ],
      // ),
    );
  }
}

