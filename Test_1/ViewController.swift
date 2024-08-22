//
//  ViewController.swift
//  Test_1
//
//  Created by Andrey Doroshko on 8/20/24.
//

import UIKit
import Alamofire
import Realm
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = UIColor.orange
        getData()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        AF.request(
            "https://api.weatherapi.com/v1/current.json?q=New%20York&key=1ad656828c264d949c5170050242108")
        .response { response in
            
        }
    }
    
    func saveData() {
        let realm = try! Realm()
        
        try! realm.write({
//            realm.add("Response")
        })
    }
}

