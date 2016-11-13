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
    var priceArray: Array<String> = []
    var IDArray: Array<String> = []
    var ip = "192.168.1.110"
    //var ip = "192.168.1.99"


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.downloadAndUpdate()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        cell.textLabel?.text = self.newArray[indexPath.row]
        cell.detailTextLabel?.text = self.priceArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("ID is \(self.IDArray[indexPath.row])")
            let url = "http://\(self.ip):1337/api/expenses/\(self.IDArray[indexPath.row])"
            print(url)
            Alamofire.request(.DELETE, url)
            self.downloadAndUpdate()
        } else if editingStyle == .insert {
            // Create new Instance and save
        }
    }

    func downloadAndUpdate() {
        self.newArray.removeAll()
        self.priceArray.removeAll()
        self.IDArray.removeAll()

        Alamofire.request(.GET, "http://\(self.ip):1337/api/expenses").responseJSON { response in
            // print(response.request)
            // print(response.response)
            // print(response.data)
            // print(response.result)

            if let JSON = response.result.value {
                //print( "JSON: \(JSON)")
                self.jsonArray = JSON as? NSMutableArray

                for item in self.jsonArray! {
                    //print(item["content"])
                    let ID = item["_id"]!
                    let strContent = item["content"]! as? String
                    let strMerchant = item["merchant"]! as? String
                    let strPreis = item["amount"] as? String
                    let string =  strContent! + " (" + strMerchant! + ")"

                    print("String is \(string)")
                    self.newArray.append(string)
                    self.priceArray.append(strPreis!)
                    self.IDArray.append(ID! as! String)
                }
                print("New Array is \(self.newArray)")
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

