import 'package:flutter/material.dart';
import 'package:flutter_day_62/core/constants/graphql_queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeScreen')),
      body: Query(
        options: QueryOptions(document: gql(fetchProducts)),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Center(
              child: Text("GQL Exception${result.exception}"),
            );
          }
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List products = result.data!['products'];

          return Scrollbar(
            controller: scrollController,
            interactive: true,
            thumbVisibility: true,
            trackVisibility: true,
            child: ListView.builder(
              controller: scrollController,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(product['title']),
                  subtitle: Text(product['description']),
                  trailing: Text("${product['price']}"),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
