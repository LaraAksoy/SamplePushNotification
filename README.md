# samplePush

**samplePush** is a robust iOS sample application demonstrating advanced Push Notification handling using **Firebase Cloud Messaging (FCM)**. This project highlights best practices for managing notification settings, handling custom notification sounds, and utilizing **Notification Service Extensions** to modify payload content before delivery.

## 🚀 Features

- **Firebase Cloud Messaging (FCM)**: Seamless integration for remote push notifications.
- **Notification Service Extension**: Intercepts remote notifications to modify content (e.g., changing sounds) before the user sees them.
- **Custom Sounds**: Supports custom notification sounds (included sample: `Pro-Notific-sound.mp3`).
- **Sound Configuration**: In-app setting to specificially toggle notification sounds on/off without disabling notifications entirely.
- **App Groups**: Uses `UserDefaults(suiteName: ...)` to share settings between the main app and the extension, ensuring preference consistency even when the app is killed.

## 🛠 Tech Stack

- **Language**: Swift
- **UI Framework**: UIKit (Storyboard & ViewControllers)
- **Backend Service**: Firebase (Messaging)
- **Dependency Manager**: Swift Package Manager (SPM)

## 📋 Prerequisites

Before you begin, ensure you have the following:
- Xcode 13.0 or later
- iOS 14.0+ target
- A generic Apple Developer Account (for Push Notification capabilities)
- A Firebase Project set up in the [Firebase Console](https://console.firebase.google.com/)

## ⚙️ Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/LaraAksoy/samplePush.git
   cd samplePush
   ```

2. **Add Firebase Configuration**
   - Go to your Firebase Console Project Settings.
   - Download the `GoogleService-Info.plist` file.
   - Drag and drop it into the root of the Xcode project (make sure "Copy items if needed" is checked).

3. **Configure App Groups**
   - Select the **samplePush** target -> **Signing & Capabilities**.
   - Add the **App Groups** capability.
   - Create a new container (e.g., `group.com.yourname.samplePush`).
   - Repeat this step for the **samplePushNotification** extension target.
   - **Important**: Update the `appGroupId` variable in both `NotificationManager.swift` and `NotificationService.swift` to match your new group ID.

   ```swift
   // NotificationManager.swift & NotificationService.swift
   private let appGroupId = "group.com.yourname.samplePush"
   ```

4. **Build and Run**
   - Select your physical device (Simulators do not support remote push notifications).
   - Build and run the application.

## 📱 Usage

1. **Permission Request**: On first launch, the app will request permission to send notifications.
2. **Settings**: Navigate to the Settings screen (if available in UI) or toggle the sound preference.
3. **Send a Test Push**:
   - Go to Firebase Console -> Cloud Messaging.
   - Send a test message with the following custom data to test the sound override:
     ```json
     {
       "apns": {
         "payload": {
           "aps": {
             "mutable-content": 1
           }
         }
       }
     }
     ```
   - If sound is enabled in the app, you should hear the custom sound. If disabled, it should be silent.

## 📂 Project Structure

```
samplePush/
├── AppDelegate.swift          # App lifecycle & Firebase configuration
├── Managers/
│   └── NotificationManager.swift # Central logic for permissions & settings
├── ViewControllers/           # UI Logic
└── Assets.xcassets            # Icons & Images

samplePushNotification/        # Notification Service Extension
├── NotificationService.swift  # Modifies payload (handles sound toggling)
```

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
