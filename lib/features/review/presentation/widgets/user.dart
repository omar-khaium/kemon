import '../../../../core/shared/shared.dart';
import '../../review.dart';

class UserReviewsWidget extends StatelessWidget {
  const UserReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindUserReviewsBloc, FindUserReviewsState>(
      builder: (context, state) {
        if (state is FindUserReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FindUserReviewsError) {
          return Center(child: Text(state.failure.message));
        } else if (state is FindUserReviewsDone) {
          final List<ReviewEntity> reviews = state.reviews;

          return reviews.isEmpty
              ? Center(
                  child: Text(
                    'No reviews found :(',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : ListView.separated(
                  itemBuilder: (_, index) {
                    final review = reviews[index];
                    return UserReviewItemWidget(review: review);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  physics: const ScrollPhysics(),
                  itemCount: reviews.length,
                  padding: const EdgeInsets.all(16.0)
                      .copyWith(bottom: 16 + context.bottomInset),
                  shrinkWrap: true,
                );
        }
        return const SizedBox();
      },
    );
  }
}
