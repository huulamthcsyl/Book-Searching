import 'package:book_searching/services/auth.dart';
import 'package:book_searching/views/signin.dart';
import 'package:book_searching/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String accType = 'Customer', email, password, confirmPass;
  final _keyForm = GlobalKey<FormState>();

  bool _isLoading = false;

  void signUp() async {
    if(_keyForm.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      await handleSignUp(email, password, accType).then((value) {
        if(value != null){
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign Up'),
      body: _isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : 
      SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child:  
          Container(
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
                    onChanged: (value) => password = value.trim(),
                    validator: (value) => value.toString().length == 0 ? 'Enter password' : (value.toString().length < 6 ? 'Password must contain at least 6 character' : null)
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    onChanged: (value) => confirmPass = value.trim(),
                    validator: (value) => value != password ? "Confirm password doesn't match" : null,
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Account type:'),
                      SizedBox(width: 16,),
                      DropdownButton(
                        value: accType,
                        items: <String>['Customer', 'Manager']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            accType = value;
                          });
                        },
                      ),
                      ]
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: () => signUp(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      width: 140,
                      height: 40,
                      child: Center(child: Text('Sign Up', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),)),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(fontSize: 15),),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
                        },
                        child: Text('Sign In', style: TextStyle(decoration: TextDecoration.underline, fontSize: 15),)
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