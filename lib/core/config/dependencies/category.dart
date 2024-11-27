part of '../config.dart';

Future<void> get categoryDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindCategoryBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FeaturedCategoriesBloc(
      useCase: sl(),
    ),
  );
  sl.registerFactory(
    () => FindAllCategoriesBloc(
      find: sl(),
      refresh: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FeaturedCategoriesUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => FindAllCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshAllCategoryUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(),
  );
}
