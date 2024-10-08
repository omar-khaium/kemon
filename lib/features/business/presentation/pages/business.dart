import '../../../../core/shared/shared.dart';
import '../../business.dart';
import '../../../review/review.dart';

class BusinessPage extends StatelessWidget {
  static const String path = '/business/:urlSlug';
  static const String name = 'BusinessPage';

  final String urlSlug;

  const BusinessPage({
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
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: theme.backgroundTertiary,
            surfaceTintColor: theme.backgroundTertiary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: theme.textPrimary),
              onPressed: context.pop,
            ),
            title: BlocBuilder<FindBusinessBloc, FindBusinessState>(
              builder: (context, state) {
                if (state is FindBusinessDone) {
                  final business = state.business;
                  return Text(
                    business.name.full,
                    style: TextStyles.title(context: context, color: theme.textPrimary).copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  );
                }
                return Container();
              },
            ),
            centerTitle: false,
            actions: [
              IconButton(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    barrierColor: context.barrierColor,
                    barrierDismissible: true,
                    builder: (_) => BlocProvider.value(
                      value: context.read<FindBusinessBloc>(),
                      child: const BusinessAboutWidget(),
                    ),
                  );
                },
                icon: Icon(Icons.info_outline_rounded, color: theme.primary),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: const [
              BusinessInformationWidget(),
              BusinessRatingsWidget(),
              BusinessReviewsWidget(),
            ],
          ),
        );
      },
    );
  }
}
