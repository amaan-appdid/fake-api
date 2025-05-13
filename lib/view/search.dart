import 'package:fake_api/view/detail_page.dart';
import 'package:flutter/material.dart';

import '../models/store_model.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.storeList});
  final List<StoreModel> storeList;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchList = widget.storeList
        .where(
          (e) => e.title.toLowerCase().contains(search.text.toLowerCase()),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Search Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: search,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintText: "Search Products",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      search.clear();
                      setState(() {});
                    },
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          searchList[index].title.toString(),
                        ),
                        subtitle: Text(
                          searchList[index].description.toString(),
                        ),
                        leading: Hero(
                          tag: widget.storeList[index].id,

                          child: CircleAvatar(
                            
                            backgroundImage: NetworkImage(searchList[index].image.toString()),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: searchList[index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
