//
//  GJTableViewListSetup.swift
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

final class GJTableViewListFactory {
    private let tableView: UITableView
    private let list: [pair]
    private var delegate: GJTableViewListDelegate?
    private var dataSource: GJTableViewListDataSource?

    init(tableView: UITableView, list: [pair]) {
        self.tableView = tableView
        self.list = list
    }

    func setup(callback: ((_: Int, _: pair?)->Void)? ) {
        self.delegate = GJTableViewListDelegate(list: self.list)
        self.delegate?.setup(withTableView: self.tableView, callback: callback)

        self.dataSource = GJTableViewListDataSource(list: self.list)
        self.dataSource?.setup(withTableView: self.tableView)

        self.tableView.reloadData()
    }
}

fileprivate final class GJTableViewListDataSource: NSObject, UITableViewDataSource {

    private let cellIdentifier = "simpleCellId"
    private let list: [pair]

    init(list: [pair]) {
        self.list = list
    }

    func setup(withTableView tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }

    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0

        if section == 0 {
            count = self.list.count
        }

        return count
    }

    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = UITableViewCell(style: .default, reuseIdentifier: self.cellIdentifier)

        if let deqcell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) {
            cell = deqcell
        }

        guard indexPath.section == 0 else {
            return cell
        }

        if self.list.count > indexPath.row {
            cell.textLabel?.text = self.list[indexPath.row].name
            cell.detailTextLabel?.text = ""
        }

        return cell
    }
}

fileprivate final class GJTableViewListDelegate: NSObject, UITableViewDelegate {

    private let list: [pair]
    private var callback: ((_: Int, _: pair?)->Void)?

    init(list: [pair]) {
        self.list = list
    }

    func setup(withTableView tableView: UITableView, callback: ((_: Int, _: pair?)->Void)? ) {
        self.callback = callback
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //deselect
        tableView.deselectRow(at: indexPath, animated: true)

        guard let callback = self.callback else {
            return
        }
        if self.list.count > indexPath.row {
            callback(indexPath.row, self.list[indexPath.row])
        } else {
            callback(indexPath.row, nil)
        }
    }

}
