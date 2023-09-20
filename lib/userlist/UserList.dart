import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tistepsdemo/userlist/user_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class UserListing extends StatefulWidget {
  const UserListing({super.key});

  @override
  State<UserListing> createState() => _UserListingState();
}

class _UserListingState extends State<UserListing> {
  int _page = 1;
  int? _pageSize;
  int clickIndex=0;
  Color buttonColor = Color(0xff21A59D);
  bool _hasNextPage = true;
  bool _isLoading = false;

  List<dynamic> userList = [];

  Future<void> _fetchArticles(int index) async {
    setState(() {
      _isLoading = true;
    });

    try {

      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$index'));

      final responseData = json.decode(response.body);

      setState(() {
        userList.addAll(responseData['data']);
        _pageSize = responseData['total_pages'];
        print(_pageSize);
      });
    } catch (error) {
      print('An error occurred: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchArticles(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffe6ecf3),
        centerTitle: true,
        title: const Text('User List',style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            fontFamily: 'SF-PRO',
            color: Color(0xff111111)
        ),),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: userList.length,
              itemBuilder: (ctx, index) {
                final userData = userList[index];
                final firstName = userData['first_name'] ?? '';
                final lastName = userData['last_name'] ?? '';
                final email =
                    userData['email'] ?? '';

                return GestureDetector(
                  onTap: (){
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                        builder: (_) => UserDetails(
                            index:userData['id']
                        )));
                  },
                  child: Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 16,right: 16),
                      leading:  Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(20),
                          child: CircleAvatar(
                            //backgroundImage: calls[index].image == "" ? null : AssetImage(calls[index].image),
                            radius: 21,

                            child:
                            Image(
                              image: NetworkImage(
                                  '${userData['avatar']}'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),

                      // userData['avatar'] != null
                      //     ? Image.network(
                      //   userData['avatar'],
                      //   width: 120,
                      //   height: 80,
                      //   fit: BoxFit.values.last,
                      // )
                      //     : Container(
                      //   width: 80,
                      //   height: 80,
                      //   color: Colors.grey,
                      // ),
                      title: Text(
                        "$firstName"" " + "$lastName",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: 'SF-PRO'
                        ),
                      ),
                      subtitle: Text(
                        email,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'SF-PRO'
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Container(

                margin: EdgeInsets.only(bottom: 30,top: 10,left: MediaQuery.of(context).size.width* 0.45),
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _pageSize,
                  itemBuilder: (BuildContext context, int index) {


                    return  Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                          onTap: (){
                            setState(()  {
                              clickIndex = index;
                              userList.clear();
                              _fetchArticles(index+1);
                            });
                          },
                          child: Text("${index+1}",style: TextStyle(color: clickIndex == index? Color(0xff21A59D):Color(0xff212934),fontSize: 20,fontWeight: clickIndex == index? FontWeight.w700:FontWeight.w300),)),
                    );
                  },),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
