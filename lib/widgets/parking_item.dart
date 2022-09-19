import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../widgets/pickers/globals.dart' as globals;
import 'package:sixth_app/screens/parking_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cams.dart';

var name;

class ParkingItem extends StatefulWidget {
  const ParkingItem({
    required Key key,
    required this.cams,
  }) : super(key: key);

  final Cams cams;

  @override
  _ParkingItemState createState() => _ParkingItemState();
}

class _ParkingItemState extends State<ParkingItem> {
  Color _bgColor = Colors.purple;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          widget.cams.server,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => null,
              )
            : IconButton(
                icon: const Icon(Icons.open_in_browser),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  var headers = {
                    'Accept': 'application/json',
                    'Authorization': 'Bearer <Bearer Token>'
                  };
                  var request = http.Request(
                      'POST',
                      Uri.parse(
                          'https://ucams.ufanet.ru/api/v0/auth/?username=72702363&password=6825392887&='));

                  request.headers.addAll(headers);

                  request.send().then((result) {
                    http.Response.fromStream(result).then((response) {
                      if (response.statusCode == 200) {
                        var jsonResponse = json.decode(response.body);
                        var nameError = jsonResponse['token'];
                        // var nameError1 = nameError['number'];
                        //print('name = ' + nameError);

                        name = nameError.toString();

                        return response.body;
                      } else {
                        print(response.reasonPhrase);
                      }
                    });
                  });

                  var headers_name = {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer ' + name
                  };
                  var request_name = http.Request(
                      'POST',
                      Uri.parse(
                          'https://ucams.ufanet.ru/api/v0/cameras/this/'));
                  request_name.body = json.encode({
                    "fields": ["timezone", "timezone", "server", "token_l"],
                    "numbers": [
                      "1592299916BKZ145",
                      "1592299899VPI519",
                      "1592299908WIS895"
                    ],
                    "order_by": "addr_asc",
                    "token_l_ttl": 3600,
                    "token_r_ttl": 3600,
                    "token_d_ttl": 3600,
                    "token_d_duration": 300,
                    "token_d_start": 77501582,
                    "token_label": ""
                  });
                  request_name.headers.addAll(headers_name);

                  request_name.send().then((result) {
                    http.Response.fromStream(result).then((response_name) {
                      if (response_name.statusCode == 200) {
                        // final Map<String, dynamic> productListData =
                        //     json.decode(response_name.body);

                        var jsonResponse = json.decode(response_name.body);
                        var nameRes = jsonResponse['results'];
                        var nameNum = nameRes[widget.cams.number]['number'];
                        var nameSer = nameRes[widget.cams.number]['server']
                            ['screenshot_domain'];
                        var nameTok = nameRes[widget.cams.number]['token_l'];
                        globals.link = 'http://' +
                            nameSer +
                            "/api/v0/screenshots/" +
                            nameNum +
                            ".jpg?token=" +
                            nameTok;

                        // var nameRes2 = nameRes1['number'];

                        print('link = ' + globals.link.toString());

                        // var result = jsonDecode(response_name.body);
                        // Map<String, dynamic>.from(result);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParkingScreen()));

                        return response_name.body;
                      } else {
                        print(response_name.reasonPhrase);
                      }
                    });
                  });

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ChatScreen()));
                }),
      ),
    );
  }
}
