import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:first_swap/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:first_swap/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'profile_page.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}





class _EditProfilePageState  extends State<EditProfilePage>  {



      final _auth = FirebaseAuth.instance;


  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  String userID ="";



  @override
  Widget build(BuildContext context) {



    final firstNameField = TextFormField(
        textAlign: TextAlign.right,
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{1,}$');
          if (value!.isEmpty) {
            return ("*الحقل مطلوب");
          }
          if (!regex.hasMatch(value)) {
            return ("الاسم الأول حد أدنى حرف واحد");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "الاسم الأول",
        ));



 //Last name field
    final secondNameField = TextFormField(
        textAlign: TextAlign.right,
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("*الحقل مطلوب");
          }
          if (!regex.hasMatch(value)) {
            return ("الاسم الأخير حد أدنى حرف ٣ أحرف");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "الاسم الأخير",
        ));


/*
to change password يمكن نحتاجه
    final passwordField = TextFormField(
        textAlign: TextAlign.right,
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = 
         new RegExp(
              "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
          if (value!.isEmpty) {
            return ("*الحقل مطلوب");
          }
      if (!regex.hasMatch(value)) {
           return ("يجب ان تحتوي كلمة المرور على :حرف كبير وصغير وارقام ورمز");
        }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "كلمة المرور",
        ));


//confirm password field
    final confirmPasswordField = TextFormField(
        textAlign: TextAlign.right,
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return ("*الحقل مطلوب");
          } else if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "كلمة المرور لا تتطابق";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "أعد إدخال كملة المرور",
        ));
*/


    //Save button

  final   SaveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.cyan[800],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          
          onPressed: () {
                if(firstNameEditingController.text.isNotEmpty&&secondNameEditingController.text.isNotEmpty){

submitAction(context);}
                if(firstNameEditingController.text.isEmpty&&secondNameEditingController.text.isEmpty){
                 Navigator.pop(context);
                };
          },
          child: Text(
            "حفظ التعديلات",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  //





  //changr password button
  final   changePass = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color:Colors.cyan[800],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          
          onPressed: () {
             
          },
          child: Text(
            "تغيير كلمة المرور",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  //
  //
  return Scaffold(
    appBar: buildAppBar(context),
    
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 150,
                        child: Image.asset(
                          "assets/Screen Shot 1443-03-02 at 6.09.18 PM.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                   
                   
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
 
                    SizedBox(height: 20),
                     
                     SaveButton,//save button
                    SizedBox(height: 15),
                      changePass,//change paasword button
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ); 
  }

  
 updateUserData(String FirstName, String LastName, String uid) async {

          final _auth = FirebaseAuth.instance;

    // calling our firestore
    // calling our user model
    // updateing Data 
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing  the values

    userModel.FirstName = firstNameEditingController.text;
    userModel.LastName = secondNameEditingController.text;

     final firebaseUser = await FirebaseAuth.instance.currentUser;
     if(FirstName!=null&&LastName!=null){
        if (firebaseUser != null)// 
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .update({
       'FirstName': FirstName,'LastName': LastName 
    });   }

    userID =firebaseUser!.uid;  

    Fluttertoast.showToast(msg: "تم التعديل بنجاح");
  
   Navigator.pushAndRemoveUntil(
      (this.context),
       MaterialPageRoute(builder: (context) => ProfilePage()),
        (route) => false);
  }

    updateData(String FirstName, String LastName,String userID) async {

 await updateUserData(FirstName, LastName, userID);


  }
  submitAction(BuildContext context) {
    updateData(firstNameEditingController.text, secondNameEditingController.text,
         userID);
    firstNameEditingController.clear();
    secondNameEditingController.clear();}
  
}