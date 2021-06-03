import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  var l1 = [];
  var l2 = [];
  var l3 = [];
  var l4 = [];
  var loading = true;
  fetchData() async {
    setState(() {
      loading = true;
    });
    var url = "https://my-json-server.typicode.com/typicode/demo/posts";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = null;

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        data = jsonResponse;
      }
      for (var i = 0; i < jsonResponse.length; i++) {
        l1.add(jsonResponse[i]["id"]);
      }
      setState(() {
        l3 = l1;
      });
      for (var i = 0; i < jsonResponse.length; i++) {
        l2.add(jsonResponse[i]["title"]);
      }
      setState(() {
        l4 = l2;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: loading ? Center(child: CircularProgressIndicator(),) : Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("${l3[0].toString()} : "), Text(l4[0])],
            ),
          ),
          Container(
            width: width / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("${l3[1].toString()} : "), Text(l4[1])],
            ),
          ),
          Container(
            width: width / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("${l3[2].toString()} : "), Text(l4[2])],
            ),
          ),
        ],
      ),
    ));
  }
}
