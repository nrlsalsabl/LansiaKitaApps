# health_monitor

A new Flutter project.

# 🩺 Health Monitor Mobile

A Flutter-based mobile application for monitoring elderly health using **Android Health Connect**.

The application collects health data from wearable devices (e.g., Redmi Watch 5) through Health Connect, performs **edge computing** on the device to determine health status, and prepares the analyzed data to be synchronized with the backend server.

---

# Features

- ❤️ Heart Rate Monitoring
- 🫁 Blood Oxygen (SpO₂)
- 👣 Daily Steps
- 😴 Sleep Duration
- 🟢 Health Status Analysis (Normal / Warning / Danger)
- 📊 Health Score
- 🔄 Adaptive Sync Interval
- ☁️ Backend Integration (Coming Soon)

---

# Tech Stack

- Flutter
- Provider
- Dio
- Go Router
- Android Health Connect
- Edge Computing

---

# Architecture

```
Redmi Watch 5
        │
        ▼
    Mi Fitness
        │
        ▼
 Health Connect
        │
        ▼
Flutter Mobile App
        │
        ▼
 Edge Computing
        │
        ▼
 REST API (Flask)
        │
        ▼
 Database
```

---

# Requirements

- Android 13+
- Flutter 3.41+
- Android Studio
- Redmi Watch 5 (or any wearable that syncs to Health Connect)
- Mi Fitness App
- Android Health Connect

---

# Project Structure

```
lib/
│
├── managers/
├── models/
├── providers/
├── routes/
├── screens/
├── services/
├── utils/
├── widgets/
└── main.dart
```

---

# Installation

Clone repository

```bash
git clone https://github.com/username/health-monitor-mobile.git

cd health-monitor-mobile
```

Install dependencies

```bash
flutter pub get
```

Run application

```bash
flutter run
```

---

# Health Connect Setup

Before using the application, Health Connect must already contain health data.

## Step 1

Install:

- Mi Fitness
- Health Connect

---

## Step 2

Pair Redmi Watch 5 with Mi Fitness.

---

## Step 3

Open Mi Fitness

```
Profile
    ↓
Health Connect
    ↓
Connect
```

Enable synchronization for:

- Heart Rate
- Blood Oxygen
- Sleep
- Steps

---

## Step 4

Open Health Connect.

Verify that health data has been synchronized.

Example:

```
Heart Rate
90 BPM

SpO₂
98%

Steps
5231

Sleep
7.4 Hours
```

---

# Application Permission

When opening the application for the first time, grant the following permissions.

- Read Heart Rate
- Read Blood Oxygen
- Read Steps
- Read Sleep

The application will read data directly from Health Connect.

---

# Edge Computing

Health analysis is performed **on the mobile device** before sending data to the backend.

| Status | Condition | Sync Interval |
|---------|-----------|---------------|
| 🟢 Normal | Healthy | 5 minutes |
| 🟡 Warning | Need Monitoring | 1 minute |
| 🔴 Danger | Critical | 30 seconds |

This reduces backend processing and network traffic.

---

# Supported Data

| Data | Source |
|------|--------|
| Heart Rate | Health Connect |
| Blood Oxygen | Health Connect |
| Steps | Health Connect |
| Sleep | Health Connect |

---

# Testing

To test on another Android device:

1. Install Mi Fitness.
2. Pair Redmi Watch 5.
3. Connect Mi Fitness to Health Connect.
4. Verify health data exists in Health Connect.
5. Install Health Monitor APK.
6. Grant Health Connect permissions.
7. Open the application.

The application will automatically display health data from the user's own Health Connect.

---

# Roadmap

- [x] Health Connect Integration
- [x] Heart Rate
- [x] Blood Oxygen
- [x] Steps
- [x] Sleep
- [x] Edge Computing
- [x] Adaptive Sync
- [ ] Flask API Integration
- [ ] Authentication
- [ ] History
- [ ] Push Notification
- [ ] Real-time Monitoring

---

# License

This project was developed for research and educational purposes.
