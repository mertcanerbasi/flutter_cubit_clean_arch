# Flutter Cubit Clean Architecture

This project is a base template for Flutter applications utilizing **Cubit** for state management, **Dio** and **Retrofit** for networking, **GetIt** and **Injectable** for dependency injection, and **AutoRoute** for routing. The architecture follows clean architecture principles, ensuring the codebase is scalable, maintainable, and testable.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
   * [API Integration](#api-integration)
   * [Routing](#routing)
   * [State Management](#state-management)
   * [Dependency Injection](#dependency-injection)

### Features

- **Clean Architecture**: Separation of concerns, with distinct layers for data, domain, and presentation.
- **State Management**: Managed with Cubit from the Flutter Bloc library.
- **Networking**: Handled with Dio and Retrofit, allowing for clean API integration.
- **Dependency Injection**: Managed by GetIt and Injectable, providing an easy way to manage dependencies.
- **Routing**: Managed by AutoRoute, providing a type-safe and scalable routing solution.
- **Logging**: Custom logger interceptor integrated with Dio for tracking API requests and responses.

## Installation

To use this template for your project, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone https://github.com/your-repo/flutter_cubit_clean_arch.git
   cd flutter_cubit_clean_arch
   ```
   

2. **Install Dependencies**:
   ```sh
   flutter pub get
   ```

3. **Generate necessary files**:
   ```sh
   flutter pub run build_runner build
   ```

4. **Run App**:
   ```sh
   flutter run
   ```

## Usage

**API Integration**

The project uses Dio and Retrofit for API integration. The CharacterApiService demonstrates how to define API endpoints:
```sh
@RestApi()
abstract class CharacterApiService {
  factory CharacterApiService(Dio dio) = _CharacterApiService;

  @GET("/character")
  Future<BaseModel<CharacterModel>> getCharacters();
}

```

**Routing**

AutoRoute is used for managing app routes. Routes are defined in app_router.dart:

```sh
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: CharacterRoute.page, initial: true),
      ];
}

```

**State Managament**

Cubit is used for state management. The CharacterCubit manages the state of the CharacterPage:
```sh
@injectable
class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository repository;

  CharacterCubit({required this.repository}) : super(CharacterInitial());


  Future<void> fetchCharacters() async {
    emit(CharacterLoading());
    final failureOrCharacters = await repository.getCharacters();
    emit(failureOrCharacters.fold(
      (failure) => CharacterError(_mapFailureToMessage(failure)),
      (characters) => CharacterLoaded(characters: characters),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}

```

**Dependency Injection**

Dependencies are managed using GetIt and Injectable. The app_module.dart file sets up the DI:
```sh
GetIt getIt = GetIt.instance;
@InjectableInit()
Future setupDI(String environment) => getIt.init(environment: environment);

@module
abstract class AppModule {
  @preResolve
  Future<GetStorage> get storage async {
    await GetStorage.init("MyStorage");
    return GetStorage("MyStorage");
  }

  @lazySingleton
  Dio get injectRetrofitAPI {
    Dio dio = Dio(BaseOptions(baseUrl: "https://rickandmortyapi.com/api"));
    dio.interceptors.add(LoggerInterceptor());
    return dio;
  }

  @lazySingleton
  CharacterApiService get characterApiService =>
      CharacterApiService(injectRetrofitAPI);
}

```