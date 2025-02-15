import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(BingoApp());
}

class BingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BingoScreen(),
    );
  }
}

class BingoScreen extends StatefulWidget {
  @override
  _BingoScreenState createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  final List<String> images = [
    'https://via.placeholder.com/100/FF0000/FFFFFF?text=1',
    'https://via.placeholder.com/100/00FF00/FFFFFF?text=2',
    'https://via.placeholder.com/100/0000FF/FFFFFF?text=3',
    'https://via.placeholder.com/100/FFFF00/FFFFFF?text=4',
    'https://via.placeholder.com/100/FF00FF/FFFFFF?text=5',
    'https://via.placeholder.com/100/00FFFF/FFFFFF?text=6',
    'https://via.placeholder.com/100/FFFFFF/000000?text=7',
    'https://via.placeholder.com/100/000000/FFFFFF?text=8',
    'https://via.placeholder.com/100/FFA500/FFFFFF?text=9',
    'https://via.placeholder.com/100/FF0000/FFFFFF?text=10',
    'https://via.placeholder.com/100/00FF00/FFFFFF?text=11',
    'https://via.placeholder.com/100/0000FF/FFFFFF?text=12',
    'https://via.placeholder.com/100/FFFF00/FFFFFF?text=13',
    'https://via.placeholder.com/100/FF00FF/FFFFFF?text=14',
    'https://via.placeholder.com/100/00FFFF/FFFFFF?text=15',
    'https://via.placeholder.com/100/FFFFFF/000000?text=16',
    'https://via.placeholder.com/100/000000/FFFFFF?text=17',
    'https://via.placeholder.com/100/FFA500/FFFFFF?text=18',
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
        title: Text('Flutter Bingo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
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
                    ? Text(shuffledImages[index])
                    : Container(
                        color: Colors.grey.shade300,
                        child: Center(
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
        child: Icon(Icons.refresh),
        tooltip: 'Shuffle Images',
      ),
    );
  }
}
