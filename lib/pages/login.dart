import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/pages/bottomnav_controller.dart';
import 'package:path_finder/pages/roadmap.dart';
import 'package:path_finder/pages/registeration.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  bool isObscure = true;

  AuthService service = AuthService();

  void login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> data = await service.login(
        email: emailController.text, password: passwordController.text);
    if (data['status'] == 'error') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else {
      await SharedPrefHelper.saveUserData(
        name: data['data']['name'],
        email: data['data']['email'],
        token: data['data']['token'],
        id: data['data']['id'],
        isRegistered: true,
      );
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavController()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: headLineText,
            ),
            SizedBox(height: 22),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Email', style: boldText)),
            SizedBox(height: 10),
            TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Email',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                ),
                style: greyText),
            SizedBox(height: 22),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Password', style: boldText)),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isObscure,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Password',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 1),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),
              style: greyText,
            ),
            SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot Password?',
                style: greySmallText,
              ),
            ),
            SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all the fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  FocusScope.of(context).unfocus();
                  login(context);
                }
              },
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Log In',
                          style: whiteText,
                        ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  'Dont have an account? Sign Up',
                  style: greySmallText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
