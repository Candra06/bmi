import 'package:bmi_score/Config/Service.dart';
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
  String kategori = '-', errCount = '', temp = '';
  bool isLoading = true;
  double bmi = 0;
  TextEditingController heightController = TextEditingController(),
      weightController = TextEditingController();
  Map<String, dynamic> data = {};

  getData(
    bool isCurrentCity,
    String cityName,
  ) async {
    setState(() {
      isLoading = true;
    });
    var tmpData = await Services().callWeatherAPi(isCurrentCity, cityName);

    setState(() {
      data = tmpData;
      double tmpTemp = double.parse(data['main']['temp'].toString()) - 273;
      temp = tmpTemp.toInt().toString();
      isLoading = false;
    });
  }

  onSubmit() {
    setState(() {
      errCount = '';
    });
    // if (heightController.text.isEmpty || weightController.text.isEmpty) {
    //   errCount = 'Tinggi badan dan berat badan harus diisi';
    // } else {
    //   double tmpHeight = int.parse(heightController.text.toString()) / 100;
    //   bmi =
    //       int.parse(weightController.text.toString()) / (tmpHeight * tmpHeight);
    //   if (bmi < 17) {
    //     kategori = 'Kurus(Kekurangan berat badan berat)';
    //   } else if (bmi >= 17 && bmi < 18.4) {
    //     kategori = 'Kurus(Kekurangan berat badan ringan)';
    //   } else if (bmi >= 18.4 && bmi <= 25) {
    //     kategori = 'Normal';
    //   } else if (bmi > 25 && bmi <= 27) {
    //     kategori = 'Gemuk(Lelebihan berat badan ringan)';
    //   } else {
    //     kategori = 'Obesitas';
    //   }
    // }
    getData(true, "Jember");
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        getData(true, "");
      },
    );
    super.initState();
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
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                Text(
                                  'Cuaca Hari Ini',
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${data['weather'][0]['main']} (${temp.toString()}ºC)",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' ${data['weather'][0]['description']}',
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
