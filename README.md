# 🚀 RoadmapFrontend – Flutter App for Roadmap.AI

**RoadmapFrontend** is the Flutter-based frontend for the Roadmap.AI application. It is designed with clean architecture in mind, featuring state management using `Provider`, separation of business logic from UI, theming support, and reusable custom styles. The app communicates with the backend using REST APIs to provide user authentication and roadmap generation features.

---

## 🧱 Tech Stack & Packages Used

| Package              | Purpose                                 |
| -------------------- | --------------------------------------- |
| `provider`           | State management                        |
| `http`               | REST API communication                  |
| `shared_preferences` | Local storage (JWT tokens, theme, etc.) |
| `flutter_markdown`   | Render markdown content for roadmaps    |
| `url_launcher`       | Open external links                     |
| `icons_launcher`     | Generate app launcher icons             |

---

## 🎨 Features

- 🌗 Dark and Light Theme Switching
- 🔐 JWT-based Authentication (Login & Token Storage)
- 📋 Fetch and display roadmap content (Markdown support)
- 🧠 Clean separation of **Business Logic** and **UI**
- 💅 Custom reusable styles (TextStyles, Colors, Spacing) in a separate file
- 🔄 State Management using `Provider`
- 🔗 Launch external learning resources using `url_launcher`

---

## 🗂️ Project Structure Overview Example

```plaintext
lib/
├── main.dart
├── theme/
│   └── app_theme.dart           # Light & Dark theme definitions
├── providers/
│   └── auth_provider.dart       # Auth state and JWT token handling
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   └── roadmap_screen.dart      # Display fetched roadmaps
├── services/
│   └── api_service.dart         # All API calls (GET, POST, etc.)
├── utils/
│   └── custom_styles.dart       # Reusable TextStyles, Colors, etc.
└── widgets/
    └── custom_button.dart       # Example reusable widget
```

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (3.x recommended)
- Android Studio or VS Code
- Emulator/Physical device

---

### 📦 Installation

```bash
git clone https://github.com/yourusername/roadmapfrontend.git
cd roadmapfrontend
flutter pub get
flutter run
```

---

## 🧪 API Integration

This app is designed to work with the [Roadmap.AI Spring Boot Backend](https://github.com/gautamrawat543/RoadMapAI).  
Make sure the backend is deployed and reachable, then:

- Update the API base URL in `api_service.dart`
- Use the `http` package for POST (login) and GET (fetch roadmaps)
- JWT token is saved using `shared_preferences` and attached to future requests

---

## 📱 Screenshots

_(Add your own screenshots here using Markdown image syntax)_

---

## 👤 Author

- **Gautam Rawat**  
  GitHub: [@gautamrawat543](https://github.com/gautamrawat543)

---

> 💡 Tip: This app is structured to be production-ready. You can easily extend it with new features like bookmarking, offline caching, and user role support.
