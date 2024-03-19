import 'package:graphql_flutter/graphql_flutter.dart';

class GrphQLConfig {
  static HttpLink httpLink = HttpLink(
      "link",
      defaultHeaders: {
        'content-type': "application/json",
        'x-hasura-admin-secret':
            "password",
      });

  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}

