import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsetsDirectional.only(
          start: 20, top: 60, bottom: 30, end: 20),
      itemCount: 6,
      clipBehavior: Clip.antiAlias,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisExtent: 250,
          mainAxisSpacing: 60,
          crossAxisSpacing: 40),
      itemBuilder: (context, index) => Container(),
    );
  }
}
