import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 1.0, // Lebar gambar mengikuti lebar layar
          heightFactor: 1.0, // Tinggi gambar mengikuti tinggi layar
          child: Image.asset(
            'assets/images/dua1.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context)
                .size
                .height, // Menampilkan gambar tanpa terpotong dan mempertahankan aspek rasio
          ),
        ),
      ),
    );
  }
}
