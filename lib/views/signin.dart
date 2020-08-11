import 'package:book_searching/views/signup.dart';
import 'package:book_searching/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: SingleChildScrollView(
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
                ),
                SizedBox(height: 8,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  width: 140,
                  height: 40,
                  child: Center(child: Text('Sign In', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),)),
                ),
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
        )
      )
    );
  }
}