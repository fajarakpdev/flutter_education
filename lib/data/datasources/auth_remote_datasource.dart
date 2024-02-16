import 'package:app_fic10/data/datasources/auth_local_datasource.dart';
import 'package:app_fic10/data/models/request/login_request_model.dart';
import 'package:app_fic10/data/models/request/register_request_model.dart';
import 'package:app_fic10/data/models/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

//register
class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel registerRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: registerRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('register gagal');
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      return const Right('Logout Berhasil');
    } else {
      return const Left('Logout Gagal');
    }
  }

  //login
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel data) async {
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/api/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: data.toJson());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('login Gagal');
    }
  }
}
