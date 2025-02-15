// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const BingoApp());
}

class BingoApp extends StatelessWidget {
  const BingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BingoScreen(),
    );
  }
}

class BingoScreen extends StatefulWidget {
  const BingoScreen({super.key});

  @override
  _BingoScreenState createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  final List<String> images = [
    'assets/images/bottom-app-bar.png',
    'assets/images/bottom-navigation-bar.png',
    'assets/images/bottom-sheet.png',
    'assets/images/card.png',
    'assets/images/carousel.png',
    'assets/images/checkbox.png',
    'assets/images/cupertino-action-sheet.png',
    'assets/images/CupertinoDatePicker.png',
    'assets/images/data-table.png',
    'assets/images/date-picker.png',
    'assets/images/dialog.png',
    'assets/images/floating-action-button.png',
    'assets/images/grid-view.png',
    'assets/images/icon-button.png',
    'assets/images/icon.png',
    'assets/images/list-tile.png',
    'assets/images/list.png',
    'assets/images/navigation-bar.png',
    'assets/images/popup-menu-button.png',
    'assets/images/progress-indicator.png',
    'assets/images/radio-button.png',
    'assets/images/segmented-button.png',
    'assets/images/snackbar.png',
    'assets/images/switch.png',
    'assets/images/tab-bar.png',
    'assets/images/text-field.png',
    'assets/images/time-picker.png',
    'assets/images/top-app-bar.png',
  ];

  List<String> shuffledImages = [];
  final int gridSize = 3; // 3x3 grid

  @override
  void initState() {
    super.initState();
    shuffledImages = List.from(images)..shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bingo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemCount: gridSize * gridSize,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  shuffledImages[index] = ''; // Clear image when tapped
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: shuffledImages[index].isNotEmpty
                    ? Image.asset(
                        shuffledImages[index],
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Text(
                            'X',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            shuffledImages = List.from(images)..shuffle(Random());
          });
        },
        tooltip: 'Shuffle Images',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
