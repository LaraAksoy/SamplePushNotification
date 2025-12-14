import UIKit
import UserNotifications

class NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    // MARK: - Constants
    // TODO: Replace with your actual App Group ID if you use the Notification Service Extension
    // for background sound suppression.
    private let appGroupId = "group.com.Lara.samplePush.samplePush"
    private let soundEnabledKey = "isNotificationSoundEnabled"
    
    // MARK: - Properties
    var isSoundEnabled: Bool {
        get {
            // Try to read from App Group shared defaults first
            if let sharedDefaults = UserDefaults(suiteName: appGroupId) {
                // If key doesn't exist, default to true
                if sharedDefaults.object(forKey: soundEnabledKey) == nil {
                    return true
                }
                return sharedDefaults.bool(forKey: soundEnabledKey)
            }
            // Fallback to standard UserDefaults
            return UserDefaults.standard.object(forKey: soundEnabledKey) == nil ? true : UserDefaults.standard.bool(forKey: soundEnabledKey)
        }
        set {
            // Save to both standard and shared defaults to be safe
            UserDefaults.standard.set(newValue, forKey: soundEnabledKey)
            if let sharedDefaults = UserDefaults(suiteName: appGroupId) {
                sharedDefaults.set(newValue, forKey: soundEnabledKey)
            }
        }
    }
    
    // MARK: - Setup
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Notification permission denied.")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Foreground Handling Helpers
    func shouldPlaySound() -> Bool {
        return isSoundEnabled
    }
}
