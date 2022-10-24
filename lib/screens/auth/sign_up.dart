import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swatantratech/screens/auth/sign_in.dart';
import 'package:swatantratech/widgets/dialogs.dart';

import '../../utilities/dimensions.dart';
import '../home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  // New User added
  userAddedSuccess() async {
    CustomDialogs.showErrorDialog(
        context,
        "Continue to explore more",
        'User Added',
        'Continue',
        'success_anim',
        true,
        MaterialPageRoute(builder: (ctx) => const Home()));
  }

  // Validates Inputs
  validateInputs() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      CustomDialogs.showErrorDialog(context, 'All field are required !!',
          'Invalid Data', 'OK', 'invalid_anim', false, null);
    } else if (_passwordController.text != _confirmPasswordController.text) {
      CustomDialogs.showErrorDialog(
          context,
          "Confirmation Password doesn't match",
          'Wrong Password',
          'Try Again',
          'invalid_anim',
          false,
          null);
    } else {
      try {
        var user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ))
            .user;
        if (user != null) {
          userAddedSuccess();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomDialogs.showErrorDialog(
              context,
              'The password provided is too weak',
              'Invalid Password',
              'Try Again',
              'invalid_anim',
              false,
              null);
        } else if (e.code == 'email-already-in-use') {
          CustomDialogs.showErrorDialog(
              context,
              'Try to Log In with same credentials',
              'Existing Account !!',
              'Continue',
              'invalid_anim',
              true,
              MaterialPageRoute(builder: (ctx) => SignIn()));
        }
      } catch (e) {
        CustomDialogs.showErrorDialog(context, e.toString(), 'ERROR',
            'Continue', 'invalid_anim', false, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: Dimensions.w360),
          margin: EdgeInsets.all(Dimensions.h48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey there',
                style: TextStyle(fontSize: Dimensions.h30),
              ),
              SizedBox(height: Dimensions.h8),
              Text("To get started with us create you account"),
              SizedBox(height: Dimensions.h30),
              TextField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(height: Dimensions.h16),
              TextField(
                maxLines: 1,
                controller: _passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                      color: _showPassword ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _showPassword = !_showPassword);
                    },
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h16),
              TextField(
                obscureText: !_showPassword,
                maxLines: 1,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
              SizedBox(height: Dimensions.h48),
              Container(
                width: double.maxFinite,
                height: Dimensions.h42,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: validateInputs,
                  child: const Text('Create Account'),
                ),
              ),
              SizedBox(height: Dimensions.h20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: Dimensions.f12),
                  ),
                  SizedBox(width: Dimensions.h8),
                  InkWell(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: Dimensions.f12,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
