import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../sub_category.dart';

class SubCategoryPage extends StatelessWidget {
  static const String path = '/sub-subCategory/:urlSlug';
  static const String name = 'SubCategoryPage';

  final String urlSlug;

  const SubCategoryPage({
    super.key,
    required this.urlSlug,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: context.pop,
            ),
            title: BlocBuilder<FindSubCategoryBloc, FindSubCategoryState>(
              builder: (context, state) {
                if (state is FindSubCategoryDone) {
                  final subCategory = state.subCategory;
                  return Text(
                    subCategory.name.full,
                    style: TextStyles.title(
                            context: context, color: theme.textPrimary)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Container();
              },
            ),
            actions: [
              BlocBuilder<FindBusinessesByCategoryBloc,
                  FindBusinessesByCategoryState>(
                builder: (context, state) {
                  if (state is FindBusinessesByCategoryDone) {
                    return Container(
                      padding: EdgeInsets.only(
                          right: Dimension.padding.horizontal.max),
                      child: Text(
                        '${state.businesses.length} out of ${state.total}',
                        style: TextStyles.caption(
                            context: context, color: theme.textPrimary),
                      ),
                    );
                  } else if (state is FindBusinessesByCategoryPaginating) {
                    return Container(
                      margin: EdgeInsets.only(
                          right: Dimension.padding.horizontal.max),
                      child: Text(
                        'fetching more...',
                        style: TextStyles.caption(
                            context: context, color: theme.textPrimary),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
            centerTitle: false,
          ),
          body: BlocBuilder<FindBusinessesByCategoryBloc,
              FindBusinessesByCategoryState>(
            builder: (context, state) {
              if (state is FindBusinessesByCategoryLoading) {
                return ListView.separated(
                  itemBuilder: (_, index) {
                    return const BusinessItemShimmerWidget();
                  },
                  separatorBuilder: (_, __) =>
                      SizedBox(height: Dimension.padding.vertical.medium),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero.copyWith(
                      bottom:
                          Dimension.padding.vertical.max + context.bottomInset),
                );
              } else if (state is FindBusinessesByCategoryDone) {
                final businesses = state.businesses;
                final hasMore = state.total > businesses.length;

                return businesses.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (_, index) {
                          if (index == businesses.length) {
                            if (state is! FindBusinessesByCategoryPaginating) {
                              context.read<FindBusinessesByCategoryBloc>().add(
                                    PaginateBusinessesByCategory(
                                        page: state.page + 1,
                                        category: urlSlug),
                                  );
                            }
                            return const BusinessItemShimmerWidget();
                          }
                          final business = businesses[index];
                          return BlocProvider(
                            create: (_) => sl<FindBusinessBloc>()
                              ..add(FindBusiness(urlSlug: business.urlSlug)),
                            child: const BusinessItemWidget(),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            SizedBox(height: Dimension.padding.vertical.medium),
                        itemCount: businesses.length + (hasMore ? 1 : 0),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: EdgeInsets.zero.copyWith(
                            bottom: Dimension.padding.vertical.max +
                                context.bottomInset),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.height * .25),
                          child: Text(
                            "No listing found :(",
                            style: TextStyles.title(
                                context: context,
                                color: theme.backgroundTertiary),
                          ),
                        ),
                      );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
