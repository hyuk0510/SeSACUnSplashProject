//
//  SimpleTableViewController.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/14.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    let list = [User(name: "Sun", age: 27), User(name: "Sang", age: 17), User(name: "Hyuk", age: 7)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        content.secondaryText = "\(list[indexPath.row].age)"
        cell.contentConfiguration = content
        return cell
    }
}
