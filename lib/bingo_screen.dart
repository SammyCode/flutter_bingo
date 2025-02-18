import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bingo/bingo_card.dart';
import 'package:flutter_bingo/bingo_images.dart';

class BingoScreen extends StatefulWidget {
  const BingoScreen({super.key});

  @override
  _BingoScreenState createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  final List<BingoCard> images = List.from(bingoImages);

  List<BingoCard> shuffledImages = [];
  final int gridSize = 3; // 3x3 grid

  @override
  void initState() {
    super.initState();
    shuffledImages = List.from(images)..shuffle(Random());
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'Nuevo Tablero',
          ),
          content: const Text(
            '¿Estás seguro de que quieres generar un nuevo tablero?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  shuffledImages = List.from(images)..shuffle(Random());
                });
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: const Text(
                'Sí, nuevo tablero',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Bingo',
            style: TextStyle(
                color: Colors.white,
                decorationColor: Color.fromARGB(128, 19, 8, 130))),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 1, 103, 176),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
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
                        if (shuffledImages[index].taped) {
                          shuffledImages[index] =
                              shuffledImages[index].copyWith(taped: false);
                        } else {
                          shuffledImages[index] =
                              shuffledImages[index].copyWith(taped: true);
                        }
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: !shuffledImages[index].taped
                            ? Stack(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    child: Image.asset(
                                      shuffledImages[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  Opacity(
                                    opacity: 0.3,
                                    child: Image.asset(
                                      shuffledImages[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              )),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Developed by SammyCode'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(210, 1, 103, 176),
        onPressed: _showConfirmationDialog,
        child: Icon(Icons.refresh, color: Colors.white),
        tooltip: 'Shuffle Images',
      ),
    );
  }
}
