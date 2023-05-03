//
//  WeatherDetailViewController.swift
//  WeatherGuru
//
//  Created by CM on 30/04/2023.
//

import WebKit

class WeatherDetailViewController: UIViewController {
    
    var webView: WKWebView!
    var city: String?
    var viewModel: WeatherDetailViewModel?
    var dailyModel: DailyWeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
