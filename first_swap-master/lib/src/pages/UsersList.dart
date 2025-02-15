import 'package:first_swap/src/pages/UsersProfile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_swap/src/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'AdminHomePage.dart';

import 'AdminProfile_page.dart';
import 'GoodsList.dart';
import 'Home_page.dart';
import 'MyItems.dart';
import 'login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Post_page.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override

  //  final collRef = FirebaseFirestore.instance.collection('users');

  String Email = '';
  String FName = '';
  String LName = '';
  String phoneN = '';
  String userName = '';
 String name =' ';

  final FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
  }

  Future<void> _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) // the user sign in
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        Email = ds.data()!['email'];
        FName = ds.data()!['FirstName'];
        LName = ds.data()!['LastName'];
        phoneN = ds.data()!['phoneN'];
        userName = ds.data()!['UserName'];
   
      }).catchError((e) {
        print(e);
      });
  }
    Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.cyan[800], //or set color with: Color(0xFF0000FF)
      ));
    
    return MaterialApp(
    
   home:
    
          Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: CustomBottomNavigationBar(
                  iconList: [
                  //  Icons.home,
                    Icons.people,
                    Icons.reorder_rounded,
                    Icons.person,
                   
                  ],
                  onChange: (val) {
                    setState(() {
                      var _selectedItem = val;
                    });
                  },
                  defaultSelectedIndex: 0,
                ),
          
appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[800],
            title: Center(
                child:
                    Text('جميع المستخدمين ', style: TextStyle(fontSize: 20))),
          
 

),


body: StreamBuilder<QuerySnapshot>(

  

     stream: 
      FirebaseFirestore.instance
       .collection('users')
      .where('email',isNotEqualTo: 'swap.gp05@gmail.com')
        .snapshots(),
        
    builder: (context, snapshot){


       return(snapshot.connectionState == ConnectionState.waiting)
    ?Center(child: CircularProgressIndicator())
    :ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder:(context,index){
      DocumentSnapshot data= snapshot.data!.docs[index];
      return Container(
    padding: EdgeInsets.only(top: 16),
    child: Column(
    children: [
      ListTile(
    title: Text(data['UserName'],
    
    style: TextStyle(
    fontSize: 20,fontWeight: FontWeight.bold
    
    ),),
    subtitle: Text(data['Rate'].toString()),
    
    leading: 
    CircleAvatar(
      
    child:Icon(
   (Icons.person),
    color: Colors.white
  //  fit: BoxFit.contain,
 , size: 60,
    ),
    radius:40,
    backgroundColor: Colors.grey[600],
    
    ),
    
        onTap: () {
if(data['uid']=='TM93SqbnNYUW5YDFSlgfGIG4xUD2'){
  Navigator.push(this.context,
      MaterialPageRoute(builder: (context) => AdminProfilePage()));
}
else{
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => UsersProfile(
                        FirstName: data['FirstName'],
                        LastName: data['LastName'],
                        UserName: data['UserName'],
                        email: data['email'],
                        phoneN: data['phoneN'],
                        uid: data['uid'],
                        NumRate: data['NumRate'],
                        Rate: data['Rate'].toString(),
                        Blacklist: data['Blacklist'],
                      ),
              ),
          );}


        },
   

    ),

    Divider(thickness: 2,)

    ],
    ),
    );

    }
    );
    },
   ),

    )
    );


        }   }

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  //navigation bar
  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);

        setState(() {
          _selectedIndex = index;
          // if (_selectedIndex == 0)
          //   Navigator.push(this.context,
          //       MaterialPageRoute(builder: (context) => AdminHomePage()));
          if (_selectedIndex == 0)
            Navigator.push(this.context,
                MaterialPageRoute(builder: (context) => UsersList()));
          if (_selectedIndex == 1)
            Navigator.push(this.context,
                MaterialPageRoute(builder: (context) => GoodsList()));

          if (_selectedIndex == 2)
            Navigator.push(this.context,
                MaterialPageRoute(builder: (context) => AdminProfilePage()));
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(this.context).size.width / _iconList.length,
        decoration: index == _selectedIndex
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4, color: Colors.blueGrey),
                ),
                gradient: LinearGradient(colors: [
                  Colors.blueGrey.withOpacity(0.3),
                  Colors.blueGrey.withOpacity(0.015),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)

                //color: index == _selectedItemIndex ? Colors.green : Colors.white,

                )
            : BoxDecoration(),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: index == _selectedIndex ? Colors.black : Colors.grey,
            ),
          //  if (index == 0) Text('الرئيسية'),
            if (index == 0) Text('المستخدمين'),
            if (index == 1) Text('المنتجات'),
            if (index == 2) Text('حسابي'),
          ],
        ),
      ),
    );
  }
}

