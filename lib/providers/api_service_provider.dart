import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swagger_ruby_flutter_sample/services/api_service.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  // 環境に応じてbaseUrlを変更
  return ApiService(baseUrl: 'http://localhost:3000');
}
