//
//  GJTableViewSortedSearchListSetup.swift
//
//  Created by Gregg Jaskiewicz on 26/01/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

import Foundation
import UIKit

// The premise of this helper is simple
// You give it a list of items, set up some configuration parameters
// Pass your table View, and in return you get table view that lists all the items on your list
// With few extras.
// No more delegates and data sources in your view controller, yay !

final class GJTableViewSortedSearchListSetup {
    private let tableView: UITableView
    private let list: [pair]
    private var delegate: GJTableViewSortedListDelegate?
    private var dataSource: GJTableViewSortedListDataSource?

    init(tableView: UITableView, list: [pair]) {
        self.tableView = tableView
        self.list = list
    }

    func setup(callback: ((_: Int, _: pair?)->Void)? ) {

        let sortedlist = GJStringOperations.sortAndSplitArray(self.list)

        self.delegate = GJTableViewSortedListDelegate(sortedlist: sortedlist)
        self.delegate?.setup(withTableView: self.tableView, callback: callback)

        self.dataSource = GJTableViewSortedListDataSource(sortedlist: sortedlist)
        self.dataSource?.setup(withTableView: self.tableView)

        self.tableView.reloadData()
    }
}

fileprivate final class GJTableViewSortedListDataSource: NSObject, UITableViewDataSource {

    private let cellIdentifier = "simpleCellId"
    private let sortedlist: [[pair]]

    init(sortedlist: [[pair]]) {
        self.sortedlist = sortedlist
    }

    func setup(withTableView tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }

    @objc func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedlist.count
    }

    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.sortedlist.count > section {

            let count = self.sortedlist[section].count

            return count
        } else {
            return 0
        }
    }

    @objc func sectionIndexTitles(for tableView: UITableView) -> [String]? {

        var indexList: [String] = []
        for item in self.sortedlist {
            if let first = item.first?.name.first {
                let letter = "\(first)".uppercased()
                indexList.append(letter)
            }
        }

        return indexList
    }

    @objc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if self.sortedlist.count > section {
            if let firstInSection = self.sortedlist[section].first?.name.first {
                return "\(firstInSection)".uppercased()
            }
        }

        return "---"
    }

    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = UITableViewCell(style: .default, reuseIdentifier: self.cellIdentifier)

        if let deqcell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) {
            cell = deqcell
        }

        if self.sortedlist.count > indexPath.section && self.sortedlist[indexPath.section].count > indexPath.row {
            cell.textLabel?.text = self.sortedlist[indexPath.section][indexPath.row].name
            cell.detailTextLabel?.text = ""
        } else {
            print("index path outside allowed range")
        }

        return cell
    }
}

fileprivate final class GJTableViewSortedListDelegate: NSObject, UITableViewDelegate {

    private let sortedlist: [[pair]]
    private var callback: ((_: Int, _: pair?)->Void)?

    init(sortedlist: [[pair]]) {
        self.sortedlist = sortedlist
    }

    func setup(withTableView tableView: UITableView, callback: ((_: Int, _: pair?)->Void)? ) {
        self.callback = callback
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // deselect
        tableView.deselectRow(at: indexPath, animated: true)

        guard let callback = self.callback else {
            return
        }

        var value: pair?

        if indexPath.section < self.sortedlist.count {
            if indexPath.row < self.sortedlist[indexPath.section].count {
                value = self.sortedlist[indexPath.section][indexPath.row]
            }
        }

        callback(indexPath.row, value)
    }

}

