// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import './main.dart';

class userDetails extends StatefulWidget {
  const userDetails({Key? key}) : super(key: key);

  @override
  State<userDetails> createState() => _userDetailsState();
}

class _userDetailsState extends State<userDetails> {
  
  Widget InfoHead(String a){
    return Text(a, style: const TextStyle(
        fontSize: 20,
        color: Color.fromARGB(221, 161, 142, 142),
        fontWeight:FontWeight.w400
      ),
    );
  }

  Widget InfoData(String a){
    return Text(a, style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight:FontWeight.w400
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final user=ModalRoute.of(context)!.settings.arguments as User;
    return
      Scaffold(
        appBar: AppBar(
          title: const Text("My Account"),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
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
                      fontWeight:FontWeight.w600
                    ),
                  ),
                InfoHead(user.email),
                InfoHead(user.phno),
                const Text(""),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Profile",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight:FontWeight.w700
                          ),
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoHead("Employee ID"),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoHead("Date of Birth"),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoHead("gender"),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoHead("Roles"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoData(user.empId),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoData(user.DOB),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoData(user.gender),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  InfoData(user.roles),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                  const Text(""),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Status",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight:FontWeight.w700
                          ),
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(padding: EdgeInsets.all(5)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InfoHead("WorkStatus"),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    user.status,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontWeight:FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                  
                  const Padding(padding: EdgeInsets.only(bottom: 30.0)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed:(){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                          ),
                          primary: Colors.orange
                        ),
                        child: Row(
                          children: const [
                            Padding(padding: EdgeInsets.all(5)),
                            Icon(
                              Icons.logout_rounded
                            ),
                            Text("Sign Out"),
                            Padding(padding: EdgeInsets.all(5)),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            )
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.orange,
          overlayColor: Colors.grey,
          overlayOpacity: 0.4,
          spacing: 15,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.delete),
              label: 'Delete',
              onTap: (){
                print("Tapped on delete");
                Navigator.pushNamed(
                  context, 
                  '/'
                );
              }
            ),
            SpeedDialChild(
              child: const Icon(Icons.edit),
              label: 'Edit',
              onTap: (){
                print("Tapped on Edit");
                Navigator.pushNamed(
                  context, 
                  '/edit',
                  arguments: user
                );
              }
            ),
          ],
        ),
      );
  }
}