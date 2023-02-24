import 'dart:convert';

import 'package:apidemo/Models/PostModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // API MODELS
  List<PostModels> postlist=[];
  Future<List<PostModels>> getPostApi() async{
    final response= await http.get(Uri.parse( "https://jsonplaceholder.typicode.com/posts"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
     for(Map i in data) {
       postlist.add(PostModels.fromJson(i));
     }
     return postlist;

    }
    else{
    return postlist;
    }
  }
  //API COPIED USING ABOVE CODE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("                                API"),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: FutureBuilder(future: getPostApi() ,
              builder: (context,snapsot){
              if(!snapsot.hasData){
                return Text("Loading...");
              }
              else{
                return ListView.builder(
                    itemCount:postlist.length,
                    itemBuilder: (context,index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Text(postlist[index].title.toString()),
                                SizedBox(height: 5,),
                                Text(" "),
                                Text("Discreption",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                SizedBox(height: 5,),
                                Text(postlist[index].body.toString())

                              ],
                            ),
                          ),
                        );
                });
              }
              }
            ),
          )
        ],
      ),
    );
  }
}
