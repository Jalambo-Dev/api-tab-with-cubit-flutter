# Flutter TabBar + API + Cubit

A Flutter app demonstrating how to use TabBar with API integration and Cubit for state management.

## Features

- Tab navigation with TabBar
- API fetching per tab
- State management using Cubit
- Pagination (infinite scroll)
- Clean separation: Model, Service, Repository

## Folder Structure

```text
lib/
├── cubit/
│   ├── news_cubit.dart
│   └── news_state.dart
├── data/
│   ├── article_model.dart
│   ├── news_repository.dart
│   └── news_service.dart
├── ui/
│   ├── home_screen.dart
│   └── news_category_tab.dart
└── main.dart
```

## Getting Started

```bash
flutter pub get
flutter run
```

> Make sure to replace the API key in `news_service.dart`:
```dart
static const String _apiKey = 'YOUR_API_KEY';
```

## Dependencies

- flutter_bloc
- http

## API Used

[NewsAPI](https://newsapi.org)

## License

MIT
