import '../../../../core/shared/shared.dart';

abstract class RegistrationRemoteDataSource {
  FutureOr<void> create({
    required String username,
    required String password,
    required String refference,
    required Name name,
    required Contact contact,
    required DateTime dob,
    required Gender gender,
  });
}