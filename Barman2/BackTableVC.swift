//
//  BackTableVC.swift
//  Barman
//
//  Created by Wisnia on 13.06.2015.
//  Copyright (c) 2015 Wisnia. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    var TableArray = [String]()
    override func viewDidLoad() {
        TableArray = ["Menu","Drink","Pomoc"]
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
    
}