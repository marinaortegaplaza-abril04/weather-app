# Weather App

## Overview

Weather App is a Flutter application that allows users to search for weather information using the OpenWeather API.

The application provides real-time weather data, weather forecasts, and a favorites system for quick access to frequently searched cities.

This project was developed for the course:

**Creating an Advanced iOS Apps**

---

## Features

### Current Weather

* Search weather by city name
* Current temperature
* Weather description
* Humidity
* Wind speed
* Maximum temperature
* Minimum temperature
* Weather icon

### Weather Forecast

* Multi-day weather forecast
* Weather icons
* Temperature information
* Weather descriptions

### Favorites System

* Add favorite cities
* Remove favorite cities
* Quick search from favorites

### User Experience

* Loading indicators
* Error handling
* TabBar navigation
* Simple animations
* Responsive interface

---

## Technologies

* Flutter
* Dart
* OpenWeather API
* HTTP Package
* Shared Preferences

---

## Project Structure

lib/

* models/

  * forecast_item.dart

* services/

  * weather_service.dart
  * favorites_service.dart

* screens/

  * home_page.dart

* main.dart

---

## Architecture

### Presentation Layer

Responsible for:

* User interface
* State management
* User interaction

Files:

* HomePage

### Service Layer

Responsible for:

* API communication
* Favorites storage

Files:

* WeatherService
* FavoritesService

### Model Layer

Responsible for:

* Forecast data representation

Files:

* ForecastItem

---

## API

OpenWeather API

Endpoints used:

GET /weather

GET /forecast

---

## Installation

1. Clone repository

git clone [repository_url]

2. Install dependencies

flutter pub get

3. Run application

flutter run

---

## Team

MarinaErasmus

Responsibilities:

* UI Development
* API Integration
* Favorites Implementation
* Testing
* Documentation

---

## Course Requirements Covered

* Client-server architecture
* Public API integration
* Networking layer
* Data model
* Presentation layer
* State management
* Multiple application features
* TabBar navigation
* Error handling
* Persistent storage
