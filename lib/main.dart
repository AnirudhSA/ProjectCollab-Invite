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
    var response =
        await httpClient.post(Uri.http("10.0.2.2:8000", "/invite_email"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({"email": email, "projectID": "example"}));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      print(message['message']);
    } else
      print("Error with code ${response.statusCode}");
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                height: height * 0.1413,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                          left: width * 0.0556,
                          bottom: height * 0.0267,
                          top: height * 0.08),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {},
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: height * 0.016,
                          left: width * 0.0444,
                          top: height * 0.0586),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create Sub-Collab",
                              style: TextStyles()
                                  .style(height, width, "heading_white")),
                          Container(
                              margin: EdgeInsets.only(top: height * 0.0106),
                              child: Text(
                                "in \"Face Detection Project\"",
                                style: TextStyles().style(height,width,"hierarchyindicator_white"),
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
                              width: width * 0.2388,
                              height: height * 0.0333,
                              margin: EdgeInsets.only(
                                  bottom: height * 0.0267,
                                  right: width * 0.0555),
                              child: FlatButton(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: Text(
                                    "Next",
                                    style: TextStyles().style(height, width, "button"),
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
              padding:
                  EdgeInsets.only(left: width * 0.0555, right: width * 0.0555),
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
                    padding: EdgeInsets.only(
                        top: height * 0.0213, bottom: height * 0.0213),
                    child: Text(
                      "Invite Participants to this Collab",
                      style: TextStyles().style(height, width, "heading_black"),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invite via E-mail",
                            style: TextStyles().style(height, width, "heading_black_reg"),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * 0.0106),
                              child: Text(
                                "Invite link will be sent to the person",
                                style: TextStyles().style(height, width, "subheading_grey"),
                              )),
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: width * 0.2278,
                                height: height * 0.0333,
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
                                      style: TextStyles()
                                          .style(height, width, "hierarchyindicator_white")),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                              )))
                    ],
                  ),
                  Container(
                    height: height * 0.032,
                    margin: EdgeInsets.only(top: height * 0.0106),
                    child: TextField(
                      controller: _textController,
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                          hintStyle: TextStyles().style(height, width, "subheading_grey"),
                          hintText: "Enter E-mail address and click on Add"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.0213),
                    child: Text(
                      "Invite via Search",
                      style: TextStyles().style(height, width, "heading_black_reg"),
                    ),
                  ),
                  Container(
                    height: height * 0.0307,
                    margin: EdgeInsets.only(
                        top: height * 0.0213, bottom: height * 0.0107),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: width * 0.0466,
                          ),
                          hintStyle: TextStyles().style(height, width, "subheading_grey"),
                          hintText: "Search for a Profile Name"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                color: Colors.white,
                child: Divider(
                  height: height * 0.0053,
                  thickness: height * 0.0053,
                  color: Color(0x9996A7AF),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: width * 0.0556, right: width * 0.0556),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height * 0.0213),
                      child: Text(
                        "Invited Participants (6)",
                        style: TextStyles().style(height, width, "heading_black"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: height * 0.0107, bottom: height * 0.0107),
                      child: Text(
                        '''Request to join will be sent to the following people.\nTap to Remove''',
                        style: TextStyles().style(height, width, "subheading_grey"),
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
                          padding: EdgeInsets.only(
                              left: width * 0.0556, right: width * 0.0556),
                          child: ListTile(
                            // dense: true,
                            // visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: width * 0.0625,
                              backgroundImage: NetworkImage(
                                  "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d0bc5131-9f3d-47bb-bfe5-0bb8077a4b67/ddbiyzr-a78f7e9b-f844-4ef4-9823-9d7d90164481.png/v1/fill/w_800,h_900,q_80,strp/nameless_king_by_tetramera_ddbiyzr-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD05MDAiLCJwYXRoIjoiXC9mXC9kMGJjNTEzMS05ZjNkLTQ3YmItYmZlNS0wYmI4MDc3YTRiNjdcL2RkYml5enItYTc4ZjdlOWItZjg0NC00ZWY0LTk4MjMtOWQ3ZDkwMTY0NDgxLnBuZyIsIndpZHRoIjoiPD04MDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.hHRBnzvvWf45ak1wuWEZ5dFJr5gMVp96xTHy91GUyW4"),
                            ),
                            title: Text(
                              "Nameless King",
                              style: TextStyles().style(height, width, "contact_name"),
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: height * 0.0133),
                              child: Text("Dragonslayer at Unknown",
                                  style: TextStyles().style(height, width, "contact_occupation")),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(width * 0.0083),
                              child: Text(
                                "God of War",
                                style: TextStyles().style(height, width, "contact_permission"),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      color: Color(0xFF44B887),
                                      width: width * 0.0028)),
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: height * 0.0013,
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
  style(double height, double width, String option) {
    switch (option) {
      case "heading_white":
        return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000067,
            color: Color(0xFFFDFDFD));

        case "hierarchyindicator_white" : return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000044,
            color: Color(0xFFFDFDFD));

        case "heading_black" : return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000059,
            color: Color(0xFF3E3E3E));

        case "heading_black_reg" : return TextStyle(
            fontFamily: "Proxima-Nova-Reg",
            fontSize: height * width * 0.000056,
            color: Color(0xFF3E3E3E));
        case "button" : return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000044,
            color: Color(0xFFFDFDFD));
        case "subheading_grey" : return TextStyle(
            fontFamily: "Proxima-Nova-Reg",
            fontSize: height * width * 0.000044,
            color: Color(0x483E3E3E));
        case "contact_name" : return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000059,
            color: Color(0xFF2E2E2E));
        case "contact_occupation" : return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000048,
            color: Color(0xFF3E3E3E));
        case "contact_permission" : return TextStyle(
            fontFamily: "Proxima-Nova-Semibold",
            fontSize: height * width * 0.000048,
            color: Color(0xFF44B887));
    }
  }
}
