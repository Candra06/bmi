import 'package:bmi_score/Config/themes.dart';
import 'package:flutter/material.dart';

class LoginInputScreen extends StatefulWidget {
  final Map userData;
  const LoginInputScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<LoginInputScreen> createState() => _LoginInputScreenState();
}

class _LoginInputScreenState extends State<LoginInputScreen> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  bool obsecure = true;
  String errUsername = '', errPass = '', errLogin = '';
  onSubmit() {
    setState(() {
      errUsername = '';
      errPass = '';
      errLogin = '';
    });
    if (usernameController.text.isEmpty) {
      errUsername = 'Username Tidak boleh kosong';
    } else if (passwordController.text.isEmpty) {
      errPass = 'Password Tidak boleh kosong';
    } else if (passwordController.text != widget.userData['password'] ||
        usernameController.text != widget.userData['username']) {
      errLogin = 'Username dan password salah';
    } else {
      Navigator.pushNamed(context, '/home', arguments: {
        "username": usernameController.text,
        "password": passwordController.text,
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            defaultMargin,
            72,
            defaultMargin,
            0,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/loginIlustration.png',
                height: 200,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 72,
                ),
                padding: EdgeInsets.all(defaultMargin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                height: 350,
                child: Column(
                  children: [
                    Text(
                      'LOGIN PAGE',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: defaultMargin * 2),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: borderInput,
                          )),
                      child: TextFormField(
                        style: TextStyle(color: fontPrimaryColor),
                        keyboardType: TextInputType.text,
                        controller: usernameController,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          fillColor: fontPrimaryColor,
                          hintText: 'Username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    errUsername.isNotEmpty
                        ? Text(
                            errUsername,
                            style: TextStyle(color: redColor),
                          )
                        : const SizedBox(),
                    Container(
                      margin: EdgeInsets.only(
                        top: defaultMargin,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: borderInput,
                          )),
                      child: TextFormField(
                        style: TextStyle(color: fontPrimaryColor),
                        obscureText: obsecure,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          fillColor: fontPrimaryColor,
                          suffixIcon: IconButton(
                            color: borderInput,
                            icon: obsecure
                                ? const Icon(Icons.lock_outline_rounded)
                                : const Icon(Icons.lock_open),
                            onPressed: () {
                              if (obsecure == true) {
                                setState(() {
                                  obsecure = false;
                                });
                              } else {
                                setState(() {
                                  obsecure = true;
                                });
                              }
                            },
                          ),
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    errPass.isNotEmpty
                        ? Text(
                            errPass,
                            style: TextStyle(color: redColor),
                          )
                        : const SizedBox(),
                    errLogin.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: defaultMargin * 2),
                            child: Text(
                              errLogin,
                              style: TextStyle(color: redColor),
                            ),
                          )
                        : const SizedBox(),
                    Container(
                      margin: EdgeInsets.only(
                        top: defaultMargin,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => onSubmit(),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: defaultMargin,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          splashFactory: null,
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius - 2),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
