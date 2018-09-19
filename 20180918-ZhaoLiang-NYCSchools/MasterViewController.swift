//
//  MasterViewController.swift
//  20180918-ZhaoLiang-NYCSchools
//
//  Created by Zhao Liang on 9/18/18.
//  Copyright © 2018 Leon Liang. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController{

    var schoolListUrl: String {
        return "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    }
    
    var itemList: [SchoolItem]?
    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "NYC high school list"
        tableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: "SchoolTableViewCell")
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        //fetch json for school list
        NetWorkHandler.fetchJson(url: schoolListUrl) { (json, error) in
            if let _ = error{
                return
            }
        
            if let itemListsJson = json as? [[String: Any]]{
                self.itemList = itemListsJson.map {
                    SchoolItem(json: $0)
                }
            }
        
            //update UI in main queue
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    // MARK: - Segues

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                //pase model to detail page
                controller.item = itemList?[indexPath.row]
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = itemList?.count else{
            return 0
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as? SchoolTableViewCell else{
            return UITableViewCell()
        }

        guard let itemList = itemList else {
            return UITableViewCell()
        }
        let item = itemList[indexPath.row]
        
        cell.title.text = item.title
        return cell
            
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.init(200)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }


}

