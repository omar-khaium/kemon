import '../../features/business/business.dart';
import '../../features/category/category.dart';
import '../../features/home/home.dart';
import '../../features/industry/industry.dart';
import '../../features/leaderboard/leaderboard.dart';
import '../../features/login/login.dart';
import '../../features/profile/profile.dart';
import '../../features/registration/registration.dart';
import '../../features/review/review.dart';
import '../../features/search/search.dart';
import '../../features/sub_category/sub_category.dart';
import '../config/config.dart';
import 'shared.dart';

final router = GoRouter(
  initialLocation: HomePage.path,
  routes: [
    GoRoute(
      path: HomePage.path,
      name: HomePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<FeaturedCategoriesBloc>()..add(const FeaturedCategories())),
          BlocProvider(create: (context) => sl<RecentReviewsBloc>()..add(const RecentReviews())),
          BlocProvider(create: (context) => sl<CheckProfileBloc>()),
          BlocProvider(create: (context) => sl<LoginBloc>()),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: LoginPage.path,
      name: LoginPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindProfileBloc>()
              ..add(
                FindProfile(identity: Identity.guid(guid: state.uri.queryParameters['guid']!)),
              ),
          ),
          BlocProvider(create: (context) => sl<LoginBloc>()),
        ],
        child: LoginPage(
          username: state.uri.queryParameters['username']!,
          redirectTo: state.uri.queryParameters['redirectTo'],
        ),
      ),
      redirect: (context, state) => state.uri.queryParameters.containsKey('guid') ? null : CheckProfilePage.path,
    ),
    GoRoute(
      path: CheckProfilePage.path,
      name: CheckProfilePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<CheckProfileBloc>()),
        ],
        child: CheckProfilePage(
          redirectTo: state.uri.queryParameters['redirectTo'],
        ),
      ),
    ),
    GoRoute(
      path: VerifyOTPPage.path,
      name: VerifyOTPPage.name,
      builder: (_, state) => BlocProvider(
        create: (_) => sl<OtpBloc>(),
        child: VerifyOTPPage(
          otp: state.uri.queryParameters['otp']!,
          username: state.uri.queryParameters['username']!,
          redirectTo: state.uri.queryParameters['redirectTo'],
        ),
      ),
    ),
    GoRoute(
      path: RegistrationPage.path,
      name: RegistrationPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<RegistrationBloc>(),
          ),
        ],
        child: RegistrationPage(
          username: state.uri.queryParameters['username']!,
          fallback: bool.tryParse(state.uri.queryParameters['fallback'] ?? '') ?? false,
        ),
      ),
    ),
    GoRoute(
      path: ProfilePage.path,
      name: ProfilePage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: context.auth.identity!)),
        child: const ProfilePage(),
      ),
    ),
    GoRoute(
      path: DeactivateAccountPage.path,
      name: DeactivateAccountPage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<DeactivateAccountBloc>(),
        child: DeactivateAccountPage(
          otp: state.uri.queryParameters['otp']!,
        ),
      ),
    ),
    GoRoute(
      path: PublicProfilePage.path,
      name: PublicProfilePage.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<FindProfileBloc>()
          ..add(
            FindProfile(
              identity: Identity.guid(guid: state.pathParameters['user']!),
            ),
          ),
        child: PublicProfilePage(
          identity: Identity.guid(guid: state.pathParameters['user']!),
        ),
      ),
    ),
    GoRoute(
      path: EditProfilePage.path,
      name: EditProfilePage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindProfileBloc>()..add(FindProfile(identity: context.auth.identity!)),
          ),
          BlocProvider(create: (context) => sl<UpdateProfileBloc>()),
        ],
        child: const EditProfilePage(),
      ),
    ),
    GoRoute(
      path: UserReviewsPage.path,
      name: UserReviewsPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindProfileBloc>()
              ..add(
                FindProfile(
                  identity: Identity.guid(guid: state.pathParameters['user']!),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindUserReviewsBloc>()
              ..add(
                FindUserReviews(
                  user: Identity.guid(guid: state.pathParameters['user']!),
                ),
              ),
          ),
        ],
        child: UserReviewsPage(
          identity: Identity.guid(guid: state.pathParameters['user']!),
        ),
      ),
    ),
    GoRoute(
      path: SearchPage.path,
      name: SearchPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<SearchSuggestionBloc>()),
        ],
        child: const SearchPage(),
      ),
    ),
    GoRoute(
      path: ResultPage.path,
      name: ResultPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<SearchResultBloc>()
              ..add(
                SearchResult(
                  query: state.uri.queryParameters['query']!,
                  filter: (
                    category: null,
                    subCategory: null,
                    division: null,
                    district: null,
                    thana: null,
                    industry: null,
                    sortBy: null,
                    filterBy: null,
                  ),
                ),
              ),
          ),
        ],
        child: ResultPage(
          query: state.uri.queryParameters['query']!,
        ),
      ),
    ),
    GoRoute(
      path: BusinessPage.path,
      name: BusinessPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindBusinessBloc>()
              ..add(
                FindBusiness(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindRatingBloc>()
              ..add(
                FindRating(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindListingReviewsBloc>()
              ..add(
                FindListingReviews(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: BusinessPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: NewReviewPage.path,
      name: NewReviewPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindBusinessBloc>()
              ..add(
                FindBusiness(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(create: (context) => sl<CreateReviewBloc>()),
        ],
        child: NewReviewPage(
          urlSlug: state.pathParameters['urlSlug']!,
          rating: double.tryParse(state.uri.queryParameters['rating'] ?? '') ?? 0.0,
        ),
      ),
    ),
    GoRoute(
      path: PhotoPreviewPage.path,
      name: PhotoPreviewPage.name,
      builder: (context, state) => PhotoPreviewPage(
        url: state.pathParameters['url']!.split(','),
        index: int.tryParse(state.uri.queryParameters['index'] ?? '') ?? 0,
      ),
    ),
    GoRoute(
      path: IndustryPage.path,
      name: IndustryPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindIndustryBloc>()
              ..add(
                FindIndustry(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByCategoryBloc>()
              ..add(
                FindBusinessesByCategory(
                  category: state.pathParameters['urlSlug']!,
                ),
              ),
          ),
        ],
        child: IndustryPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: CategoryPage.path,
      name: CategoryPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FilterBloc(),
          ),
          BlocProvider(
            create: (context) => sl<FindCategoryBloc>()
              ..add(
                FindCategory(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByCategoryBloc>()
              ..add(
                FindBusinessesByCategory(category: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: CategoryPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: SubCategoryPage.path,
      name: SubCategoryPage.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FindSubCategoryBloc>()
              ..add(
                FindSubCategory(urlSlug: state.pathParameters['urlSlug']!),
              ),
          ),
          BlocProvider(
            create: (context) => sl<FindBusinessesByCategoryBloc>()
              ..add(
                FindBusinessesByCategory(category: state.pathParameters['urlSlug']!),
              ),
          ),
        ],
        child: SubCategoryPage(
          urlSlug: state.pathParameters['urlSlug']!,
        ),
      ),
    ),
    GoRoute(
      path: LeaderboardPage.path,
      name: LeaderboardPage.name,
      builder: (context, state) => const LeaderboardPage(),
    ),
  ],
);
