//
//  ViewController.swift
//  Test_1
//
//  Created by Andrey Doroshko on 8/20/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var cityLabel = UILabel()
    var ragionLabel = UILabel()
    var tempratureLabel = UILabel()
    var conditionLabel = UILabel()
    var dayOrNightLabel = UILabel()
    var timeLabel = UILabel()
    var conditionImageView = UIImageView()
    var moreButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
   
        self.view.addSubview(cityLabel)
        self.view.addSubview(ragionLabel)
        self.view.addSubview(tempratureLabel)
        self.view.addSubview(conditionLabel)
        self.view.addSubview(dayOrNightLabel)
        self.view.addSubview(timeLabel)
        self.view.addSubview(conditionImageView)
        self.view.addSubview(moreButton)
        
        setUpConstraints()
        setUpUI()
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
    
    func setUpConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        ragionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempratureLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        dayOrNightLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            ragionLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            ragionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            
            tempratureLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tempratureLabel.topAnchor.constraint(equalTo: ragionLabel.bottomAnchor, constant: 54),
            
            conditionLabel.topAnchor.constraint(equalTo: tempratureLabel.bottomAnchor, constant: 8),
            conditionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            dayOrNightLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 8),
            dayOrNightLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            timeLabel.topAnchor.constraint(equalTo: dayOrNightLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    func setUpUI() {
        cityLabel.textColor = .white
        cityLabel.font = UIFont.systemFont(ofSize: 21.0)
        
        ragionLabel.textColor = .white
        ragionLabel.font = .systemFont(ofSize: 17)
        
        tempratureLabel.textColor = .white
        tempratureLabel.font = .systemFont(ofSize: 54.0)
        
        conditionLabel.textColor = .white
        conditionLabel.font = .systemFont(ofSize: 17)
        
        dayOrNightLabel.textColor = .white
        dayOrNightLabel.font = .systemFont(ofSize: 50)
        
        timeLabel.textColor = .white
        timeLabel.font = .systemFont(ofSize: 24)
    }
    
    func getData() {
        AF.request(
            "https://api.weatherapi.com/v1/current.json?q=New%20York&key=1ad656828c264d949c5170050242108")
        .response(completionHandler: handleResponse)
    }
    
    func handleResponse(response: AFDataResponse<Data?>) {
        if let data = response.data {
            let stringData = String(data: data, encoding: .utf8)
            decodeWeatherData(data)
        } else if let error = response.error {
            present(
                UIAlertController(
                    title: "Error",
                    message: error.errorDescription,
                    preferredStyle: .alert),
                animated: true)
        }
    }
    
    func decodeWeatherData(_ data: Data) {
        do  {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            displayData(weatherData: weatherData)
        } catch (let error) {
            present(
                UIAlertController(
                    title: "Decoding error",
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
