import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:getmetour/detailtim.dart';
import 'package:logger/logger.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<List<dynamic>> fetchData() async {
  String request =
      'https://script.google.com/macros/s/AKfycbzwp9AvxEYvbwJ-q3_LbORdwR_-T7F_M_bLmpZt-DW0ay1WjnsNE57NqOzltgIwPZ-0/exec';

  logger.t("Start fetch API agents");

  try {
    final response = await Dio().get(request);

    if (response.statusCode == 200) {
      logger.i('Berhasil fetch API');
      final res = response.data;

      return res;
    } else {
      logger.e('Error!', error: 'Terjadi kesalahan saat fetch API');
      throw Exception('Failed to load API');
    }
  } catch (e) {
    logger.e('Error!', error: e.toString());
    throw Exception('Failed to load API');
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAFTAR TIM'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 580,
                child: FutureBuilder<List<dynamic>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: Colors.black,
                          size: 25,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error : ${snapshot.error}',
                      );
                    } else {
                      final data = snapshot.data!;
                      return GridView.builder(
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final map = data[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: DetailTim(
                                    namatim: map['namatim'],
                                    logotim: map['images'],
                                    pemain: map['namapemain'],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Mengatur tingkat kebulatan
                              ),
                              child: Column(
                                children: [
                                  Image.network(
                                    map['images'],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      map['namatim'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'RobotoMono'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 8, 211, 247),
    );
  }
}
