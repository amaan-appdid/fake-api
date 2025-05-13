import 'dart:math';

import 'package:fake_api/models/store_model.dart';
import 'package:flutter/material.dart';

class RandomImageGenerater extends StatefulWidget {
  RandomImageGenerater({super.key, required this.storelist});
  final List<StoreModel> storelist;

  @override
  State<RandomImageGenerater> createState() => _RandomImageGeneraterState();
}

final Random _random = Random();

class _RandomImageGeneraterState extends State<RandomImageGenerater> {
  @override
  Widget build(BuildContext context) {
    int randomIndex = _random.nextInt(widget.storelist.length);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text("Random Image Generator"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.storelist[randomIndex].title.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.storelist[randomIndex].description,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\$" + widget.storelist[randomIndex].price.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (widget.storelist.isNotEmpty)
              Image.network(
                widget.storelist[randomIndex].image.toString(),
                height: 200,
                width: 200,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\Rating : " + widget.storelist[randomIndex].rating.rate.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {});
            //   },
            //   child: const Text("Generate Random Image"),
            // ),
          ],
        ),
      ),
    );
  }
}
