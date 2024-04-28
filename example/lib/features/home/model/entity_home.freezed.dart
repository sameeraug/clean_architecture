// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity_home.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeEntity {
  int get counter => throw _privateConstructorUsedError;
  String get myCounter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeEntityCopyWith<HomeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEntityCopyWith<$Res> {
  factory $HomeEntityCopyWith(
          HomeEntity value, $Res Function(HomeEntity) then) =
      _$HomeEntityCopyWithImpl<$Res, HomeEntity>;
  @useResult
  $Res call({int counter, String myCounter});
}

/// @nodoc
class _$HomeEntityCopyWithImpl<$Res, $Val extends HomeEntity>
    implements $HomeEntityCopyWith<$Res> {
  _$HomeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
    Object? myCounter = null,
  }) {
    return _then(_value.copyWith(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
      myCounter: null == myCounter
          ? _value.myCounter
          : myCounter // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeEntityImplCopyWith<$Res>
    implements $HomeEntityCopyWith<$Res> {
  factory _$$HomeEntityImplCopyWith(
          _$HomeEntityImpl value, $Res Function(_$HomeEntityImpl) then) =
      __$$HomeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int counter, String myCounter});
}

/// @nodoc
class __$$HomeEntityImplCopyWithImpl<$Res>
    extends _$HomeEntityCopyWithImpl<$Res, _$HomeEntityImpl>
    implements _$$HomeEntityImplCopyWith<$Res> {
  __$$HomeEntityImplCopyWithImpl(
      _$HomeEntityImpl _value, $Res Function(_$HomeEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counter = null,
    Object? myCounter = null,
  }) {
    return _then(_$HomeEntityImpl(
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
      myCounter: null == myCounter
          ? _value.myCounter
          : myCounter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeEntityImpl extends _HomeEntity {
  const _$HomeEntityImpl({this.counter = 0, this.myCounter = ""}) : super._();

  @override
  @JsonKey()
  final int counter;
  @override
  @JsonKey()
  final String myCounter;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeEntityImplCopyWith<_$HomeEntityImpl> get copyWith =>
      __$$HomeEntityImplCopyWithImpl<_$HomeEntityImpl>(this, _$identity);
}

abstract class _HomeEntity extends HomeEntity {
  const factory _HomeEntity({final int counter, final String myCounter}) =
      _$HomeEntityImpl;
  const _HomeEntity._() : super._();

  @override
  int get counter;
  @override
  String get myCounter;
  @override
  @JsonKey(ignore: true)
  _$$HomeEntityImplCopyWith<_$HomeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
