//
//  MainWeatherVC.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

private let cellIdentifier = "WeatherCell"

class MainWeatherVC: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Properties
    
    lazy var weatherCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 250, height: 300)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .blue
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        cv.register(WeatherCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    lazy var zipcodeTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray
        tf.delegate = self
        return tf
    }()
    
    lazy var forecastLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 20.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        return label
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 25.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
       // label.backgroundColor = .systemPink
        label.text = "Enter a Zip Code"
        return label
    }()
    
    var weatherData  = [WeatherData]() {
        didSet{
            weatherCollectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setInitialValuesFromUserDefaults()
        setUpConstrains()
        //loadData()
    }
    
    // MARK: - Private Methods
    
    private let cellSpacing = UIScreen.main.bounds.size.width * 0.09
    
    var searchString: String = "" {
        didSet {
            
            loadData()
        }
    }
    
    private func loadData(){
        WeatherAPIClient.shared.getWeather(latLong: searchString){
            (result) in
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
    
    // MARK:- Constraints Set-Up
    
    private func setUpConstrains(){
        
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:15).isActive = true
        forecastLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        forecastLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        forecastLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
      // forecastLabel.bottomAnchor.constraint(equalTo: weatherCollectionView.topAnchor, constant: 20)
        
        
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor, constant: 30).isActive = true
        weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        zipcodeTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 30).isActive = true
        zipcodeTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
        zipcodeTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
        zipcodeTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        instructionLabel.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor,constant: 30).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        instructionLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    func addSubViews(){
        view.addSubview(forecastLabel)
        view.addSubview(weatherCollectionView)
        view.addSubview(zipcodeTextField)
        view.addSubview(instructionLabel)
    }
    
    //MARK: - User Defaults
    
    var zipCode = "" {
        didSet{
            UserDefaultsWrapper.manager.store(zipCode: zipCode)
        }
    }
    
    var townName = "" {
        didSet {
            forecastLabel.text = "Weather Forecast for \(self.townName)"
        }
    }
    private func setInitialValuesFromUserDefaults(){
        if let storedZipCode = UserDefaults.standard.value(forKey: "zipCode") as? String {
            zipCode = storedZipCode
        }
        zipcodeTextField.text = UserDefaultsWrapper.manager.getZipCode()
    }
    
    
    //MARK: - TextField Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            searchString = text
        }
        zipCodeHelper()
        
        return true
    }
    
    private func zipCodeHelper (){
        ZipCodeHelper.getLatLong(fromZipCode: searchString){
            (results) in
            switch results {
            case .success(let lat, let long, let name):
                UserDefaultsWrapper.manager.store(zipCode: self.searchString)
                self.searchString = "\(lat),\(long)"
                self.townName = name
            case .failure(_):
                UserDefaultsWrapper.manager.store(zipCode: "")
                
                
            }
        }
    }
}




//MARK: - Extensions

extension MainWeatherVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weather = weatherData[indexPath.item]
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.dateLabel.text = weather.getSpecificTimeFromTime(time: weather.time)
        // cell.iconImage.image = weather.icon(UIImage.(named: "")
        cell.highLabel.text = weather.temperatureHigh.description
        cell.lowLabel.text = weather.temperatureLow.description
        cell.iconImage.image = weather.returnPictureBasedOnIcon(icon: weather.icon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 0.8
        let numSpaces: CGFloat = numCells + 2.9
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailWVC = DetailViewController()
        let selectedWeather = weatherData[indexPath.row]
        detailWVC.weatherDeets = selectedWeather
        detailWVC.cityName = townName
        self.navigationController?.pushViewController(detailWVC, animated: true)
        
    }
    
    
}
