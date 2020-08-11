import 'package:book_searching/views/home.dart';
import 'package:book_searching/views/signup.dart';
import 'package:book_searching/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:book_searching/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email, password;
  final _keyForm = GlobalKey<FormState>();

  bool _isLoading = false, error = false;

  void signIn() async{
    if(_keyForm.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      await handleSignInEmail(email, password).then((value) {
        setState(() {
          _isLoading = false;
        });
        if(value != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        else setState(() {
          error = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: _isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : 
      SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints( 
                maxHeight: MediaQuery.of(context).size.height - 80
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email'
                    ),
                    validator: (value) => value.toString().length == 0 ? 'Enter email' : null,
                    onChanged: (value) => email = value.trim(),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) => value.toString().length == 0 ? 'Enter password' : null,
                    onChanged: (value) => password = value.trim(),
                  ),
                  SizedBox(height: 16,),
                  GestureDetector(
                    onTap: () => signIn(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      width: 140,
                      height: 40,
                      child: Center(child: Text('Sign In', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),)),
                    ),
                  ),
                  error ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8,),
                      Text('Cannot find account!', style: TextStyle(color: Colors.redAccent),),
                      Text('Please check your username and password!', style: TextStyle(color: Colors.redAccent),)
                    ],
                  ) : SizedBox(height: 0,),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: TextStyle(fontSize: 15),),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(),));
                        },
                        child: Text('Sign up', style: TextStyle(decoration: TextDecoration.underline, fontSize: 15),)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}