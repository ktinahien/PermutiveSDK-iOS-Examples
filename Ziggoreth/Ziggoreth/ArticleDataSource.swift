//
//  ArticleDataSource.swift
//  Ziggoreth
//
//  Created by Gregg Jaskiewicz on 12/03/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

import Foundation
import UIKit


struct Article {
    let title: String
    let content: String
    let image: UIImage?
}



final class ArticleDataSource {
    func currentArticle() -> Article? {
        return nil
    }

    var isCurrentArticleFavourite: Bool {
        get {
            return false
        }

        set {
            print("x \(newValue)")
        }
    }
}
