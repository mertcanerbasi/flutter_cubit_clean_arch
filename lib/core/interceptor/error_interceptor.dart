// // Dart imports:
// import 'dart:io';

// // Package imports:
// import 'package:dio/dio.dart';

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     switch (err.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.badCertificate:
//         throw SSLCertificateException(err.requestOptions);
//       case DioExceptionType.connectionError:
//         throw ConnectionException(err.requestOptions);
//       case DioExceptionType.receiveTimeout:
//         throw DeadlineExceededException(err.requestOptions);
//       case DioExceptionType.badResponse:
//         ErrorModel? model;
//         try {
//           if (err.requestOptions.headers["encrypted"] == true) {
//             try {
//               final value = AesEncryptModel<ErrorModel>.fromJson(
//                 err.response!.data,
//                 (json) => json as dynamic,
//               );
//               model = value.data;
//             } catch (e) {
//               model = ErrorModel.fromJson(err.response!.data);
//             }
//           } else {
//             model = ErrorModel.fromJson(err.response!.data);
//           }
//         } catch (e) {
//           Log.e(e.toString());
//         }
//         if (model != null) {
//           throw BaseError(
//               model.messages?.first ??
//                   model.error ??
//                   "${err.response?.statusCode} - Hata çözümlenemedi",
//               err.requestOptions);
//         }

//         switch (err.response?.statusCode) {
//           case 400:
//             throw BadRequestException(err.requestOptions);
//           case 401:
//             throw UnauthorizedException(err.requestOptions);
//           case 403:
//             throw ForbiddenException(err.requestOptions);
//           case 404:
//             throw NotFoundException(err.requestOptions);
//           case 409:
//             throw ConflictException(err.requestOptions);
//           case 500:
//             throw InternalServerErrorException(err.requestOptions, "500");
//           case 504:
//             throw InternalServerErrorException(err.requestOptions, "504");
//         }
//         break;
//       case DioExceptionType.cancel:
//         break;
//       case DioExceptionType.unknown:
//         switch (err.runtimeType) {
//           case SSLCertificateException:
//             throw SSLCertificateException(err.requestOptions);
//           case SocketException:
//             throw BaseError("Soket Hatası", err.requestOptions);
//           case FormatException:
//             throw BaseError("Format Hatası", err.requestOptions);
//           default:
//             throw NoInternetConnectionException(err.requestOptions);
//         }
//     }

//     return super.onError(err, handler);
//   }
// }

// class ForbiddenException extends DioException {
//   ForbiddenException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Yetkisiz kullanıcı';
//   }
// }

// class ConnectionException extends DioException {
//   ConnectionException(RequestOptions r) : super(requestOptions: r);
//   @override
//   String toString() {
//     return 'Bağlantı hatası';
//   }
// }

// class BaseError extends DioException {
//   BaseError(this.text, RequestOptions r) : super(requestOptions: r);
//   final String text;
//   @override
//   String toString() {
//     return text;
//   }
// }

// class BadRequestException extends DioException {
//   BadRequestException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Invalid request';
//   }
// }

// class InternalServerErrorException extends DioException {
//   final String errorCode;
//   InternalServerErrorException(RequestOptions r, this.errorCode)
//       : super(requestOptions: r);

//   @override
//   String toString() {
//     return '$errorCode Bilinmeyen bir hata oluştu, lütfen daha sonra tekrar deneyin.';
//   }
// }

// class ConflictException extends DioException {
//   ConflictException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Conflict occurred';
//   }
// }

// class UnauthorizedException extends DioException {
//   UnauthorizedException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Access denied';
//   }
// }

// class NotFoundException extends DioException {
//   NotFoundException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'The requested information could not be found';
//   }
// }

// class NoInternetConnectionException extends DioException {
//   NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'İnternet bağlantısı bulunamadı, tekrar deneyin.';
//   }
// }

// class DeadlineExceededException extends DioException {
//   DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Bağlantı zaman aşımına uğradı.';
//   }
// }

// class CancelException extends DioException {
//   CancelException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Yetkisiz işlem.';
//   }
// }

// class SSLCertificateException extends DioException {
//   SSLCertificateException(RequestOptions r)
//       : super(requestOptions: r, type: DioExceptionType.unknown);

//   @override
//   String toString() {
//     return 'Sertifika doğrulanamadı.';
//   }
// }
