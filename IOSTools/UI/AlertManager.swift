import UIKit

public final class AlertManager {
    static let shared = AlertManager()
    private init() {}
    
    private var rootViewController: UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first(where: { $0.isKeyWindow })?.rootViewController
    }
    
    public func showAlert(title: String, message: String, buttonText: String = "OK", onClick: (() -> Void)? = nil) {
        guard let rootVC = rootViewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonText, style: .default) { _ in
            onClick?()
        })
        
        DispatchQueue.main.async {
            rootVC.present(alert, animated: true)
        }
    }
    
    public func showConfirm(title: String, message: String, confirmText: String = "Yes", cancelText: String = "No", onAction: @escaping (Bool) -> Void) {
        guard let rootVC = rootViewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: confirmText, style: .default) { _ in
            onAction(true)
        })
        
        alert.addAction(UIAlertAction(title: cancelText, style: .cancel) { _ in
            onAction(false)
        })
        
        DispatchQueue.main.async {
            rootVC.present(alert, animated: true)
        }
    }
    
    public func showTripleButtonAlert(
        title: String, 
        message: String, 
        buttonOneText: String, 
        buttonTwoText: String, 
        buttonThreeText: String, 
        onButtonClick: @escaping (Int) -> Void
    ) {
        guard let rootVC = rootViewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonOneText, style: .default) { _ in
            onButtonClick(1)
        })
        
        alert.addAction(UIAlertAction(title: buttonTwoText, style: .default) { _ in
            onButtonClick(2)
        })
        
        alert.addAction(UIAlertAction(title: buttonThreeText, style: .cancel) { _ in
            onButtonClick(3)
        })
        
        DispatchQueue.main.async {
            rootVC.present(alert, animated: true)
        }
    }
}
