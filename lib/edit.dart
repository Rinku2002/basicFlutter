import 'package:flutter/material.dart';
import 'main.dart';

// ignore: camel_case_types
class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

User user={} as User;

// ignore: camel_case_types
class _editState extends State<edit> {
  @override
  Widget build(BuildContext context) {
  user=ModalRoute.of(context)!.settings.arguments as User;
    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight:FontWeight.w700
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        // ignore: prefer_const_constructors
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: const MyForm(),
        )
      );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  int _gp=user.gender=="Male"?0:1;

  Widget myRadio(String n,int v){
    
    return 
    Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 2.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(value: v, groupValue: _gp, onChanged: (value){
            setState(() {
              _gp=v;
            });
          },fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),),
          Text(n)
        ],
      )
    );
  }

  Widget myFormField(String n,String iv){
    return
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(5)),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Your $n',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight:FontWeight.w400
            ),
          )
        ),
        const Padding(padding: EdgeInsets.all(5)),
        TextFormField(
          // The validator receives the text that the user has entered.
          initialValue: iv,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red,width: 3.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),
            hintText: n,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $n';
            }
            return null;
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final _formKey=GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(user.img),
            // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6swZO8d-ZWsYcFSMuRaipYJhGTDvJVJ-dIg&usqp=CAU"
          ),
          myFormField("Name",user.name),
          const Padding(padding: EdgeInsets.all(5)),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Gender',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight:FontWeight.w400
              ),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              myRadio("Male",0),
              myRadio("Female",1),
            ],
          ),
          myFormField("Email",user.email),
          myFormField("Phone Number",user.phno),
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print("Pressed Done");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}