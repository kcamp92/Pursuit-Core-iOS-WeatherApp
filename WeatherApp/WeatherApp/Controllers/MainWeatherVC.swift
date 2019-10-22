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
        label.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
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
    
    private let cellSpacing = UIScreen.main.bounds.size.width * 0.09
    
    private var searchWord: String? {
        didSet{
         //   ZipCodeHelper
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setInitialValuesFromUserDefaults()
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
      
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        forecastLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        forecastLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        forecastLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpCollectionView(){
        
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor).isActive = true
        weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func setupTextfield(){
        
        zipcodeTextField.translatesAutoresizingMaskIntoConstraints = false
       
        zipcodeTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 30).isActive = true
        zipcodeTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        zipcodeTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    
    /*  private   func createPickerViewConstraints() {
            
              settingsPickerView.translatesAutoresizingMaskIntoConstraints = false
     
              settingsPickerView.topAnchor.constraint(equalTo: bestSellerCollectionView.bottomAnchor,constant: 30).isActive = true
          settingsPickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
           settingsPickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
          settingsPickerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
              
          }
      */
    private func setUpInstructionLabel(){
       
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        instructionLabel.topAnchor.constraint(equalTo: zipcodeTextField.bottomAnchor,constant: 30).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        instructionLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
        
    
    func addSubViews(){
        view.addSubview(forecastLabel)
        view.addSubview(weatherCollectionView)
        view.addSubview(zipcodeTextField)
        view.addSubview(instructionLabel)
    }
        var zipCode = "" {
            didSet{
                UserDefaultsWrapper.manager.store(zipCode: zipCode)
            }
        }
        
        private func setInitialValuesFromUserDefaults(){
            if let storedZipCode = UserDefaults.standard.value(forKey: "zipCode") as? String {
                zipCode = storedZipCode
            }
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let numCells: CGFloat = 0.8
           let numSpaces: CGFloat = numCells + 2.9
           
           let screenWidth = UIScreen.main.bounds.width
           let screenHeight = UIScreen.main.bounds.height
           
           return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.7)
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
