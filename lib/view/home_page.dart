import 'dart:convert';
import 'dart:developer';

import 'package:fake_api/view/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/store_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<StoreModel> storeList = [];
  List<StoreModel> searchstoreList = [];
  Future<List<StoreModel>> fetchStoreData() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    var data = jsonDecode(response.body.toString());

    storeList = [];

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      log(data.toString());
      for (Map i in data) {
        storeList.add(StoreModel.fromJson(i.cast<String, dynamic>()));
      }
      searchstoreList = storeList;
    } else {
      return storeList;
    }
    return storeList;
  }

  @override
  void initState() {
    super.initState();
    fetchStoreData();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text("Store list"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchstoreList = storeList.where((e) => e.title.toLowerCase().contains(value)).toList();
                });
              },
              // setState(
              //   () {
              //     searchstoreList = storeList.where((e) => e.title.toLowerCase().contains(value)).toList();
              //   },
              // );
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      searchController.clear();
                      searchstoreList = storeList;
                    });
                  },
                  child: Icon(Icons.clear),
                ),
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchstoreList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              id: searchstoreList[index].id,
                            ),
                          ),
                        );
                      },
                      leading: Hero(
                        tag: searchstoreList[index].id,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.network(
                            searchstoreList[index].image,
                            fit: BoxFit.cover,
                          ).image,
                        ),
                      ),
                      title: Text(
                        searchstoreList[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        searchstoreList[index].description,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
