//
//  ArticleViewController.swift
//  Ziggoreth
//
//  Created by Gregg Jaskiewicz on 12/03/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

import Foundation
import UIKit

final class ArticleViewController: UIViewController {
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favouriteBarItem: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let p = Permutive.permutive()
        let eventTracker = p?.eventTracker
        eventTracker?.track("Pageview")
    }

    @IBAction func favouriteChanged() {
        self.favouriteBarItem.isSelected = (self.favouriteBarItem.isSelected == false)

        let p = Permutive.permutive()
        let eventTracker = p?.eventTracker

        eventTracker?.track("ArticleFavouriteChange", properties: [
            "article": self.titleLabel.text ?? "",
            "favourite": self.favouriteBarItem.isSelected,
            "geo_ip" : "$ip_geo_info"
            ])
    }

}
