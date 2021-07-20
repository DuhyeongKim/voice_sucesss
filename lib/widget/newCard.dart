import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:crud_project/constants/controller.dart';
import 'package:crud_project/models/note.dart';
import 'package:crud_project/models/room.dart';
import 'package:crud_project/screens/chatRoom.dart';
import 'package:crud_project/screens/chatroom2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NewCard extends StatefulWidget {
  const NewCard({Key? key}) : super(key: key);

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {

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
    return Obx(() => ListView(
      children: audioController.channels.map((RoomModel room){
        return Column(
          children : [

            // ToggleButtons(
            //   borderRadius: BorderRadius.circular(15),
            //   borderWidth: 2,
            //   borderColor: Colors.black,
            //   selectedBorderColor: Colors.black,
            //   selectedColor: Colors.white,
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.87 / 2,
            //       padding: EdgeInsets.all(8),
            //       child: Center(
            //         child: Text('Audience',
            //             style: TextStyle(color: Colors.black)),
            //       ),
            //     ),
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.87 / 2,
            //       padding: EdgeInsets.all(8),
            //       child: Center(child: Text('Broadcaster')),
            //     ),
            //   ],
            //   onPressed: (int index) {
            //     setState(() {
            //       for (int i = 0; i < isSelected.length; i++) {
            //         isSelected[i] = i == index;
            //       }
            //       selectedPage = index;
            //     });
            //     if (selectedPage == 0) {
            //       setState(() {
            //         _role = ClientRole.Audience;
            //       });
            //     } else {
            //       setState(() {
            //         _role = ClientRole.Broadcaster;
            //       });
            //     }
            //     print(selectedPage);
            //   },
            //   fillColor: Colors.grey,
            //   isSelected: isSelected,
            // ),
            TextButton(
              onPressed :(){
                audioController.joinChannel(room.channel!);
                Get.to(()=>ChatRoom(_role));
        },
              child : Text(room.channel!),
            ),
        ],
      );
      },
    ).toList()),
    );
  }
}
