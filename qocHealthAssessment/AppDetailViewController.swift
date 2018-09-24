//
//  AppDetailViewController.swift
//  qocHealthAssesment
//
//  Created by Waleed Azhar on 2018-09-24.
//  Copyright © 2018 Waleed Azhar. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var appDeveloper: UIButton!
    @IBOutlet weak var appLink: UIButton!
    
    var appDetails:AppDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appLink.addTarget(self, action:#selector(appLinkButtonPressed), for: .touchUpInside)
        appDeveloper.addTarget(self, action:#selector(appDeveloperButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        render()
    }
    
    @objc func appDeveloperButtonPressed() {
        presentSafariViewController(urlString: appDetails?.artist.attributes?.href)
    }
    
    @objc func appLinkButtonPressed() {
        presentSafariViewController(urlString: appDetails?.link.attributes?.href)
    }
}

extension AppDetailViewController {
    
    func render() {
        title = appDetails?.name.label
        appIcon.setImage(urlString: appDetails?.images.last?.label)
        appTitle.text = appDetails?.name.label
        date.text = appDetails?.releaseDate.attributes?.label
        summary.text = appDetails?.summary.label
        price.text = "\(appDetails?.price.label ?? "") \(appDetails?.price.attributes?.currency ?? "")"
        category.text = appDetails?.category.attributes?.term 
        appDeveloper.setTitle(appDetails?.artist.label, for: .normal)
    }
    
}

