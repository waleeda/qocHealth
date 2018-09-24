//
//  UIKitExtensions.swift
//  qocHealthAssesment
//
//  Created by Waleed Azhar on 2018-09-24.
//  Copyright © 2018 Waleed Azhar. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    func presentSafariViewController(urlString: String?) {
        if let url = URL.init(string: urlString ?? "google.com") {
            let webViewController = SFSafariViewController(url: url )
            present(webViewController, animated: true, completion: nil)
        }
        
    }
}

extension UIImageView {
    
    func setImage(urlString: String?) {
        guard let url = URL.init(string: urlString ?? "false/df") else { return }
        URLSession.shared.dataTask(with: url) { (imageData, _, _) in
            if let image = imageData {
                DispatchQueue.main.async { self.image = UIImage(data: image) }
            }
        }.resume()
    }
}
