import UIKit

public final class DeviceManager {
    static let shared = DeviceManager()
    
    private init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    public var osVersion: String {
        return UIDevice.current.systemVersion
    }
    
    public var deviceModel: String {
        return UIDevice.current.model
    }
    
    public var batteryLevel: Float {
        return UIDevice.current.batteryLevel * 100
    }
    
    public var isBatteryCharging: Bool {
        return UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
    }
}
