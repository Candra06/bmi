import 'package:bmi_score/Config/themes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterInputScreen extends StatefulWidget {
  const RegisterInputScreen({Key? key}) : super(key: key);

  @override
  State<RegisterInputScreen> createState() => _RegisternInputScreenState();
}

class _RegisternInputScreenState extends State<RegisterInputScreen> {
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  String errUsername = '', errPass = '';
  bool obsecure = true;
  onSubmit() async {
    setState(() {
      errUsername = '';
      errPass = '';
    });
    // if (usernameController.text.isEmpty) {
    //   errUsername = 'Username Tidak boleh kosong';
    // } else if (passwordController.text.isEmpty) {
    //   errPass = 'Password Tidak boleh kosong';
    // } else {
    //   Navigator.pushNamed(context, '/login', arguments: {
    //     "username": usernameController.text,
    //     "password": passwordController.text,
    //   });
    // }

    Navigator.pushNamed(context, '/home', arguments: {
      "username": usernameController.text,
      "password": passwordController.text,
    });
    setState(() {});
  }

  cekPermission() async {
    var locationStatus = await Permission.location.status;
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || locationStatus.isDenied) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        // goToHomeScreen();
      }
    }
  }

  @override
  void initState() {
    cekPermission();
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
                'assets/registerIllustration.png',
                height: 250,
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
                height: 310,
                child: Column(
                  children: [
                    Text(
                      'REGISTER PAGE',
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
                    Container(
                      margin: EdgeInsets.only(top: defaultMargin),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => onSubmit(),
                        child: Text(
                          'REGISTER',
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
