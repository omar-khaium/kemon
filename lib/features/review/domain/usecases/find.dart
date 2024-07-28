import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindUserReviewsUseCase {
  final ReviewRepository repository;

  FindUserReviewsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<ReviewEntity>>> call({
    required Identity user,
  }) async {
    return await repository.find(user: user);
  }
}
