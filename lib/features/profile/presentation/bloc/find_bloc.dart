import '../../../../core/shared/shared.dart';
import '../../profile.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindProfileBloc extends Bloc<FindProfileEvent, FindProfileState> {
  final FindProfileUseCase find;
  final RefreshProfileUseCase refresh;
  FindProfileBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindProfileInitial()) {
    on<FindProfile>((event, emit) async {
      emit(const FindProfileLoading());
      final result = await find(identity: event.identity);
      result.fold(
        (failure) => emit(FindProfileError(failure: failure)),
        (profile) => emit(FindProfileDone(profile: profile)),
      );
    });
    on<RefreshProfile>((event, emit) async {
      emit(const FindProfileLoading());
      final result = await refresh(identity: event.identity);
      result.fold(
        (failure) => emit(FindProfileError(failure: failure)),
        (profile) => emit(FindProfileDone(profile: profile)),
      );
    });
  }
}
