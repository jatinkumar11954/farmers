import 'package:carigari_admin/Arrangements/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Scheme extends StatelessWidget {
  
    QuerySnapshot query;
    query = await Firestore.instance.collection("schemes").getDocuments();
    print(qp);
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: 5,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            // builder: (c) => products[i],
            value: scheme[i],
            child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
                ),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}