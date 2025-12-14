import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    //  Replace with your actual App Group ID
    private let appGroupId = "group.com.Lara.samplePush.samplePush"
    private let soundEnabledKey = "isNotificationSoundEnabled"

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            
            // Check if sound should be played
            if let sharedDefaults = UserDefaults(suiteName: appGroupId) {
                let soundEnabled = sharedDefaults.object(forKey: soundEnabledKey) == nil ? true : sharedDefaults.bool(forKey: soundEnabledKey)
                
                if !soundEnabled {
                    // Remove sound to silence the notification
                    bestAttemptContent.sound = nil
                } else {
                    // Check if payload specifies a custom sound, otherwise custom sound logic can go here
                    // For this example, we respect the payload's sound or lack thereof.
                    // If you wanted to FORCE a custom sound for ALL notifications:
                     bestAttemptContent.sound = UNNotificationSound(named: UNNotificationSoundName("Pro-Notific-sound.mp3"))
                }
            }
            
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
