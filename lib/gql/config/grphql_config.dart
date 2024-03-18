import 'package:graphql_flutter/graphql_flutter.dart';

class GrphQLConfig {
  final HttpLink httpLink =
      HttpLink("https://flutter-crud-app.hasura.app/v1/graphql");
  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}
