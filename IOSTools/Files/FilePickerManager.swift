import UIKit
import UniformTypeIdentifiers

public final class FilePickerManager: NSObject, UIDocumentPickerDelegate {
    public static let shared = FilePickerManager()
    private var completion: (([URL]) -> Void)?
    
    private override init() {}
    
    public func pickFiles(allowedTypes: [UTType] = [.item], allowMultiple: Bool = false, completion: @escaping ([URL]) -> Void) {
        self.completion = completion
        
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: allowedTypes, asCopy: true)
        picker.delegate = self
        picker.allowsMultipleSelection = allowMultiple
        
        DispatchQueue.main.async {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            if let rootVC = windowScene?.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                rootVC.present(picker, animated: true)
            }
        }
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        completion?(urls)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        completion?([])
    }
}
