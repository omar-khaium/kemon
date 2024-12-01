import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewLikeButton extends StatelessWidget {
  final Identity review;
  const ReviewLikeButton({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.scheme;
    return BlocBuilder<ReactionBloc, ReactionState>(
      builder: (context, state) {
        if (state is ReactionDone) {
          final liked = state.reactions.iLiked(identity: context.auth.identity);
          final likes = state.reactions.likes;
          return BlocProvider(
            create: (_) => sl<ReactOnReviewBloc>(),
            child: BlocConsumer<ReactOnReviewBloc, ReactOnReviewState>(
              listener: (context, state) {
                if (state is ReactOnReviewDone) {
                  final business = context.business;
                  final reviewBloc = context.read<FindListingReviewsBloc>();
                  reviewBloc.add(
                    RefreshListingReviews(urlSlug: business.urlSlug, filter: reviewBloc.state.filter),
                  );
                } else if (state is ReactOnReviewError) {
                  context.errorNotification(message: state.failure.message);
                }
              },
              builder: (builderContext, state) {
                if (state is ReactOnReviewLoading) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: Dimension.padding.horizontal.large),
                      ShimmerIcon(radius: Dimension.radius.twelve),
                      SizedBox(width: Dimension.padding.horizontal.verySmall),
                      ShimmerLabel(
                        width: Dimension.size.horizontal.thirtyTwo,
                        height: Dimension.size.vertical.twelve,
                        radius: Dimension.radius.twelve,
                      ),
                    ],
                  ).animate().fade();
                }
                return TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.radius.eight,
                      vertical: Dimension.radius.four,
                    ),
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimension.radius.sixteen),
                    ),
                    overlayColor: theme.positive,
                  ),
                  icon: Icon(
                    liked ? Icons.thumb_up_off_alt_rounded : Icons.thumb_up_off_alt_outlined,
                    color: liked ? theme.positive : theme.textSecondary,
                    size: Dimension.radius.twelve,
                  ),
                  label: Text(
                    '${likes > 0 ? "$likes " : ''}Like${likes > 1 ? 's' : ''}',
                    style: TextStyles.body(
                      context: context,
                      color: liked ? theme.positive : theme.textSecondary,
                    ).copyWith(
                      fontWeight: liked ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onPressed: () async {
                    final business = context.business;
                    final profile = context.auth.profile;
                    final ProfileModel? authorization = profile ??
                        await context.pushNamed<ProfileModel>(
                          CheckProfilePage.name,
                          queryParameters: {'authorize': "true"},
                        );
                    if (authorization == null) {
                      return;
                    }

                    if (!context.mounted) return;
                    builderContext.read<ReactOnReviewBloc>().add(
                          ReactOnReview(
                            review: review,
                            reaction: Reaction.like,
                            listing: business.identity,
                          ),
                        );
                  },
                ).animate().fade();
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
