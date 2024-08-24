//
//  ViewController.swift
//  Test_1
//
//  Created by Andrey Doroshko on 8/20/24.
//

import UIKit
import Alamofire

class Veachle {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

extension Veachle {
    func upgradeTitle(newTitle: String) {
        self.title = newTitle
    }
}

class Car: Veachle {
    var engine: String
    var brand: String
    
    init(engine: String, brand: String, title: String) {
        self.engine = engine
        self.brand = brand
        super.init(title: title)
    }
    
    func upgradeEngine(newEngine: String) {
        self.engine = newEngine
    }
}

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
                self?.decodeWeatherData(data)
            } else if let error = response.error {
                self?.present(UIAlertController(title: "Error",
                                                message: error.errorDescription,
                                                preferredStyle: .alert),
                              animated: true)
            }
        }
    }
    
    func decodeWeatherData(_ data: Data) {
        do  {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            displayData(weatherData: weatherData)
        } catch (let error) {
            present(UIAlertController(title: "Decoding error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert),
                    animated: true)
        }
    }
    
    func displayData(weatherData: WeatherData) {
        DispatchQueue.main.async { [weak self] in
            self?.cityLabel.text = weatherData.location.name
            self?.ragionLabel.text = weatherData.location.region + ", " + weatherData.location.country
            self?.tempratureLabel.text = "\(weatherData.current.temp_c)"
            self?.conditionLabel.text = weatherData.current.condition.text
            self?.dayOrNightLabel.text = weatherData.current.is_day == 1 ? "Day" : "Night"
            self?.timeLabel.text = weatherData.location.localtime
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
    let temp_c: Double
    let is_day: Int
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

