# CS 442 MP6: Final Project

## 1. Overview

This last machine problem in the class is an open-ended one. You will be building a mobile application of your choice using the Flutter framework. You are free to choose any application domain you like, but your application must meet the requirements described below.

## 2. Requirements

Your application must meet the following high-level requirements:

1. There should be at least 3 separate screens/pages in your application, each of which should be implemented as a separate widget. One of these pages should be the default "home" page that is displayed when the application is first launched. Navigation between pages can be implemented using any of the standard Flutter mechanisms (e.g., `Navigator`, `TabBar`, `BottomNavigationBar`, etc.).
2. At least one of the pages in your application should be backed by a stateful widget, which in turn should be backed by a custom model class. The model class should encapsulate the data that is displayed/manipulated on the page. You may choose to use any of the mechanisms we discussed in class (e.g., `setState`, `ChangeNotifier`, `Provider`, etc.) to update the UI on model object updates.
3. Your app should persist some user-updateable data across application launches in some way. You can use any of the mechanisms we discussed for doing so (e.g., `SharedPreferences`, `sqflite`, etc.).
4. Your app should access some data from an external source (e.g., a RESTful API or a cloud database like Cloud Firestore) and display it in some way. You may use the `http` package, or other third-party packages, to do so. The accessed data should be dynamic in some way (i.e., it should change over time, whether in response to user input or external events).
5. Your app should include unit, widget, and integration tests.

### 2.1. Implementation details

Becaause of the open-ended nature of this machine problem, we will not be providing any starter code. You are free to use any of the code we went over in class as a starting point, but you are not required to do so. All code you submit should be your own.

Though you may use third-party libraries (as described in the next section), the main business logic of your application should be written by you and not outsourced. You should not use any code that you find online or in other sources.

### 2.2. External packages

We have included the following packages in the `pubspec.yaml` file:

- [`collection`](https://pub.dev/packages/collection): a library that provides a set of additional data structures and utilities
- [`flutter_test`](https://pub.dev/packages/flutter_test): a library that provides a set of utilities for writing widget tests
- [`http`](https://pub.dev/packages/http): a library that provides a set of high-level asynchronous functions for communicating with HTTP servers
- [`integration_test`](https://pub.dev/packages/integration_test): a library that provides a set of utilities for writing integration tests
- [`mockito`](https://pub.dev/packages/mockito): a library that provides a set of utilities for mocking classes and objects
- [`path`](https://pub.dev/packages/path): a library that provides a set of utilities for manipulating paths
- [`path_provider`](https://pub.dev/packages/path_provider): a library that provides a set of utilities for locating files/directories on the filesystem
- [`provider`](https://pub.dev/packages/provider): a library that provides a set of utilities for managing and disseminating stateful data
- [`shared_preferences`](https://pub.dev/packages/shared_preferences): a library that provides a persistent store for simple data
- [`sqflite`](https://pub.dev/packages/sqflite): a library that wraps SQLite functionality for use in Flutter applications
- [`test`](https://pub.dev/packages/test): a library that provides a set of utilities for writing unit tests

For this machine problem, you may also make use of other third-party packages found on [pub.dev](https://pub.dev/), provided you request approval in advance.


