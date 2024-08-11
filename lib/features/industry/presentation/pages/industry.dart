import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../industry.dart';

class IndustryPage extends StatelessWidget {
  static const String path = '/industry/:urlSlug';
  static const String name = 'IndustryPage';

  final String urlSlug;
  const IndustryPage({
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
            title: BlocBuilder<FindIndustryBloc, FindIndustryState>(
              builder: (context, state) {
                if (state is FindIndustryDone) {
                  final industry = state.industry;
                  return Text(
                    industry.name.full,
                    style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Container();
              },
            ),
            centerTitle: false,
          ),
          body: BlocBuilder<FindBusinessesByCategoryBloc, FindBusinessesByCategoryState>(
            builder: (context, state) {
              if (state is FindBusinessesByCategoryLoading) {
                return ListView.separated(
                  cacheExtent: double.maxFinite,
                  itemBuilder: (_, index) {
                    return const BusinessItemShimmerWidget();
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                );
              } else if (state is FindBusinessesByCategoryDone) {
                final businesses = state.businesses;
                return businesses.isNotEmpty
                    ? ListView.separated(
                        cacheExtent: double.maxFinite,
                        itemBuilder: (_, index) {
                          final business = businesses[index];
                          return BusinessItemWidget(urlSlug: business.urlSlug);
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemCount: businesses.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: context.height * .25),
                          child: Text(
                            "No listing found :(",
                            style: TextStyles.title(context: context, color: theme.backgroundTertiary),
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
