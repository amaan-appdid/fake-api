import 'dart:convert';

import 'package:fake_api/view/detail_page.dart';
import 'package:fake_api/view/search_screen.dart';
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
  Future<List<StoreModel>> fetchStoreData() async {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    var data = jsonDecode(response.body.toString());

    storeList = [];

    if (response.statusCode == 200) {
      for (Map i in data) {
        storeList.add(StoreModel.fromJson(i.cast<String, dynamic>()));
      }
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: TextFormField(
          //     controller: searchController,
          //     onChanged: (value) {
          //       setState(() {
          //         searchstoreList = storeList.where((e) => e.title.toLowerCase().contains(value)).toList();
          //       });
          //     },
          //
          //     decoration: InputDecoration(
          //       suffixIcon: GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             searchController.clear();
          //             searchstoreList = storeList;
          //           });
          //         },
          //         child: Icon(Icons.clear),
          //       ),
          //       hintText: "Search",
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20),
          //         borderSide: BorderSide.none,
          //       ),
          //       filled: true,
          //       fillColor: Colors.grey[200],
          //     ),
          //   ),
          // ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    storelist: storeList,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search Products",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: fetchStoreData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: storeList.length,
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
                                  id: storeList[index].id,
                                ),
                              ),
                            );
                          },
                          leading: Hero(
                            tag: storeList[index].id,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: Image.network(
                                storeList[index].image,
                                fit: BoxFit.cover,
                              ).image,
                            ),
                          ),
                          title: Text(
                            storeList[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            storeList[index].description,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
