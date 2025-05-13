import 'dart:convert';

import 'package:fake_api/view/detail_page.dart';
import 'package:fake_api/view/random_image_generater.dart';
import 'package:fake_api/view/search.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RandomImageGenerater(storelist: storeList),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text("Store list"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(
                    storeList: storeList,
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
                  SizedBox(width: 10),
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Search Products",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            // Wrap ListView.builder in Expanded
            child: FutureBuilder(
              future: fetchStoreData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
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
                            storeList[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
