import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GrphQLConfig {
  static HttpLink httpLink =
      HttpLink(dotenv.get('GRAPHQL_BASE_URL'), defaultHeaders: {
    'content-type': "application/json",
    'x-hasura-admin-secret': dotenv.get('GRAPHQL_ADMIN_KEY'),
  });

  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}
