import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class DetailTim extends StatelessWidget {
  final String namatim;
  final String logotim;
  final String pemain;

  const DetailTim(
      {required this.namatim, required this.logotim, required this.pemain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          namatim,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey,
              child: Align(
                alignment: Alignment.center,
                child: Image.network(logotim),
              ),
            ),
            Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'LIST PLAYER',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            pemain,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
