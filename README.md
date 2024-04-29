<img
style="display: block;  margin-left: auto;  margin-right: auto;"
width="220" height="220" alt="1" src="https://imgur.com/MOdfpsl.png">
# Clean Architecture

Clean Architecture is an architectural approach for designing software systems with a focus on separation of concerns and maintainability. It emphasizes structuring code in a way that business logic is decoupled from the delivery mechanisms such as UI, databases, frameworks, and external interfaces.

## Benefits of Clean Architecture:

- **Maintainability:** Clean Architecture promotes code maintainability by enforcing a clear separation of concerns. Changes in one part of the system are less likely to have ripple effects on other parts.
- **Testability:** With business logic separated from external dependencies, it becomes easier to write unit tests for the core functionality of the application.
- **Flexibility:** Clean Architecture allows for greater flexibility in adopting new technologies or making changes to existing ones. Since the core business logic is decoupled from external dependencies, it is easier to replace or upgrade those dependencies.
- **Scalability:** The modular structure of Clean Architecture makes it easier to scale the application by adding new features or modifying existing ones without significantly impacting the overall system.
- **Reduced Technical Debt:** By enforcing clear boundaries between different parts of the system, Clean Architecture helps in reducing technical debt and makes the codebase more maintainable in the long run.

## Files & Folder Structure:
<img
style="display: block;  margin-left: auto;  margin-right: auto;"
width="400" height="600" alt="1" src="https://imgur.com/BuWeX9H.png">

### Example

- **api**
  - **api_home:** Contains the API-related code for the home feature, including classes or functions responsible for making API requests and handling responses.
- **model**
  - **entity_home:** Contains the entity classes for the home feature, representing core business objects or concepts.
  - **entity_home_freezed:** Contains freezed versions of the entity classes, generated with minimal boilerplate for immutability.
  - **view_model_home:** Contains view model classes for the home feature, responsible for preparing data for display in the user interface.
- **ui**
  - **feature_home:** Contains files related to the user interface of the home feature, including the feature page or widget.
  - **presenter_home:** Contains presenter classes for the home feature, acting as intermediaries between the UI and business logic.
  - **screen_home:** Contains screen classes for the home feature, representing individual screens or pages with layout and navigation logic.
- **use_case**
  - **use_case_home:** Contains the use case logic for the home feature, encapsulating application-specific business rules and functionality.

# Usage

To understand the implementation of clean architecture features and state management, let's consider an example of a counter feature.

## Counter Feature

The Counter Feature's objective is to display the counter value and increment it when the add button is pressed. No API services are required for this example.

Define the entity and view_model to maintain the counter value state.

### entity_home.dart

```dart
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
```

In the provided `HomeEntity` above, you'll observe the inclusion of `counter` and `mycounter` fields. These fields are intended to retain the state of the counter value and the name of the counter, respectively.

In our Entity, there's a `merge` method that allows updating specific fields while preserving the current state of all other fields.

### view_model_home.dart

```dart
import 'package:clean_architecture/clean_architecture.dart';

class HomeViewModel extends ViewModel {
  int counter = 0;
}
```

Based on the `HomeViewModel` outlined above, we've established a `counter` field to maintain the state of the counter value. The UI will present the counter value based on the data stored in the view_model's counter field.

Define the presenter, screen, and use_case to perform the business logic and load the UI respectively.

### presenter_home.dart

```dart
import 'package:clean_architecture/clean_architecture.dart';
import 'package:flutter/material.dart';
import '../model/view_model_home.dart';
import '../use_case/use_case_home.dart';
import 'screen_home.dart';

class HomePresenter extends Presenter<HomeUseCase, HomeViewModel> {
  HomePresenter() : super(HomeUseCase(), HomeViewModel());

  @override
  Widget buildScreen(BuildContext context, HomeUseCase useCase,
      HomeViewModel viewModel, SizingInformation sizingInfo) {

    return HomeScreen(
      viewModel: viewModel,
      sizingInfo: sizingInfo,
      onTap: () => useCase.updateCounter(),
    );
  }

  @override
  Future<void> onWidgetLoaded(BuildContext context, HomeUseCase useCase,
      HomeViewModel viewModel) async {}

  @override
  Future<void> onViewModelCreated(BuildContext context, HomeUseCase useCase,
      HomeViewModel viewModel) async {
    useCase.updateCounter().then((value) {});
  }

  @override
  void dispose() {}
}
```

`HomePresenter` is connected to three things: `HomeUseCase`, `HomeViewModel`, and `HomeScreen`. The ViewModel helps shuttle data between the UseCase and the Screen, making the Presenter a go-between.

In our Presenter, we have `buildScreen`, `onWidgetLoaded`, `onViewModelCreated`, `dispose`, and `initstate` abstract method available.

`buildScreen` is an abstract method which returns the screen widget and also has access to the `BuildContext`, `HomeUseCase`, `HomeViewModel`, `SizingInformation`.

We can access all events and parameters defined in the screen widget through the constructor definition.

### screen_home.dart

```dart
import 'package:clean_architecture/clean_architecture.dart';
import 'package:example/features/home/model/view_model_home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;
  final GestureTapCallback onTap;
  final SizingInformation sizingInfo;

  const HomeScreen(
      {super.key,
      required this.viewModel,
      required this.onTap,
      required this.sizingInfo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Counter Example',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: false,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${viewModel.counter}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RawMaterialButton(
                    onPressed: onTap,
                    fillColor: Colors.blue,
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

As we can see, the above `HomeScreen` widget is a statelesswidget. It can only get rebuilt through the `HomePresenter`.

Inside the screen widget, all events like `onTap`, `onChange`, etc., need to be defined and passed to the presenter through the constructor.

We can get the `sizingInfo` along with viewModel data to load or adjust the children widgets defined inside respectively.

### use_case_home.dart

```dart
import 'package:clean_architecture/clean_architecture.dart';
import 'package:example/locator.dart';
import '../model/entity_home.dart';
import '../model/view_model_home.dart';

class HomeUseCase extends UseCase<HomeEntity> {
  late RepoScope<HomeEntity> homeEntityScope;
  late HomeEntity homeEntity;
  late HomeViewModel _homeViewModel;

   @override
  void setViewModel(Object viewModel) {
    _homeViewModel = viewModel as HomeViewModel;
    homeEntity = initializeEntity(
        defaultEntity: const HomeEntity(counter: 0, myCounter: 'test'),
        locator: locator,
        onEntityUpdate: onEntityUpdate);
    homeEntityScope = getScope<HomeEntity>(locator)! as RepoScope<HomeEntity>;
  }

  @override
  void buildViewModel(HomeEntity entity) {
    locator<Repo>().update(homeEntityScope, entity);
    _homeViewModel.counter = entity.counter;
    _homeViewModel.notifyViewModel();
  }

  onEntityUpdate(HomeEntity homeEntity) {}

  Future updateCounter() async {
    homeEntity = homeEntity.copyWith(counter: homeEntity.counter + 1);
    buildViewModel(homeEntity);
  }
}
```

As you can see in the above `HomeUseCase`, it is bound with `HomeEntity` and `HomeViewModel`.

In our UseCase, we have two override methods `setViewModel` and `buildViewModel`.

`setViewModel` method is to set the ViewModel class defined for that feature. Also, we need to set the entity scope to access the entity throughout the UseCase.

`buildViewModel` method is used to update the ViewModel from the updated entity and to notifyViewModel.

We will create the functions inside the UseCase and use them from the presenter as per requirement. All of the functions need to update the entity and use the `buildViewModel` method to notifyViewModel and update UI.

As per the above `HomeUseCase`, we have created the `updateCounter` function to update the counter value inside the `HomeEntity` and call `buildViewModel` method to notifyViewModel and update UI.

## Tools:

Use the [clean-framework-feature-generator](https://marketplace.visualstudio.com/items?itemName=SameerKumar.clean-framework-feature-generator) Visual Studio Code plugin. It is a powerful tool designed to streamline the process of generating features using the clean architecture pattern.

### Steps to generate feature using plugin:

1. Open extensions tab and search for clean framework and install “Clean Framework Code Gen – Flutter” extension.
   <br></br><img
style="display: block;  margin-left: auto;  margin-right: auto;"
 alt="1" src="https://imgur.com/558kFXZ.png">  
2. Open your Flutter project. Press `ctrl + shift + p` to open the command palette.
 <br></br><img
style="display: block;  margin-left: auto;  margin-right: auto;"
 alt="1" src="https://imgur.com/gL9CjZP.png">  
3. Type either "Clean Framework" or "Feature" and select "Generate Clean Framework Feature."
  <br></br><img
style="display: block;  margin-left: auto;  margin-right: auto;"
 alt="1" src="https://imgur.com/iK529C8.png">  
4. Enter the desired Feature Name. Press enter to generate the feature directory.
 <br></br><img
style="display: block;  margin-left: auto;  margin-right: auto;"
 alt="1" src="https://imgur.com/KcXCvRP.png">  
5. A new feature is being created. Please wait momentarily as the build runner code generation process will commence once the feature has been generated, including the generation of the freezed part files.
<br></br><img
style="display: block;  margin-left: auto;  margin-right: auto;"
 alt="1" src="https://imgur.com/BgEE8lr.png">  

Enjoy! With the clean-framework-feature-generator, empower your workflow and focus on building remarkable Flutter applications with ease.
