import UIKit
import UniformTypeIdentifiers

public final class FilePermissionManager: NSObject, UIDocumentPickerDelegate {
    public static let shared = FilePermissionManager()
    private var completion: ((URL?) -> Void)?
    
    private override init() {}
    
    public func pickFolder(completion: @escaping (URL?) -> Void) {
        self.completion = completion
        
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder], asCopy: false)
        picker.delegate = self
        picker.allowsMultipleSelection = false
        
        DispatchQueue.main.async {
            if let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                rootVC.present(picker, animated: true)
            }
        }
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            completion?(nil)
            return
        }
        
        guard url.startAccessingSecurityScopedResource() else {
            print("Failed to access security scoped resource")
            completion?(nil)
            return
        }
        
        saveBookmark(for: url)
        
        completion?(url)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        completion?(nil)
    }
    
    private func saveBookmark(for url: URL) {
        do {
            let bookmarkData = try url.bookmarkData(options: .minimalBookmark, includingResourceValuesForKeys: nil, relativeTo: nil)
            UserDefaults.standard.set(bookmarkData, forKey: "SavedFolderAccess")
        } catch {
            print("Failed to save bookmark: \(error)")
        }
    }
    
    public func restorePermission() -> URL? {
        guard let data = UserDefaults.standard.data(forKey: "SavedFolderAccess") else { return nil }
        
        var isStale = false
        do {
            let url = try URL(resolvingBookmarkData: data, bookmarkDataIsStale: &isStale)
            if url.startAccessingSecurityScopedResource() {
                return url
            }
        } catch {
            print("Failed to restore bookmark: \(error)")
        }
        return nil
    }
}
