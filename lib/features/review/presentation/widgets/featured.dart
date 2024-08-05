import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FeaturedReviewsWidget extends StatelessWidget {
  const FeaturedReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<RecentReviewsBloc, RecentReviewsState>(
          builder: (_, state) {
            if (state is RecentReviewsLoading) {
              return const FeaturedReviewsShimmerWidget();
            } else if (state is RecentReviewsDone) {
              final reviews = state.reviews;
              return ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Text(
                    "Recent reviews",
                    style: TextStyles.title(context: context, color: theme.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  if (reviews.isNotEmpty)
                    CarouselSlider.builder(
                      itemCount: reviews.length,
                      itemBuilder: (_, index, __) {
                        final review = reviews[index];
                        return FeaturedReviewItemWidget(review: review);
                      },
                      options: CarouselOptions(
                        aspectRatio: 2.75,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeFactor: .33,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayInterval: const Duration(seconds: 5),
                        viewportFraction: .9,
                        clipBehavior: Clip.none,
                        padEnds: true,
                      ),
                    ),
                  if (reviews.isEmpty) const Text('No reviews yet'),
                  const SizedBox(height: 16),
                ],
              );
            } else if (state is RecentReviewsError) {
              return Center(
                child: Text(state.failure.message),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}