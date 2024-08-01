import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final Client client;

  ProfileRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<CheckResponse> check({
    required String username,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
      };

      final Response response = await post(
        RemoteEndpoints.login,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(response: response);

        if (result.success) {
          if (result.result!.containsKey('otp')) {
            return Left(result.result!["otp"]);
          } else {
            final ProfileModel profile = ProfileModel.parse(map: result.result!);
            return Right(profile);
          }
        } else {
          throw RemoteFailure(message: result.error!);
        }
      } else if (response.statusCode == HttpStatus.internalServerError) {
        throw RemoteFailure(message: "Internal server error.");
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw RemoteFailure(message: "Bad request.");
      } else {
        throw RemoteFailure(message: "Something went wrong.");
      }
    } on SocketException {
      throw NoInternetFailure();
    } catch (error) {
      throw RemoteFailure(message: error.toString());
    }
  }

  @override
  FutureOr<void> delete({
    required String token,
    required Identity identity,
  }) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<ProfileModel> find({
    required Identity identity,
  }) async {
    final Map<String, String> headers = {
      "userId": identity.guid,
    };

    final Response response = await client.get(
      RemoteEndpoints.profile,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final Map<String, dynamic> data = networkReponse.result as Map<String, dynamic>;

        return ProfileModel.parse(map: data['profile']);
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }

  @override
  FutureOr<void> update({
    required String token,
    required ProfileEntity profile,
    XFile? avatar,
  }) async {
    final request = MultipartRequest('POST', RemoteEndpoints.updateProfile);
    request.headers.addAll({
      'authorization': token,
      'userId': profile.identity.guid,
      'firstName': profile.name.first,
      'lastName': profile.name.last,
      'email': profile.contact.email ?? '',
      'phone': profile.contact.phone ?? '',
      'dob': profile.dob?.toIso8601String() ?? '',
      'gender': profile.gender.index.toString(),
      'isupload': avatar != null ? 'true' : 'false',
    });
    if (avatar != null) {
      request.files.add(await MultipartFile.fromPath('File', avatar.path));
    }
    final StreamedResponse response = await request.send();

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to add review');
    }
  }
}
