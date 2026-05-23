import UIKit

public final class FeedbackManager {
    static let shared = FeedbackManager()
    private init() {}
    
    public enum HapticStyle {
        case light, medium, heavy, success, warning, error
    }
    
    public func triggerHaptic(_ style: HapticStyle) {
        DispatchQueue.main.async {
            switch style {
            case .light:
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .medium:
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            case .heavy:
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            case .success:
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            case .warning:
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            case .error:
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        }
    }
}
