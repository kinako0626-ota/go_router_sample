import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/app/model/user.freezed.dart';
part '../../generated/app/model/user.g.dart';

@freezed
class User with _$User {
  const factory User(
    String userId,
    String? email,
    String? firstName,
    String? lastName,
  ) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
