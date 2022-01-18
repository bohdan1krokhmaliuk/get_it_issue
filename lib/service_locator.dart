import 'package:get_it/get_it.dart';

final ServiceLocator serviceLocator = ServiceLocatorImpl();

abstract class ServiceLocator {
  T call<T extends Object>();
  Future<T> getAsync<T extends Object>();
  void disposeLazySingleton<T extends Object>(
      void Function(T) disposingFunction);
  T getWithParams<T extends Object>(
      {String? instanceName, dynamic param1, dynamic param2});
  Future<T> getAsyncWithParams<T extends Object>(
      {String? instanceName, dynamic param1, dynamic param2});
}

class ServiceLocatorImpl implements ServiceLocator {
  ServiceLocatorImpl() {
    getIt
      ..registerFactory<int>(() => 12)
      ..registerFactory<String>(() => 'string');
  }

  GetIt get getIt => GetIt.instance;

  @override
  T call<T extends Object>() => getIt<T>();

  @override
  Future<T> getAsync<T extends Object>() => getIt.getAsync<T>();

  @override
  void disposeLazySingleton<T extends Object>(
      void Function(T) disposingFunction) {
    getIt.resetLazySingleton<T>(disposingFunction: disposingFunction);
  }

  @override
  T getWithParams<T extends Object>(
      {String? instanceName, dynamic param1, dynamic param2}) {
    return getIt<T>(
      instanceName: instanceName,
      param2: param2,
      param1: param1,
    );
  }

  @override
  Future<T> getAsyncWithParams<T extends Object>(
      {String? instanceName, dynamic param1, dynamic param2}) {
    return getIt.getAsync<T>(
      instanceName: instanceName,
      param2: param2,
      param1: param1,
    );
  }
}
