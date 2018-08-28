//
//  ViewController.swift
//  Ziggoreth
//
//  Created by Gregg Jaskiewicz on 12/03/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

import UIKit
import Permutive

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var tableViewFactory: GJTableViewListFactory?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = Permutive.permutive() {
            let eventTracker = p.eventTracker

            eventTracker.track("test_event_2", properties: [
                "k": "value",
                "a": "x",
                "geo" : p.eventTracker.eventConstPropertyValues.geo_info
                ])
        }

        self.tableViewFactory = GJTableViewListFactory(tableView: self.tableView, list: MainPageData)
        self.tableViewFactory?.setup(callback: { [weak self] (row, pair) in

            guard let strongSelf = self else {
                return
            }

            guard let p = Permutive.permutive() else {
                return
            }

            let eventTracker = p.eventTracker

            // when user taps - this will be called
            if let name = pair?.name {
                eventTracker.track("news_selected", properties: ["newsTitle": name ])
            } else {
                eventTracker.track("news_selected", properties: ["newsId": row ])
            }

            strongSelf.performSegue(withIdentifier: "ShowDetail", sender: strongSelf)
        })
    }

}
