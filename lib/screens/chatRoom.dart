import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:crud_project/constants/controller.dart';
import 'package:crud_project/controllers/audioChatController.dart';
import 'package:crud_project/screens/UserView.dart';

import'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatRoom extends StatefulWidget {

  late ClientRole role;

  ChatRoom(this.role);
  //const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {


  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool _isLogin = false;
  bool _isInChannel = false;
  final _broadcaster = <String>[];
  final _audience = <String>[];
  final Map<int, String> _allUsers = {};

  //AgoraRtmClient _client;
  // AgoraRtmChannel _channel;
  // RtcEngine _engine;

  final buttonStyle = TextStyle(color: Colors.white, fontSize: 15);


  Widget _toolbar() {
    return widget.role == ClientRole.Audience
        ? Container()
        : Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Row(
              children: [
                Icon(
                  muted ? Icons.mic_off : Icons.mic,
                  color: muted ? Colors.white : Colors.blueAccent,
                  size: 20.0,
                ),
                SizedBox(
                  width: 5,
                ),
                muted
                    ? Text(
                  'Unmute',
                  style: buttonStyle,
                )
                    : Text(
                  'Mute',
                  style: buttonStyle.copyWith(color: Colors.black),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: (){
              audioController.dispose();
              audioController.removeChannelInFirebase();
              Get.back();
            },
            child: Row(
              children: [
                Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Disconnect',
                  style: buttonStyle,
                )
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    audioController.muteLocalAudioStream(muted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title : Text(audioController.channelName.text),
      ),
      body: SafeArea(
        child : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Broadcaster',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                // child: ListView.builder(
                //   itemCount: _users.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return _allUsers.containsKey(_users[index])
                //         ? UserView(
                //       userName: _allUsers[_users[index]],
                //       role: ClientRole.Broadcaster, key: null,
                //     )
                //         : Container();
                //   },
                // )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Audience',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Container(
            //     height: MediaQuery.of(context).size.height * 0.2,
            //     width: double.infinity,
            //     child: ListView.builder(
            //       itemCount: _allUsers.length - _users.length,
            //       // itemBuilder: (BuildContext context, int index) {
            //       //   return _users.contains(_allUsers.keys.toList()[index])
            //       //       ? Container()
            //       //       : UserView(
            //       //     role: ClientRole.Audience,
            //       //     userName: _allUsers.values.toList()[index],
            //       //   );
            //       // },
            //     )
            // ),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
