import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var data = [];

  loadData() async {
    http.Response response = await http.get("https://api.github.com/orgs/flutter/members");
    setState(() {
      data = json.decode(response.body);
    });
  }


  void initState(){
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Github - Members"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: createRepo,
          shrinkWrap: true,
          physics: ScrollPhysics(),
        ),
      ),
    );
  }

  Widget createRepo(context, position){
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(data[position]["login"]),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data[position]["avatar_url"]),
        ),
      ),
    );
  }

}
