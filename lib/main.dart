import 'package:flutter/material.dart';
import 'package:flutter_day_62/config/graphql_config.dart';
import 'package:flutter_day_62/views/screens/home_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  final client = GraphqlConfig.initializeClient();
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final ValueNotifier<GraphQLClient> client;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child:  CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
