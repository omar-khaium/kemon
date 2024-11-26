import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReactOnReviewUseCase {
  final ReviewRepository repository;

  ReactOnReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity review,
    required Reaction reaction,
  }) async {
    return await repository.react(review: review, reaction: reaction);
  }
}