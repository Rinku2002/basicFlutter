import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proj/edit.dart';
import './edit.dart';
import './userdetails.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Application',
      initialRoute: '/',
      routes: {
        '/':(context) => mainApp(),
        '/userDetails':(context) => userDetails(),
        '/edit':(context) => edit(),
      },
    )
    // const mainApp()
  );
}

List<User> users=[];

class mainApp extends StatefulWidget {
  const mainApp({Key? key}) : super(key: key);

  @override
  State<mainApp> createState() => _mainAppState();
}

class _mainAppState extends State<mainApp> {
  late Future<List<User>> usersF;

  @override
  void initState(){
    super.initState();
    usersF=getUsers(context);
  }

  static Future<List<User>> getUsers(BuildContext context) async {
    final assetBundle=DefaultAssetBundle.of(context);
    final data=await assetBundle.loadString('assets/data.json');
    final body=json.decode(data);

    return body.map<User>(User.fromJson).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return 
    // MaterialApp(
    //   title: 'Stainless Widget',
    //   home: 
      Scaffold(
        appBar: AppBar(
          leading: 
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage("https://media-exp1.licdn.com/dms/image/C4D03AQEBo40iAvpJ-w/profile-displayphoto-shrink_200_200/0/1617171943150?e=2147483647&v=beta&t=67MhAEM-nOjEJ_5bj_GalKlrGO3jlleBTEq4L2aAp6g"),
          ),
          title: const Text(
            "Fosterate",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight:FontWeight.w700
            ),
          ),
          backgroundColor: Colors.white,
          actions:[
            IconButton(
              icon: const Icon(
                Icons.add_alert,
                color: Colors.grey,
              ),
              onPressed: (){
                print("Tapped on bell");
              },
            ),
            const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6swZO8d-ZWsYcFSMuRaipYJhGTDvJVJ-dIg&usqp=CAU"),
            ),
          ]
        ),
        body: Center(
          child: FutureBuilder<List<User>>(
            future: usersF,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              else if(snapshot.hasData){
                users=snapshot.data!;

                return buildUsers(users);
              }
              else{
                return const Text("No user data");
              }
            },
          ),
        ),
      );
    // );
  }
  Widget buildUsers(List<User> users)=>ListView.builder(
    itemCount: users.length,
    itemBuilder: (context,index){
      final user=users[index];

      return Container(
        margin: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap:() => Navigator.pushNamed(
            context, 
            '/userDetails',
            arguments: user
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(user.img),
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black87,
                      fontWeight:FontWeight.w400
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.call,
                            color: Colors.orange,
                          ),
                          Text(user.phno)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.orange,
                          ),
                          Text(user.email)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          )
        )
      );
    },
  );
}



class User{
  final String img;
  final String name;
  final String email;
  final String phno;
  final String empId;
  final String DOB;
  final String gender;
  final String roles;
  final String status;

  User({
    required this.img,
    required this.name,
    required this.email,
    required this.phno,
    required this.empId,
    required this.DOB,
    required this.gender,
    required this.roles,
    required this.status,
  });

  static User fromJson(json)=>User(
    img: json["img"], 
    name: json["name"], 
    email: json["email"], 
    phno: json["phno"], 
    empId: json["empId"], 
    DOB: json["DOB"], 
    gender: json["gender"], 
    roles: json["roles"], 
    status: json["status"]
  );
}