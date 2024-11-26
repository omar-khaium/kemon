import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class FindLeaderboardUseCase {
  final LeaderboardRepository repository;

  FindLeaderboardUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LeaderboardResponse>> call({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  }) async {
    return await repository.find(page: page, query: query, from: from, to: to);
  }
}
