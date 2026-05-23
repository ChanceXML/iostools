import UIKit

public final class IOSTools {
    public static let shared = IOSTools()
    
    // core managers
    public let permissions = PermissionManager.shared
    public let ui = AlertManager.shared
    public let feedback = FeedbackManager.shared
    public let storage = StorageManager.shared
    public let device = DeviceManager.shared
    
    // file & pick folder things
    public let folderPermissions = FilePermissionManager.shared
    public let picker = FilePickerManager.shared
    
    private init() {}
}
