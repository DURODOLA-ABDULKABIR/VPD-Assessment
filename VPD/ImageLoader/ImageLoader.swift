//
//  ImageLoader.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

//class ImageLoader {
//
//    // Static method to load image from URL with loader
//    static func loadImage(from url: String, into imageView: UIImageView) {
//        guard let imageURL = URL(string: url) else {
//            print("Invalid URL")
//            return
//        }
//
//        // Create and start the activity indicator
//        let activityIndicator = UIActivityIndicatorView(style: .medium)
//        activityIndicator.center = imageView.center
//        activityIndicator.startAnimating()
//        DispatchQueue.main.async {
//            imageView.addSubview(activityIndicator)
//        }
//
//        // Fetch image data in the background
//        URLSession.shared.dataTask(with: imageURL) { data, response, error in
//            // Handle error
//            if let error = error {
//                print("Error loading image: \(error)")
//                DispatchQueue.main.async {
//                    activityIndicator.stopAnimating()
//                    activityIndicator.removeFromSuperview()
//                }
//                return
//            }
//
//            // Check if data exists and can create an image
//            guard let data = data, let image = UIImage(data: data) else {
//                print("No data or failed to create image")
//                DispatchQueue.main.async {
//                    activityIndicator.stopAnimating()
//                    activityIndicator.removeFromSuperview()
//                }
//                return
//            }
//
//            // Update UI on the main thread
//            DispatchQueue.main.async {
//                imageView.image = image
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
//            }
//        }.resume()
//    }
//}


import UIKit

// Create a reusable extension for UIImageView
extension UIImageView {
    
    // Function to load image from URL with a loader
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        
        // Set the placeholder image if provided
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        // Create and configure the loader
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loader)
        
        // Center the loader in the UIImageView
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        // Start animating the loader
        loader.startAnimating()
        
        // Fetch the image from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                // Stop and remove loader regardless of success or failure
                loader.stopAnimating()
                loader.removeFromSuperview()
                
                if let data = data, let image = UIImage(data: data) {
                    // Set the fetched image
                    self.image = image
                } else {
                    // Optionally handle the error (e.g., show a default image)
                    print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }.resume()
    }
}
