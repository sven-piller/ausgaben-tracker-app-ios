//
//  FirstViewController.swift
//  AusgabenTracker
//
//  Created by LEOS Develop on 09.04.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, "http://192.168.1.99:1337/api/expenses")
            .responseJSON { response in //
            print(response.request)
            print(response.response)
                print(response.data)
                print(response.result)

                if let JSON = response.result.value {
                    print( "JSON: \(JSON)")
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

