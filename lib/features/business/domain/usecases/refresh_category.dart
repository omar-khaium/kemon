import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class RefreshBusinessesByCategoryUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> call({
    required String category,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  }) async =>
      await repository.refreshCategory(
        category: category,
        query: query,
        sort: sort,
        division: division,
        district: district,
        thana: thana,
        sub: subCategory,
        ratings: ratings,
      );
}
