//
//  AddItemViewController.swift
//  AusgabenTracker
//
//  Created by LEOS Develop on 10.04.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import UIKit
import Alamofire

class AddItemViewController: UIViewController{

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var merchantField: UITextField!
    @IBOutlet weak var contentField: UITextField!

    @IBAction func backButton(sender: AnyObject){
        self.navigationController!.popViewControllerAnimated(true)
    }

    @IBAction func saveButton(sender: AnyObject) {
        Alamofire.request(
            .POST,
            "http://192.168.1.99:1337/api/expenses",
            parameters: [
                "amount": self.amountField.text!,
                "merchant": self.merchantField.text!,
                "content": self.contentField.text!
            ])
        self.navigationController!.popViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
