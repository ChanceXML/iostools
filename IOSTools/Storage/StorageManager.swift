import Foundation

public final class StorageManager {
    static let shared = StorageManager()
    private let defaults = UserDefaults.standard
    private init() {}
    
    public func save(key: String, value: Any) {
        defaults.set(value, forKey: key)
    }
    
    public func getString(key: String) -> String? {
        return defaults.string(forKey: key)
    }
    
    public func getBool(key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
    
    public func getInt(key: String) -> Int {
        return defaults.integer(forKey: key)
    }
    
    public func remove(key: String) {
        defaults.removeObject(forKey: key)
    }
}
