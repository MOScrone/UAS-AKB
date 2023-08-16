import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<List<dynamic>> fetchData() async {
  String request =
      'https://script.google.com/macros/s/AKfycbzwp9AvxEYvbwJ-q3_LbORdwR_-T7F_M_bLmpZt-DW0ay1WjnsNE57NqOzltgIwPZ-0/exec';

  logger
      .t("Start fetch API agents"); // Log awal pengambilan data agent dari API

  try {
    final response = await Dio()
        .get(request); // Lakukan HTTP GET request ke API menggunakan dio

    if (response.statusCode == 200) {
      // Jika response status code adalah 200 (berhasil)
      logger.i(
          'Berhasil fetch API'); // Log berhasilnya pengambilan data agent dari API
      final res =
          response.data; // Response data dari API sudah dalam bentuk JSON

      return res; // Kembalikan data agent
    } else {
      // Jika response status code tidak 200 (gagal)
      logger.e('Error!',
          error:
              'Terjadi kesalahan saat fetch API'); // Log error saat pengambilan data agent dari API

      throw Exception(
          'Failed to load API'); // Jika fetch API gagal, throw exception dengan pesan "Failed to load API"
    }
  } catch (e) {
    logger.e('Error!', error: e.toString());
    throw Exception(
        'Failed to load API'); // Jika fetch API gagal, throw exception dengan pesan "Failed to load API"
  }
}

class JadwalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 185, 252),
      appBar: AppBar(
        title: Text('JADWAL TURNAMEN'),
        automaticallyImplyLeading: false,
      ),
      //Body content
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
                  // Panggil fungsi fetchData() untuk mengambil data peta dari API
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Jika masih dalam proses fetch data dari API
                      // Menampilkan loading animation ketika fetch data dari API
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: Colors.black,
                          // Warna loading animation (sesuai dengan nilai konstanta redColor)
                          size: 25, // Ukuran loading animation
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // Jika terjadi error saat fetch API
                      // Return pesan error jika fetch API gagal
                      return Text(
                        'Error : ${snapshot.error}', // Tampilkan pesan error
                      );
                    } else {
                      final data =
                          snapshot.data!; // Ambil data peta dari snapshot

                      return ListView.builder(
                        itemCount:
                            data.length, // Tampilkan hanya 5 peta (misalnya)
                        itemBuilder: (context, index) {
                          final map =
                              data[index]; // Ambil data peta berdasarkan indeks
                          final team = map['images'];

                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 11.0, vertical: 15.0),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.network(
                                                map['images'],
                                                width: 110,
                                                height: 110,
                                                fit: BoxFit.fill,
                                              ),
                                              Text(
                                                map['namatim'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('VS'),
                                                Text(map['jadwal']),
                                                Text(
                                                    '${map['skor'].toString()} - ${map['skor'].toString()}'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.network(
                                                map['images2'],
                                                width: 110,
                                                height: 110,
                                                fit: BoxFit.fill,
                                              ),
                                              Text(
                                                map['namatim2'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
    );
  }
}
