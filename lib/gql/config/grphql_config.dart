import 'package:graphql_flutter/graphql_flutter.dart';

class GrphQLConfig {
  static HttpLink httpLink = HttpLink(
      "your hasura graphql url",
      defaultHeaders: {
        'content-type': "application/json",
        'x-hasura-admin-secret':
            "your admin secret password",
      });

  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}

