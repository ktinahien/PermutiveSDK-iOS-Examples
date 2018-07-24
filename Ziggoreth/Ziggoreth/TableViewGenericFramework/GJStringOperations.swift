//
//  GJStringOperations.swift
//
//  Created by Gregg Jaskiewicz on 26/01/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

import Foundation

struct pair {
    let name: String
    let value: String
}

final class GJStringOperations {
    static func sortAndSplitArray(_ list: [pair]) -> [[pair]] {

        let sortedArray = list.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending
        }

        var currentLetter = "_".first

        var listOfLists: [[pair]] = []
        var currentList: [pair] = []

        for item in sortedArray {
            if currentLetter != item.name.lowercased().first {
                if (currentList.count > 0) {
                    listOfLists.append(currentList)
                }
                currentLetter = item.name.lowercased().first
                currentList = []
            }

            currentList.append(item)
        }

        if (currentList.count > 0) {
            listOfLists.append(currentList)
        }

        return listOfLists
    }
}
