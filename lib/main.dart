import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(StatelessApp());
}

class StatelessApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatefulApp(),
    );
  }
}

class StatefulApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<StatefulApp> {
  final _textController = TextEditingController();
  var httpClient = http.Client();
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void sendEmail(String email) async {
    var response = await httpClient.post(Uri.http("10.0.2.2:8000", "/invite_email"),
        headers : {
          "Content-Type": "application/json",
          },
        body: jsonEncode({
          "email": email,
          "projectID": "example"
          })
        );
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      print(message['message']);
    } else
      print("Error with code ${response.statusCode}");
  }

  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(6, 89, 172, 1.0),
          Color.fromRGBO(23, 158, 230, 1.0),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          children: [
            Container(
                height: 106,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 20, top: 60),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {},
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12, left: 16, top: 49),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create Sub-Collab",
                              style: TextStyles.Heading_White),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "in \"Face Detection Project\"",
                                style: TextStyles.HierarchyIndicator_White,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 86,
                              height: 25,
                              margin: EdgeInsets.only(bottom: 20, right: 20),
                              child: FlatButton(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: Text(
                                    "Next",
                                    style: TextStyles.Button,
                                  ),
                                  color: Color(0xFF44B887),
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  )),
                            )))
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Text(
                      "Invite Participants to this Collab",
                      style: TextStyles.Heading_Black,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invite via E-mail",
                            style: TextStyles.Heading_Black_Reg,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                "Invite link will be sent to the person",
                                style: TextStyles.SubHeading_Grey,
                              )),
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 82,
                                height: 25,
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  color: Color(0xFF0F4C81),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    sendEmail(_textController.text);
                                    _textController.clear();
                                  },
                                  child: Text("Add",
                                      style:
                                          TextStyles.HierarchyIndicator_White),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                              )))
                    ],
                  ),
                  Container(
                    height: 24,
                    margin: EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: _textController,
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                          hintStyle: TextStyles.SubHeading_Grey,
                          hintText: "Enter E-mail address and click on Add"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      "Invite via Search",
                      style: TextStyles.Heading_Black_Reg,
                    ),
                  ),
                  Container(
                    height: 23,
                    margin: EdgeInsets.only(top: 16, bottom: 8),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 16.68,
                          ),
                          hintStyle: TextStyles.SubHeading_Grey,
                          hintText: "Search for a Profile Name"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                color: Colors.white,
                child: Divider(
                  height: 4,
                  thickness: 4,
                  color: Color(0x9996A7AF),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, right: 20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        "Invited Participants (7)",
                        style: TextStyles.Heading_Black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        '''Request to join will be sent to the following people.\nTap to Remove''',
                        style: TextStyles.SubHeading_Grey,
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: ListTile(
                            // dense: true,
                            // visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 22.5,
                              backgroundImage: NetworkImage(
                                  "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d0bc5131-9f3d-47bb-bfe5-0bb8077a4b67/ddbiyzr-a78f7e9b-f844-4ef4-9823-9d7d90164481.png/v1/fill/w_800,h_900,q_80,strp/nameless_king_by_tetramera_ddbiyzr-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD05MDAiLCJwYXRoIjoiXC9mXC9kMGJjNTEzMS05ZjNkLTQ3YmItYmZlNS0wYmI4MDc3YTRiNjdcL2RkYml5enItYTc4ZjdlOWItZjg0NC00ZWY0LTk4MjMtOWQ3ZDkwMTY0NDgxLnBuZyIsIndpZHRoIjoiPD04MDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.hHRBnzvvWf45ak1wuWEZ5dFJr5gMVp96xTHy91GUyW4"),
                            ),
                            title: Text(
                              "Nameless King",
                              style: TextStyles.ContactName,
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text("Dragonslayer at Unknown",
                                  style: TextStyles.ContactOccupation),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "God of War",
                                style: TextStyles.ContactPermission,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      color: Color(0xFF44B887), width: 1)),
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1,
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class TextStyles {
  static const Heading_White = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 18,
      color: Color(0xFFFDFDFD));
  static const HierarchyIndicator_White = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 12,
      color: Color(0xFFFDFDFD));
  static const Heading_Black = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 15,
      color: Color(0xFF3E3E3E));
  static const Heading_Black_Reg = TextStyle(
      fontFamily: "Proxima-Nova-Reg", fontSize: 15, color: Color(0xFF3E3E3E));
  static const Button = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 12,
      color: Color(0xFFFDFDFD));
  static const SubHeading_Grey = TextStyle(
      fontFamily: "Proxima-Nova-Reg", fontSize: 12, color: Color(0x483E3E3E));
  static const ContactName = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 16,
      color: Color(0xFF2E2E2E));
  static const ContactOccupation = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 13,
      color: Color(0xFF3E3E3E));
  static const ContactPermission = TextStyle(
      fontFamily: "Proxima-Nova-Semibold",
      fontSize: 13,
      color: Color(0xFF44B887));
}
