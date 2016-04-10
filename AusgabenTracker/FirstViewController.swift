//
//  FirstViewController.swift
//  AusgabenTracker
//
//  Created by LEOS Develop on 09.04.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSMutableArray?
    var newArray: Array<String> = []




    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, "http://192.168.1.99:1337/api/expenses")
            .responseJSON { response in
                // print(response.request)
                // print(response.response)
                // print(response.data)
                // print(response.result)

                if let JSON = response.result.value {
                    //print( "JSON: \(JSON)")

                    self.jsonArray = JSON as? NSMutableArray
                    for item in self.jsonArray! {
                        //print(item["content"])
                        let strContent = item["content"]! as? String
                        let strMerchant = item["merchant"]! as? String
                        let strPreis = item["amount"] as? String
                        let string =  strContent! + " ( " + strMerchant! + " ): " + strPreis!

                        print("String is \(string)")
                        self.newArray.append(string )
                    }
                    print("New Array is \(self.newArray)")
                    self.tableView.reloadData()
                }
        }

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = self.newArray[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

