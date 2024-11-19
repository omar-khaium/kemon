import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  final Client client;

  LocationRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<LocationModel>> featured() async {
    final Map<String, String> headers = {};

    final Response response =
        await client.get(RemoteEndpoints.featuredLocations, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!;

        return data.map((e) => LocationModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load locations');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load locations');
    }
  }
}
