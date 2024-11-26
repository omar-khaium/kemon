import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardRepositoryImpl extends LeaderboardRepository {
  final NetworkInfo network;
  final LeaderboardLocalDataSource local;
  final LeaderboardRemoteDataSource remote;

  LeaderboardRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, LeaderboardResponse>> find({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final result = await local.find(
        page: page,
        query: query,
        from: from,
        to: to,
      );
      return Right(result);
    } on LeaderboardNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find(
          page: page,
          query: query,
          from: from,
          to: to,
        );
        await local.add(
          page: page,
          query: query,
          from: from,
          to: to,
          leaderboard: result,
        );
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, LeaderboardResponse>> refresh({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      if (await network.online) {
        await local.removeAll();

        final result = await remote.find(
          page: 1,
          query: '',
          from: from,
          to: to,
        );

        await local.add(page: 1, query: '', from: from, to: to, leaderboard: result);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
