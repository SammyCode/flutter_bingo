import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bingo/bingo_card.dart';

class BingoScreen extends StatefulWidget {
  const BingoScreen({super.key});

  @override
  _BingoScreenState createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  final List<BingoCard> images = [
    BingoCard(
        image: 'assets/images/Android Studio.png',
        title: 'Android Studio',
        taped: false),
    BingoCard(
        image: 'assets/images/Android.png', title: 'Android', taped: false),
    BingoCard(
        image: 'assets/images/Appwrite.png', title: 'Appwrite', taped: false),
    BingoCard(image: 'assets/images/BLoC.png', title: 'BLoC', taped: false),
    BingoCard(
        image: 'assets/images/Codemagic.png', title: 'Codemagic', taped: false),
    BingoCard(image: 'assets/images/Dart.png', title: 'Dart', taped: false),
    BingoCard(image: 'assets/images/Figma.png', title: 'Figma', taped: false),
    BingoCard(
        image: 'assets/images/Firebase.png', title: 'Firebase', taped: false),
    BingoCard(
        image: 'assets/images/Flutter.png', title: 'Flutter', taped: false),
    BingoCard(
        image: 'assets/images/Font Awesome.png',
        title: 'Font Awesome',
        taped: false),
    BingoCard(image: 'assets/images/GetX.png', title: 'GetX', taped: false),
    BingoCard(image: 'assets/images/Git.png', title: 'Git', taped: false),
    BingoCard(image: 'assets/images/GitHub.png', title: 'GitHub', taped: false),
    BingoCard(
        image: 'assets/images/Google Cloud.png',
        title: 'Google Cloud',
        taped: false),
    BingoCard(
        image: 'assets/images/GraphQL.png', title: 'GraphQL', taped: false),
    BingoCard(image: 'assets/images/iOS.png', title: 'iOS', taped: false),
    BingoCard(image: 'assets/images/JSON.png', title: 'JSON', taped: false),
    BingoCard(image: 'assets/images/Lottie.png', title: 'Lottie', taped: false),
    BingoCard(
        image: 'assets/images/Material Desing.png',
        title: 'Material Desing',
        taped: false),
    BingoCard(
        image: 'assets/images/Riverpod.png', title: 'Riverpod', taped: false),
    BingoCard(image: 'assets/images/Sentry.png', title: 'Sentry', taped: false),
    BingoCard(image: 'assets/images/SQL.png', title: 'SQL', taped: false),
    BingoCard(image: 'assets/images/SQLite.png', title: 'SQLite', taped: false),
    BingoCard(
        image: 'assets/images/VS Code.png', title: 'VS Code', taped: false),
    BingoCard(
        image: 'assets/images/WebSocket.png', title: 'WebSocket', taped: false),
  ];

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
            // style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            '¿Estás seguro de que quieres generar un nuevo tablero?',
            // style: TextStyle(color: Colors.white),
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
                        // Clear image when tapped
                      });
                    },
                    child: Container(
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: !shuffledImages[index].taped
                            ? Stack(
                                //alignment: Alignment.center,
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    child: Image.asset(
                                      shuffledImages[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Text(
                                  //   shuffledImages[index].title,
                                  //   style: const TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  //  ),
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
                                  // Text(shuffledImages[index].title),
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
