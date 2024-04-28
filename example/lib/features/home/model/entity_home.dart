import 'package:clean_architecture/clean_architecture.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity_home.freezed.dart';

@Freezed()
class HomeEntity extends Entity with _$HomeEntity {
  const HomeEntity._();
  const factory HomeEntity({
    @Default(0) int counter,
    @Default("") String myCounter,
  }) = _HomeEntity;

  @override
  List<Object?> get props => [counter, myCounter];

  @override
  HomeEntity merge({errors}) {
    return copyWith();
  }
}
