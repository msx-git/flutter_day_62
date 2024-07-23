import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlConfig {
  static HttpLink httpLink =
      HttpLink("https://api.escuelajs.co/graphql");

  static ValueNotifier<GraphQLClient> initializeClient() {
    final Link link = httpLink;
    return ValueNotifier(GraphQLClient(cache: GraphQLCache(), link: link));
  }
}
