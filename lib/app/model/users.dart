import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/app/model/users.freezed.dart';
part '../../generated/app/model/users.g.dart';

@freezed
class Users with _$Users {
  const factory Users({
    String? userId,
    String? email,
    String? firstName,
    String? lastName,
  }) = _Users;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}
