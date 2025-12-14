import UIKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configure Firebase
        // Make sure GoogleService-Info.plist is in your project
        FirebaseApp.configure()
        
        // Setup Notifications
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        NotificationManager.shared.requestAuthorization()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    // MARK: - Remote Notification Registration
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs Token received: \(deviceToken)")
        // Explicitly map APNs token to Firebase Messaging just in case
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Handle foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let shouldPlaySound = NotificationManager.shared.isSoundEnabled
        
        if shouldPlaySound {
            // Show banner and play sound
            completionHandler([.banner, .sound, .badge])
        } else {
            // Show banner only, silence sound
            completionHandler([.banner, .badge])
        }
    }
    
    // Handle notification tap
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User tapped notification: \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "None")")
        // Sync token to server if needed
    }
}
