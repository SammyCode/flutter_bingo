import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bingo/bingo_images.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // --- Auth gate ---
  bool _isAuthenticated = false;
  final TextEditingController _codeController = TextEditingController();
  bool _showError = false;

  // --- Main screen state ---
  late List<String> _shuffledImages;
  int _currentIndex = 0;
  final List<String> _shownImages = [];

  @override
  void initState() {
    super.initState();
    final allImages = bingoImages.map((e) => e.image).toList();
    _shuffledImages = List.from(allImages)..shuffle(Random());
    if (_shuffledImages.isNotEmpty) {
      _shownImages.add(_shuffledImages[0]);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyCode() {
    if (_codeController.text == 'FlutterGT') {
      setState(() {
        _isAuthenticated = true;
        _showError = false;
      });
    } else {
      setState(() => _showError = true);
    }
  }

  Widget _buildCodeGate() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Admin - Presentador',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 103, 176),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: Color.fromARGB(255, 1, 103, 176),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Acceso restringido',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 103, 176),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ingresa el código para continuar',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _codeController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, letterSpacing: 4),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    hintStyle: const TextStyle(letterSpacing: 4),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _showError
                            ? Colors.red
                            : const Color.fromARGB(255, 1, 103, 176),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: _showError
                            ? Colors.red
                            : const Color.fromARGB(255, 1, 103, 176),
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (_) => _verifyCode(),
                  onChanged: (_) {
                    if (_showError) setState(() => _showError = false);
                  },
                ),
                const SizedBox(height: 12),
                // Error message
                AnimatedOpacity(
                  opacity: _showError ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            color: Colors.red.shade700, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Codigo Incorrecto',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 103, 176),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _verifyCode,
                    child: const Text(
                      'Entrar',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goNext() {
    if (_currentIndex < _shuffledImages.length - 1) {
      setState(() {
        _currentIndex++;
        if (!_shownImages.contains(_shuffledImages[_currentIndex])) {
          _shownImages.add(_shuffledImages[_currentIndex]);
        }
      });
    }
  }

  void _goPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  String _imageName(String path) {
    final name = path.split('/').last;
    return name.replaceAll('.png', '');
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Color.fromARGB(255, 1, 103, 176), size: 28),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Imágenes mostradas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 103, 176),
                          ),
                        ),
                      ),
                      Text(
                        '${_shownImages.length}/${_shuffledImages.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  Flexible(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _shownImages.length,
                      itemBuilder: (ctx, i) {
                        return Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 1, 103, 176),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    _shownImages[i],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _imageName(_shownImages[i]),
                              style: const TextStyle(fontSize: 9),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 1, 103, 176),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cerrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) return _buildCodeGate();

    final currentImage =
        _shuffledImages.isEmpty ? null : _shuffledImages[_currentIndex];
    final isFirst = _currentIndex == 0;
    final isLast = _currentIndex == _shuffledImages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Admin - Presentador',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 103, 176),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${_shuffledImages.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: _shuffledImages.isEmpty
                ? 0
                : (_currentIndex + 1) / _shuffledImages.length,
            backgroundColor: Colors.grey.shade200,
            color: const Color.fromARGB(255, 1, 103, 176),
            minHeight: 4,
          ),

          // Main image display
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: currentImage == null
                  ? const Center(child: Text('No hay imágenes'))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image name
                        Text(
                          _imageName(currentImage),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 103, 176),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        // Big image
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 1, 103, 176),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade100,
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.asset(
                                currentImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Previous button
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.arrow_back_ios),
                    label: const Text('Anterior'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isFirst
                          ? Colors.grey
                          : const Color.fromARGB(255, 1, 103, 176),
                      side: BorderSide(
                        color: isFirst
                            ? Colors.grey.shade300
                            : const Color.fromARGB(255, 1, 103, 176),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isFirst ? null : _goPrevious,
                  ),
                ),
                const SizedBox(width: 12),

                // Finish button
                ElevatedButton.icon(
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Ver'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _showFinishDialog,
                ),
                const SizedBox(width: 12),

                // Next button
                Expanded(
                  child: ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward_ios),
                    label: const Text('Siguiente'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLast
                          ? Colors.grey.shade300
                          : const Color.fromARGB(255, 1, 103, 176),
                      foregroundColor: isLast ? Colors.grey : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLast ? null : _goNext,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Developed by SammyCode',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
