//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class MainWeatherVC: UIViewController {
    
    lazy var weatherCollectionView: UICollectionView = {
        let cv = UICollectionView()
        cv.backgroundColor = .systemTeal
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var zipcodeTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray
        return tf
    }()
    
    lazy var forecastLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPink
        return label
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPink
        return label
    }()
    var weatherData  = [Weather]() {
        didSet{
            weatherCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForecastLabel()
        setUpCollectionView()
        setupTextfield()
        setUpInstructionLabel()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    // MARK:- Constraint Set-Up
    
    private func setUpForecastLabel(){
        view.addSubview(forecastLabel)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        forecastLabel.topAnchor.constraint(equalTo: view.topAnchor),
        forecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        forecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func setUpCollectionView(){
        view.addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
        weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    
    }
    private func setupTextfield(){
        view.addSubview(zipcodeTextField)
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zipcodeTextField.topAnchor.constraint(equalTo: view.topAnchor),
        zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
    }
    private func setUpInstructionLabel(){
        view.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        instructionLabel.topAnchor.constraint(equalTo: view.topAnchor),
        instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        instructionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
           
           
       }
    
    
    
    

}
//MARK: -Extensions

extension MainWeatherVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
extension MainWeatherVC: UITextFieldDelegate {
    
}
