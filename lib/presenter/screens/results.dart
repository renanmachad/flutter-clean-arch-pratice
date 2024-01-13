import 'package:flutter/material.dart';
import 'package:hyrule/controllers/api_controller.dart';
import 'package:hyrule/presenter/components/entry_card.dart';
import 'package:hyrule/presenter/screens/favorites.dart';
import 'package:hyrule/utils/consts/categories.dart';

class Results extends StatelessWidget {
  Results({super.key, required this.category});

  final String category;

  final ApiController apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categories[category]!),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favorites(),
                  ),
                );
              },
              icon: const Icon(Icons.bookmark),
            )
          ],
        ),
        body: FutureBuilder(
          future: apiController.getEntriesByCategory(category: category),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                break;
              case ConnectionState.none:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => EntryCard(
                      entry: snapshot.data![index],
                      isSaved: false,
                    ),
                  );
                }
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}
