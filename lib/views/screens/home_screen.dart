import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_62/core/constants/graphql_mutations.dart';
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
        options: QueryOptions(document: gql(getProducts)),
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
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              controller: scrollController,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Text("ID: ${product['id']}"),
                  title: Text("Title: ${product['title']}"),
                  subtitle: Text(
                      "Description: ${product['description']}\nPrice:${product['price']}"),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          String title = "New Title";
                          String description = "New Description";
                          double price = 120;

                          GraphQLProvider.of(context).value.mutate(
                                MutationOptions(
                                  document: gql(editProduct),
                                  variables: {
                                    "id": 573,
                                    "title": title,
                                    "description": description,
                                    "price": price,
                                  },
                                  onCompleted: (data) {
                                    debugPrint("$data");
                                  },
                                  onError: (error) {
                                    debugPrint("${error!.linkException}");
                                  },
                                ),
                              );
                        },
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          color: Colors.teal,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GraphQLProvider.of(context).value.mutate(
                                MutationOptions(
                                  document: gql(deleteProduct),
                                  variables: {
                                    "id": product['id'],
                                  },
                                  onCompleted: (data) {
                                    debugPrint("$data");
                                  },
                                  onError: (error) {
                                    debugPrint("${error!.linkException}");
                                  },
                                ),
                              );
                        },
                        icon: const Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final client = GraphQLProvider.of(context).value;
          client.mutate(
            MutationOptions(
              document: gql(addProduct),
              variables: const {
                'title': "New Product",
                'price': 12345.0,
                'description': "New Product description",
                'categoryId': 2,
                'images':
                    "https://upload.wikimedia.org/wikipedia/commons/7/78/Image.jpg"
              },
              onCompleted: (data) {
                print(data);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("New Product is added"),
                  ),
                );
                // Navigator.pop(context);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
