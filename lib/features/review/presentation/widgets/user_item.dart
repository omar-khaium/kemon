import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../review.dart';

class UserReviewItemWidget extends StatelessWidget {
  final ReviewEntity review;
  const UserReviewItemWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return InkWell(
          onTap: () {
            context.pushNamed(
              BusinessPage.name,
              pathParameters: {'urlSlug': review.listing},
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundPrimary,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: theme.backgroundTertiary, width: .75),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              children: [
                BlocProvider(
                  create: (context) => sl<FindBusinessBloc>()
                    ..add(FindBusiness(urlSlug: review.listing)),
                  child: Row(
                    children: [
                      BusinessLogoWidget(
                        size: 36,
                        radius: 36,
                        onTap: () {
                          context.pushNamed(
                            BusinessPage.name,
                            pathParameters: {'urlSlug': review.listing},
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BusinessNameWidget(
                              maxLines: 1,
                              style: TextStyles.body(
                                      context: context, color: theme.primary)
                                  .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RatingBarIndicator(
                                  rating: review.rating.toDouble(),
                                  itemBuilder: (context, index) => Icon(
                                      Icons.star_rounded,
                                      color: theme.primary),
                                  unratedColor: theme.backgroundTertiary,
                                  itemCount: 5,
                                  itemSize: 16,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.circle,
                                    size: 4, color: theme.backgroundTertiary),
                                const SizedBox(width: 8),
                                StreamBuilder(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 1)),
                                  builder: (context, snapshot) {
                                    return Text(
                                      review.date.duration,
                                      style: TextStyles.caption(
                                              context: context,
                                              color: theme.textSecondary)
                                          .copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  review.title,
                  style: TextStyles.subTitle(
                          context: context, color: theme.textPrimary)
                      .copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
                ),
                if (review.description != null) ...[
                  const SizedBox(height: 4),
                  ReadMoreText(
                    review.description ?? "",
                    style: TextStyles.body(
                        context: context, color: theme.textSecondary),
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: '...more',
                    trimExpandedText: '\t\tShow less',
                    lessStyle: TextStyles.subTitle(
                            context: context, color: theme.primary)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    moreStyle: TextStyles.subTitle(
                            context: context, color: theme.primary)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (review.photos.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 64,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review.photos.length,
                      itemBuilder: (context, index) {
                        final photo = review.photos[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () {
                                context.pushNamed(
                                  PhotoPreviewPage.name,
                                  pathParameters: {
                                    'url': review.photos
                                        .map((e) => e.url)
                                        .join(',')
                                  },
                                  queryParameters: {'index': index.toString()},
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: photo.url,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error_outline_rounded),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                /* const Divider(height: 24, thickness: .075),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                icon: Icon(Icons.thumb_up_rounded, color: theme.primary),
                                label: Text(
                                  review.likes.toString(),
                                  style: TextStyles.subTitle(context: context, color: theme.primary),
                                ),
                                onPressed: () {},
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                icon: const Icon(Icons.report_rounded),
                                label: const Text("Report"),
                              ),
                            ],
                          ), */
              ],
            ),
          ),
        );
      },
    );
  }
}
