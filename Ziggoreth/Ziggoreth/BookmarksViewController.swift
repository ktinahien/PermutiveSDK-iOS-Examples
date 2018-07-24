//
//  BookmarksViewController.swift
//  Ziggoreth
//
//  Created by Gregg Jaskiewicz on 22/03/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

import Foundation
import UIKit

final class BookmarksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let p = Permutive.permutive()
        let eventTracker = p?.eventTracker
        let xString = String(format: "%0.02f", touch.location(in: self.view).x)
        let yString = String(format: "%0.02f", touch.location(in: self.view).y)

        eventTracker?.track("Bookmarks_XY_touch", properties: [
            "x": xString,
            "y": yString
            ])

    }
}
