import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.entry});

  final Entry entry;

  final DaoController controller = DaoController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detalhes"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.bookmark),
          onPressed: () {
            controller.saveEntry(entry: entry);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Favoritado")),
            );
          },
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    entry.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 21.0,
                      fontFamily: 'Philosopher',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: entry
                        .commonLocationsConverter()
                        .map(
                          (e) => Chip(
                            label: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: NetworkImage(entry.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(entry.description),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
