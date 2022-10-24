import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swatantratech/helper/sign_in_helper.dart';
import 'package:swatantratech/screens/auth/sign_up.dart';
import 'package:swatantratech/utilities/dimensions.dart';
import 'package:swatantratech/widgets/reset_password.dart';

import '../../widgets/dialogs.dart';

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
          constraints: BoxConstraints(maxWidth: Dimensions.w360),
          margin: EdgeInsets.all(Dimensions.h48),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(fontSize: Dimensions.f32),
                ),
                SizedBox(height: Dimensions.h8),
                const Text('Welcome back! Please enter you details.'),
                SizedBox(height: Dimensions.h30),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: Dimensions.h16),
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
                SizedBox(height: Dimensions.h16),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text('Forgot Password?'),
                    onTap: () {
                      ResetPassword.reset(context);
                    },
                  ),
                ),
                SizedBox(height: Dimensions.h30),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.h42,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        SignInHelper.signIn(context, _emailController.text,
                            _passwordController.text);
                      } else {
                        CustomDialogs.showErrorDialog(
                            context,
                            "All fields are required",
                            'Invalid Data',
                            'Try Again',
                            'invalid_anim',
                            false,
                            null);
                      }
                    },
                    child: const Text('Log In'),
                  ),
                ),
                SizedBox(height: Dimensions.h20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: Dimensions.f12),
                    ),
                    SizedBox(width: Dimensions.h8),
                    InkWell(
                      child: Text(
                        "Sign up for free",
                        style: TextStyle(
                            fontSize: Dimensions.f12,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
