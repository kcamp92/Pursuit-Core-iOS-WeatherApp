//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/18/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherDeets: WeatherData!
    
    var pictures = [Hit](){
        didSet {
            loadData()
        }
    }
    
    var cityName:String! {
        didSet {
            loadData()
            cityForecastDateLabel.text = "Weather Forecast for \(self.cityName.description), Time: \(weatherDeets.getSpecificTimeFromTime(time: weatherDeets.time))"
        }
    }
    
    lazy var cityForecastDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.text = "Weather for:"
        label.font = UIFont(name: "Marker Felt", size: 14.0)
        label.textColor = .black
        label.layer.borderWidth = 3
        label.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.backgroundColor = .clear
        return label
    }()
    
    
    lazy var cityImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 3
        iv.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return iv
    }()
    
    lazy var descriptionLabel: UILabel = {
        let tv = UILabel()
        tv.textAlignment = .center
        tv.numberOfLines = 0
        tv.adjustsFontSizeToFitWidth = true
        //tv.text = "Enter Description Here "
        tv.font = UIFont(name: "Marker Felt", size: 20.0)
        tv.backgroundColor = .clear
        tv.layer.borderWidth = 2
        tv.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return tv
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonPressed))
        button.isEnabled = false 
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = saveButton
        addSubViews()
        setUpConstraints()
        setupLabels()
        
    }
    
    @objc func saveButtonPressed(){
        let savedImage = FavoritedImages(image: (cityImage.image?.pngData())!)
        try?
        ImagePersistenceManager.manager.saveImage(image: savedImage)
        self.saveAlert()
    }
    
  
    
    private func setupLabels(){
        descriptionLabel.text = "High: \(weatherDeets.temperatureHigh.description), Low: \(weatherDeets.temperatureLow.description), Sunrise: \(weatherDeets.sunriseTime), Sunset: \(weatherDeets.sunsetTime),             Rain %: \(weatherDeets.precipProbability), WindSpeed: \(weatherDeets.windSpeed)"
    }
    
    private func saveAlert() {
        let alert = UIAlertController(title: "Saved", message: "Click on the 'favorites' tag to see your saved images", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert,animated: true)
    }
    
    
    
    
    //MARK: -Private Functions
    
    private func addSubViews() {
        view.addSubview(cityForecastDateLabel)
        view.addSubview(cityImage)
        view.addSubview(descriptionLabel)
    }
    
    
    private func loadData() {
        PicturesAPIClient.shared.getPictures(searchTerm: cityName!){
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.pictures = data
                    
                    ImageHelper.shared.getImage(urlStr: self.pictures.first?.largeImageURL ?? "") { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let image):
                                self.cityImage.image = image
                                self.saveButton.isEnabled = true
                            }
                        }
                    }
                }
                
            }
            
        }
    }
    
    //MARK: -Constraints Functions
    
    private func setUpConstraints() {
        cityForecastDateLabelConstraints()
        cityImageConstraints()
        descriptionTextViewConstraints()
    }
    
    private func cityForecastDateLabelConstraints() {
        
        cityForecastDateLabel.translatesAutoresizingMaskIntoConstraints = false
        cityForecastDateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        cityForecastDateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        cityForecastDateLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        cityForecastDateLabel.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    private func cityImageConstraints(){
        
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        cityImage.topAnchor.constraint(equalTo: cityForecastDateLabel.bottomAnchor, constant: 50).isActive = true
        cityImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        cityImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        cityImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func descriptionTextViewConstraints(){
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 50).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}


