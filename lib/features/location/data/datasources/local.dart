import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationLocalDataSource {
  FutureOr<void> add({
    required LocationEntity location,
  });

  FutureOr<void> addAll({
    required List<LocationEntity> locations,
  });

  FutureOr<void> update({
    required LocationEntity location,
  });

  FutureOr<void> remove({
    required String guid,
  });

  FutureOr<void> removeAll();

  FutureOr<LocationEntity> find({
    required String guid,
  });
}