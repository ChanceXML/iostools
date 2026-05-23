import AVFoundation
import Photos
import UserNotifications
import CoreLocation
import Contacts

public final class PermissionManager: NSObject, CLLocationManagerDelegate {
    static let shared = PermissionManager()
    
    private var locationManager: CLLocationManager?
    private var locationCompletion: ((Bool) -> Void)?
    
    private override init() {
        super.init()
    }
    
    public func request(_ type: PermissionType, completion: @escaping (Bool) -> Void) {
        switch type {
        case .camera:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
            
        case .photoLibrary:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async { completion(status == .authorized || status == .limited) }
            }
            
        case .notifications:
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                DispatchQueue.main.async { completion(granted) }
            }
            
        case .microphone:
            AVAudioApplication.requestRecordPermission { granted in
                DispatchQueue.main.async { completion(granted) }
            }
            
        case .contacts:
            CNContactStore().requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async { completion(granted) }
            }
            
        case .locationWhenInUse, .locationAlways:
            self.locationCompletion = completion
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            
            if type == .locationWhenInUse {
                locationManager?.requestWhenInUseAuthorization()
            } else {
                locationManager?.requestAlwaysAuthorization()
            }
        }
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status != .notDetermined {
            let isAuthorized = (status == .authorizedWhenInUse || status == .authorizedAlways)
            locationCompletion?(isAuthorized)
            locationCompletion = nil
            locationManager = nil
        }
    }
}
