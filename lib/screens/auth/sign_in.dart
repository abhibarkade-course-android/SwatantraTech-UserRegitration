import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swatantratech/helper/sign_in_helper.dart';
import 'package:swatantratech/screens/auth/sign_up.dart';
import 'package:swatantratech/widgets/reset_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(height: 8),
              Text('Welcome back! Please enter you details.'),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 1,
                controller: _passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: 'password',
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
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Text('Forgot Password?'),
                  onTap: () {
                    ResetPassword.reset(context);
                  },
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: double.maxFinite,
                height: 42,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    SignInHelper.signIn(context, _emailController.text,
                        _passwordController.text);
                  },
                  child: const Text('Log In'),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't have an account?",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    child: const Text(
                      "Sign up for free",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
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
