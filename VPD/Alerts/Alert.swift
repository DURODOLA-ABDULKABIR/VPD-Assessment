//
//  Alert.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okActionTitle: String = "OK") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
