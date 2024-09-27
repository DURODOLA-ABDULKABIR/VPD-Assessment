import Network
import UIKit

import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    var isConnected: Bool = true
    
    private init() {}
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                if !(self?.isConnected ?? true) {
                    self?.isConnected = true
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .connectionRestored, object: nil)
                    }
                }
            } else {
                if self?.isConnected ?? false {
                    self?.isConnected = false
                    DispatchQueue.main.async {
                        self?.notifyUser()
                        NotificationCenter.default.post(name: .connectionLost, object: nil)
                    }
                }
            }
        }
    }
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func notifyUser() {
        let alert = UIAlertController(title: "No Internet Connection",
                                      message: "Please check your network settings.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        if let topController = getTopMostViewController() {
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func getTopMostViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              var topController = window.rootViewController else {
            return nil
        }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}

extension Notification.Name {
    static let connectionRestored = Notification.Name("connectionRestored")
    static let connectionLost = Notification.Name("connectionLost")
}
