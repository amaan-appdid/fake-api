import 'dart:convert';
import 'dart:developer';

import 'package:fake_api/view/full_image.dart';
import 'package:flutter/material.dart';

import '../models/detail_model.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final int? id;
  // Removed undefined 'Tag' class reference
  DetailPage({super.key, this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<DetailModel> detailList = [];
  Future<List<DetailModel>> fetchDetail() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products/" + widget.id.toString()),
    );

    log(widget.id.toString());

    var data = jsonDecode(response.body.toString());
    log(data.toString());

    detailList = [];
    // log(data.toString());
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      detailList.add(DetailModel.fromJson(data));
    }

    return detailList;
  }

  @override
  void initState() {
    fetchDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text("Detail Page"),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: detailList.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullImage(
                              imageUrl: detailList[index].image,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: detailList[index].id,
                        child: Image.network(
                          detailList[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "\Rating : " + detailList[index].rating.rate.toString(),
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
                        detailList[index].title.toString(),
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
                        detailList[index].description,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "\$" + detailList[index].price.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
    // try {
    //   if (response.statusCode == 200) {
    //     detailList.add(DetailModel.fromJson(data));
    //   } else {
    //     return detailList;
    //   }
    // } catch (e) {
    //   log(
    //     e.toString(),
    //   );
    // }
