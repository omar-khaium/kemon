import '../../../../core/shared/shared.dart';

class IndustryEntity extends Equatable {
  final Identity identity;
  final Name name;
  final String icon;
  final String urlSlug;

  const IndustryEntity({
    required this.identity,
    required this.name,
    required this.icon,
    required this.urlSlug,
  });

  @override
  List<Object> get props => [
        identity,
        name,
        icon,
        urlSlug,
      ];
}
