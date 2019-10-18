//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

private let cellIdentifier = "WeatherCell"
class MainWeatherVC: UIViewController {
    
    
// MARK: - Properties
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemTeal
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: cellIdentifier)
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
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .blue
        return label
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .systemPink
        return label
    }()
    
    var weatherData  = [WeatherData]() {
        didSet{
            weatherCollectionView.reloadData()
        }
    }
    
    private var searchWord: String? {
        didSet{
         //   ZipCodeHelper
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForecastLabel()
        setUpCollectionView()
        setupTextfield()
        setUpInstructionLabel()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    
    private func loadData(){
        WeatherAPIClient.shared.getWeather(lat: searchWord ?? "", long: searchWord ?? ""){
        (result)in
        DispatchQueue.main.async{
            switch result {
            case.success(let weatherFromOnline):
                self.weatherData = weatherFromOnline
            case.failure(let error):
                print(error)
            }
        }
    }
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
        weatherCollectionView.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor),
        weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    
    }
    private func setupTextfield(){
        view.addSubview(zipcodeTextField)
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zipcodeTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor),
        zipcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        zipcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
    }
    private func setUpInstructionLabel(){
        view.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        instructionLabel.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor),
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
        let weather = weatherData[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.dateLabel.text = weather.time.description
       // cell.iconImage.image = weather.icon(UIImage.(named: "")
        cell.highLabel.text = weather.temperatureHigh.description
        cell.lowLabel.text = weather.temperatureLow.description
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailWVC = DetailViewController()
//
        /*let detailVC = AnimeDetailVC()
            let selectedAnime = animeList[indexPath.row]
            detailVC.anime = selectedAnime
            self.navigationController?.pushViewController(detailVC, animated: true)
        }*/
        
        /*/
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RecipesCell
             let recipe = recipes[indexPath.row]
             cell.configureCell(with: recipes, collectionView: recipesCollectionView, index: indexPath.row)
             return cell
             
         }
        */
    
}

//extension MainWeatherVC: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
//
//}
