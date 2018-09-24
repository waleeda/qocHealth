//
//  ViewController.swift
//  qocHealthAssesment
//
//  Created by Waleed Azhar on 2018-09-24.
//  Copyright © 2018 Waleed Azhar. All rights reserved.
//

import UIKit

class AppListViewController: UITableViewController {
    
    private let cellID = "appCell"
    
    private var selectedIndex = IndexPath(row: 0, section: 0)
    
    private var feed: Feed? {
        didSet {
            if let apps = feed {
                title = apps.title.label
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebService().get(endPoint: .appList) { [ weak self] (d:EndpointResponse?, e) in
            self?.feed = d?.feed
        }
    }

}

extension AppListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed?.entry.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: cellID ) ?? UITableViewCell(style: .default, reuseIdentifier: cellID)
        let app = feed?.entry[indexPath.row]
        cell.textLabel?.text = app?.name.label
        cell.imageView?.setImage(urlString: app?.images.first?.label)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDetailsViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppDetailVC") as! AppDetailViewController
        appDetailsViewController.appDetails = feed?.entry[indexPath.row]
        self.navigationController?.pushViewController(appDetailsViewController, animated: true)
    }
    
}
