import 'package:flutter/material.dart';
import 'package:hyrule/presenter/screens/results.dart';
import 'package:hyrule/utils/consts/categories.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Results(category: category),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    color: const Color(0xFF0079CF).withOpacity(0.2),
                    blurStyle: BlurStyle.outer,
                  )
                ],
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  width: 2.0,
                  color: const Color(0xFF0079CF),
                ),
              ),
              child: Center(
                child: Image.asset("$imagePath$category.png"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            categories[category]!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xFF0079CF),
                ),
          ),
        )
      ],
    );
  }
}
