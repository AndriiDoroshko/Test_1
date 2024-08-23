//
//  ViewController.swift
//  Test_1
//
//  Created by Andrey Doroshko on 8/20/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ragionLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var dayOrNightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    let viewController = UIViewController()
    let viewTop = UIView()
    let viewBottom = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        
        self.addChild(viewController)
        self.view.addSubview(viewTop)
        self.view.addSubview(viewBottom)
        viewBottom.addSubview(viewController.view)
        
        getData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func getData() {
        AF.request(
            "https://api.weatherapi.com/v1/current.json?q=New%20York&key=1ad656828c264d949c5170050242108")
        .response {[weak self] response in
            if let data = response.data {
                let stringData = String(data: data, encoding: .utf8)
                
                do  {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self?.cityLabel.text = weatherData.location.name
                    }
                   
                    print(weatherData)
                } catch (let error) {
                    print(error)
                }
               
            }
        }
    }

}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

struct Current: Codable {
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct WeatherData: Codable {
    let location: Location
    let current: Current
}

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
    }
}

