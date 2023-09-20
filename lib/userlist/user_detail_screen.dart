import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserDetails extends StatefulWidget {
  final int index;
  const UserDetails({super.key, required this.index});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<dynamic> userData = [];
  String firstName ='';
  String lastName =  '';
  String email = '';
  String userPhoto = '';
  void initState() {
    super.initState();
    _fetchUserDetail();
  }
  Future<void> _fetchUserDetail() async {


    try {

      final response = await http.get(Uri.parse('https://reqres.in/api/users/${widget.index}'));

      final responseData = json.decode(response.body);

      setState(() {

        userData.add(responseData['data']);
         firstName =userData.first['first_name'];
         lastName =  userData.first['last_name'];
         email = userData.first['email'];
         userPhoto = userData.first['avatar'];
        print('An error occurred: $userData');

      });
    } catch (error) {
      print('An error occurred: $error');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffe6ecf3),
        centerTitle: true,
        leading: IconButton(onPressed: (){
Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_outlined,color: Color(0xff111111)),),
        title: const Text('User Detail',style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            fontFamily: 'SF-PRO',
          color: Color(0xff111111)
        )),
      ),
body: userData ==null?Center(child: CircularProgressIndicator()) : Center(
  child:   Container(

    width: double.infinity,
    child: Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            margin: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 10),
            child: userPhoto==''?Container(): Image(
              image: NetworkImage(
                  '${userPhoto}'),
              fit: BoxFit.fill,
            ),
          ),

    Text(
      "${firstName}"" " + "${lastName}",
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          fontFamily: 'SF-PRO'
      ),
    ),
         SizedBox(height: 10,),
          Text(
            "${email}",
            maxLines: 2,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'SF-PRO'
            ),
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),
    ),
  ),
),
    );
  }
}
