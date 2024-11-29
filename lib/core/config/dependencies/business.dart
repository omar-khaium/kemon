part of '../config.dart';

Future<void> get businessDependencies async {
  //! ----------------- Bloc -----------------
  sl.registerFactory(
    () => FindBusinessBloc(
      find: sl(),
      refresh: sl(),
    ),
  );
  sl.registerFactory(
    () => FindBusinessesByCategoryBloc(
      find: sl(),
      refresh: sl(),
    ),
  );
  sl.registerFactory(
    () => FindBusinessesByLocationBloc(
      find: sl(),
      refresh: sl(),
    ),
  );

  //! ----------------- UseCase -----------------
  sl.registerFactory(
    () => FindBusinessUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshBusinessUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => BusinessesByCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshBusinessesByCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => BusinessesByLocationUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
    () => RefreshBusinessesByLocationUseCase(
      repository: sl(),
    ),
  );

  //! ----------------- Repository -----------------
  sl.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(
      network: sl(),
      remote: sl(),
      local: sl(),
      subCategory: sl(),
    ),
  );

  //! ----------------- Data sources -----------------
  sl.registerLazySingleton<BusinessRemoteDataSource>(
    () => BusinessRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<BusinessLocalDataSource>(
    () => BusinessLocalDataSourceImpl(),
  );
}
