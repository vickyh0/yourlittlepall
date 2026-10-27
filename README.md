YourLittlePal 🐾

An interactive, cross-platform digital pet application built with Flutter and Dart, featuring real-time care activities, state persistence, local data logging, and live sensor inputs.

🌟 Overview

YourLittlePal is a modern digital pet companion app that brings classic pet simulation mechanics into a responsive, multi-platform environment. Designed with state management, modular architecture, and offline persistence, the application simulates real-time pet care dynamics, attribute decay loops, and interactive mini-games.

🌐 Click Here to View Live Web Demo

✨ Key Features

🎮 Interactive Care Mechanics: Feed, groom, pet, and put your digital companion to sleep with responsive UI animations and feedback.

⚡ Real-Time Attribute Decay System: Dynamic background status decay for Hunger, Happiness, Energy, and Hygiene stats.

💾 Local Data Persistence & Logging: Built-in state management saving user actions, pet attributes, and history logs across sessions.

📱 Sensor Integration & Simulator: Interactive pedometer activity tracking to boost pet energy and happiness through real-world or simulated movement.

🌐 Multi-Language Support (l10n): Built-in internationalization supporting English, Spanish, Japanese, and Traditional Chinese.

🎨 Personalization & Customization: Customizable pet color themes, renaming options, audio FX controls, and light/dark theme modes.

🛠️ Architecture & Tech Stack

Framework: Flutter (Web, iOS, Android, Desktop)

Language: Dart

State Management: Provider / Local Persistent Storage

Internationalization: Flutter l10n localization framework

Styling & Assets: Custom SVG & Canvas rendering pipelines

🚀 Getting Started

Prerequisites

Ensure you have the following installed on your machine:

Flutter SDK (v3.0.0 or higher)

Dart SDK

VS Code or Android Studio with Flutter/Dart extensions

Installation

Clone the Repository

git clone https://github.com/vickyh0/yourlittlepal.git
cd yourlittlepal


Install Dependencies

flutter pub get


Run Nationally / Locally

For Web:

flutter run -d chrome


For Mobile/Desktop:

flutter run


📦 Web Deployment

To build release files for web hosting (e.g., Netlify, Vercel, or GitHub Pages):

flutter build web --release


The compiled assets will be generated in the build/web directory ready for deployment.

📄 License

Distributed under the MIT License. See LICENSE for more information.
