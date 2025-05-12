import 'package:fake_api/models/store_model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, required this.storelist});

  TextEditingController searchController = TextEditingController();
  final List<StoreModel> storelist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {},
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
              itemCount: storelist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(storelist[index].title.toString()),
                    subtitle: Text(storelist[index].description.toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(storelist[index].image.toString()),
                    ),
                    onTap: () {},
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
