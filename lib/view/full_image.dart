import 'package:flutter/material.dart';

class FullImage extends StatefulWidget {
  final String? imageUrl;
  const FullImage({super.key, this.imageUrl});

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Full Image",
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: widget.imageUrl.toString(),
            child: Container(
              child: Image.network(
                widget.imageUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
