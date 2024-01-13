import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';
import 'package:hyrule/presenter/screens/details.dart';

class EntryCard extends StatelessWidget {
  EntryCard({super.key, required this.isSaved, required this.entry});

  final bool isSaved;
  final Entry entry;
  final DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Dismissible(
        direction:
            isSaved ? DismissDirection.endToStart : DismissDirection.none,
        key: ValueKey<int>(entry.id),
        onDismissed: (direction) {
          daoController.deleteEntry(entry: entry);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Deletado")));
        },
        background: Container(
          color: Colors.redAccent,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.delete),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(entry: entry),
                  ),
                )
              },
              child: Ink(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 112,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            entry.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            entry.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 21.0,
                              fontFamily: 'Philosopher',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              entry.description,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Wrap(
              children: entry
                  .commonLocationsConverter()
                  .map(
                    (e) => Chip(
                      label: Text(e),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
