//
//  WeatherDetailViewController.swift
//  WeatherGuru
//
//  Created by CM on 30/04/2023.
//

import WebKit
import CoreData

class WeatherDetailViewController: UIViewController {
    
    var webView: WKWebView!
    var key: String?
    var city: String?
    var viewModel: WeatherDetailViewModel?
    var dailyModel: DailyWeatherModel?
    let tomorrowLabel = UILabel()
    let tomorrowImageView = UIImageView(image: UIImage(named: "calendar"))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchTommorowWeather()
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func smallerGradientViewTapped() {
        if let link = dailyModel?.first?.mobileLink {
            let webViewController = WebViewController(urlString: link)
            webViewController.loadURL()
            present(webViewController, animated: true, completion: nil)    }
    }
    
    func fetchTommorowWeather() {
        viewModel?.searchTommorowWeather(key ?? "") { [weak self] result in
            switch result {
            case .success(_):
                
                DispatchQueue.main.async {
                    self?.tomorrowLabel.text = self?.viewModel?.getTommorowWeather()
                }
                
            case .failure(let error):
                print("Error searching for city: \(error)")
                DispatchQueue.main.async {
                    self?.tomorrowLabel.isHidden = true
                    self?.tomorrowImageView.isHidden = true
                }
            }
        }
    }
    
    func saveCityToCoreData(city: String, key: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context) as! City
        newCity.city = city
        newCity.key = key
        
        do {
            try context.save()
        } catch {
            print("Failed to save city: \(error.localizedDescription)")
        }
    }
}


extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}
