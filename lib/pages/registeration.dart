import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/pages/roadmap.dart';
import 'package:path_finder/pages/login.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  bool isObscure = true;

  AuthService service = AuthService();

  void register(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final data = await service.signup(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text);
    if (data['status'] == 200) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message'] + ' Please Login'),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['message']),
        ),
      );
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 125),
              Text(
                'Welcome Back',
                style: headLineText,
              ),
              SizedBox(height: 22),
              //name
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Name', style: boldText)),
              SizedBox(height: 10),
              TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter your name',
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
              //email
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email', style: boldText)),
              SizedBox(height: 10),
              TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Enter your email',
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
              //password
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password', style: boldText)),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: isObscure,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Enter your password',
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

              SizedBox(height: 22),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all the fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    FocusScope.of(context).unfocus();
                    register(context);
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
                    child: isLoading ? CircularProgressIndicator() : Text(
                      'Log In',
                      style: whiteText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
