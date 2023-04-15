import 'package:bmi_score/Config/themes.dart';
import 'package:flutter/material.dart';

class HomeInputScreen extends StatefulWidget {
  final Map userData;
  const HomeInputScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<HomeInputScreen> createState() => _HomeInputScreenState();
}

class _HomeInputScreenState extends State<HomeInputScreen> {
  String kategori = '-', errCount = '';
  double bmi = 0;
  TextEditingController heightController = TextEditingController(),
      weightController = TextEditingController();

  onSubmit() {
    setState(() {
      errCount = '';
    });
    if (heightController.text.isEmpty || weightController.text.isEmpty) {
      errCount = 'Tinggi badan dan berat badan harus diisi';
    } else {
      double tmpHeight = int.parse(heightController.text.toString()) / 100;
      bmi =
          int.parse(weightController.text.toString()) / (tmpHeight * tmpHeight);
      if (bmi < 17) {
        kategori = 'Kurus(Kekurangan berat badan berat)';
      } else if (bmi >= 17 && bmi < 18.4) {
        kategori = 'Kurus(Kekurangan berat badan ringan)';
      } else if (bmi >= 18.4 && bmi <= 25) {
        kategori = 'Normal';
      } else if (bmi > 25 && bmi <= 27) {
        kategori = 'Gemuk(Lelebihan berat badan ringan)';
      } else {
        kategori = 'Obesitas';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/headerHome.png'),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              top: defaultMargin * 2,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Datang,',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.userData['username'],
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login',
                                arguments: {
                                  "username": widget.userData['username'],
                                  "password": widget.userData['password'],
                                });
                          },
                          child: Icon(
                            Icons.logout,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(defaultMargin),
                      child: Column(
                        children: [
                          Text(
                            'Skor BMI kamu :',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            bmi.toStringAsFixed(2),
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kategori : $kategori',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 72,
                      left: defaultMargin,
                      right: defaultMargin,
                    ),
                    padding: EdgeInsets.all(defaultMargin),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    height: 260,
                    child: Column(
                      children: [
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
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              fillColor: fontPrimaryColor,
                              hintText: 'TInggi badan',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // errUsername.isNotEmpty
                        //     ? Text(
                        //         errUsername,
                        //         style: TextStyle(color: redColor),
                        //       )
                        //     : const SizedBox(),
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
                            keyboardType: TextInputType.number,
                            controller: weightController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              fillColor: fontPrimaryColor,
                              hintText: 'Berat Badan',
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        errCount.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: defaultMargin),
                                child: Text(
                                  errCount,
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
                              'HITUNG BMI',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: defaultMargin,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              splashFactory: null,
                              primary: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    defaultBorderRadius - 2),
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
          )
        ],
      ),
    );
  }
}
