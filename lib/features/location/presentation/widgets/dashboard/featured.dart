import '../../../../../core/shared/shared.dart';
import '../../../location.dart';

class DashboardFeaturedLocationsSectionWidget extends StatelessWidget {
  const DashboardFeaturedLocationsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return BlocBuilder<FeaturedLocationsBloc, FeaturedLocationsState>(
          builder: (_, state) {
            if (state is FeaturedLocationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FeaturedLocationsDone) {
              final locations = state.locations;
              return ListView(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured locations",
                        style: TextStyles.title(context: context, color: theme.textPrimary),
                      ),
                      FilterChip(
                        label: Text(
                          "See all",
                          style: TextStyles.body(context: context, color: theme.primary).copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        deleteIcon: Icon(Icons.open_in_new_rounded, color: theme.primary, size: 14),
                        onDeleted: () {},
                        backgroundColor: theme.backgroundPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(width: 0, color: Colors.transparent),
                        ),
                        padding: EdgeInsets.zero,
                        labelPadding: const EdgeInsets.only(left: 12),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        selected: false,
                        onSelected: (_) {
                          // TODO:
                          // context.pushNamed(LocationsPage.tag);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 140,
                    child: MasonryGridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 0,
                      padding: EdgeInsets.zero,
                      itemCount: locations.length,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final category = locations.elementAt(index);
                        return ActionChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(width: 1, color: theme.positive),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: theme.positiveBackground,
                          onPressed: () {
                            // TODO
                            /* context.pushNamed(
                              CategoryPage.tag,
                              pathParameters: {
                                'id': category.urlSlug,
                              },
                            ); */
                          },
                          avatar: Icon(Icons.place_rounded, color: theme.positive),
                          label: Text(
                            category.name.full,
                            style: TextStyles.subTitle(context: context, color: theme.positive),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            } else if (state is FeaturedLocationsError) {
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
