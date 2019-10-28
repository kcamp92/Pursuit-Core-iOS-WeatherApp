//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Krystal Campbell on 10/18/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pictures = [Hit](){
        didSet {
           // setImage()
            
        }
    }
    
    var cityName:String! {
        didSet {
            loadData()
          }
      }
    
    var weatherDeets: WeatherData!
    
    lazy var cityForecastDateLabel: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.font = UIFont(name: "Marker Felt", size: 30.0)
          label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
          label.backgroundColor = .systemGreen
          return label
          }()
      
    
    lazy var cityImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 4
        iv.layer.borderColor = UIColor.blue.cgColor
        return iv
      }()
    
    lazy var descriptionTextView: UITextView = {
        let label = UITextView()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt", size: 30.0)
        label.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.backgroundColor = .systemGreen
        return label
           }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonPressed))
           button.isEnabled = false
        return button

    }()
    
    @objc func saveButtonPressed(){
        let savedImage = FavoritedPictures(hits: pictures)
        DispatchQueue.global(qos: .utility).async {
            try?
                ImagePersistenceManager.manager.saveImage(image: savedImage)
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
            self.saveAlert()
            }
        }
 //   }
    
    private func saveAlert() {
          let alert = UIAlertController(title: "Saved", message: "Click on the 'favorites' tag to see your saved images", preferredStyle: .alert)
          let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
          alert.addAction(ok)
          self.present(alert,animated: true)
      }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = saveButton
        addSubViews()
        setUpConstraints()

    }
    
  //MARK: -Private Functions
    
    private func addSubViews() {
        view.addSubview(cityForecastDateLabel)
        view.addSubview(cityImage)
        view.addSubview(descriptionTextView)
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
                   }
               }
           }
       }
  //MARK: -Constraints Functions
 private func setUpConstraints() {
         
         cityForecastDateLabel.translatesAutoresizingMaskIntoConstraints = false
        cityForecastDateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:15).isActive = true
       cityForecastDateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
         cityForecastDateLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
         cityForecastDateLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
         cityImage.translatesAutoresizingMaskIntoConstraints = false
         cityImage.topAnchor.constraint(equalTo: cityForecastDateLabel.bottomAnchor, constant: 30).isActive = true
         cityImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        cityImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
         cityImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
         
         
         
         descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
         
         descriptionTextView.topAnchor.constraint(equalTo:  cityImage.bottomAnchor, constant: 30).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
         descriptionTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
         descriptionTextView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}
    
 
