//
//  WeatherDetailViewSetup.swift
//  WeatherGuru
//
//  Created by CM on 03/05/2023.
//

import Foundation
import UIKit
import WebKit
extension WeatherDetailViewController {
    func setupViews() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(smallerGradientViewTapped))
        
        view.backgroundColor = .white
        
        webView = WKWebView(frame: .zero)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.layer.cornerRadius = 20
        gradientView.clipsToBounds = true
        view.addSubview(gradientView)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        let iconImageView = UIImageView(image: UIImage(named: "logo"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)
        
        let cityName = city ?? NSLocalizedString("unknownCity", comment: "Unknown City")
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        cityLabel.textColor = .black
        cityLabel.text = cityName
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.minimumScaleFactor = 0.3
        view.addSubview(cityLabel)

        let iconName = viewModel?.getWeatherIconName() ?? "image_not_found"
        let weatherImageView = UIImageView(image: UIImage(named: iconName))
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.contentMode = .scaleAspectFit
        gradientView.addSubview(weatherImageView)

        
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Poppins-Light", size: 15.0)
        dateLabel.textColor = .white
        dateLabel.text = viewModel?.getFormattedDate()
        gradientView.addSubview(dateLabel)
        
        let temperatureLabel = GradientLabel()
        if let temperatureString = viewModel?.getTemperature() {
            temperatureLabel.font = UIFont(name: "Poppins-Bold", size: 46.0)
            temperatureLabel.topColor = .white
            temperatureLabel.centerColor = .white
            temperatureLabel.bottomColor = viewModel?.getTemperatureColor() ?? .clear
            let attributedString = NSMutableAttributedString(string: temperatureString)
            temperatureLabel.attributedText = attributedString
            temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(temperatureLabel)
        }
        
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .white
        gradientView.addSubview(lineView)
        
        let windImageView = UIImageView(image: UIImage(named: "wind"))
        windImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let windLabel = UILabel()
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.font = UIFont(name: "Poppins-Light", size: 12.0)
        windLabel.textColor = .white
        windLabel.text = viewModel?.getWindSpeed()
        
        let humidityImageView = UIImageView(image: UIImage(named: "humidity"))
        humidityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let humidityLabel = UILabel()
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.font = UIFont(name: "Poppins-Light", size: 12.0)
        humidityLabel.textColor = .white
        humidityLabel.text = viewModel?.getHumidity()
        
        let pressureImageView = UIImageView(image: UIImage(named: "pressure"))
        pressureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let pressureLabel = UILabel()
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.font = UIFont(name: "Poppins-Light", size: 12.0)
        pressureLabel.textColor = .white
        pressureLabel.text = viewModel?.getPressure()
        gradientView.addSubview(pressureLabel)
        
        
        let tomorrowImageView = UIImageView(image: UIImage(named: "calendar"))
        tomorrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        tomorrowLabel.translatesAutoresizingMaskIntoConstraints = false
        tomorrowLabel.font = UIFont(name: "Poppins-Light", size: 12.0)
        tomorrowLabel.textColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.addSubview(stackView)
        
        let firstRowStack = UIStackView(arrangedSubviews: [windImageView, windLabel, humidityImageView, humidityLabel])
        firstRowStack.axis = .horizontal
        firstRowStack.spacing = 5
        firstRowStack.distribution = .equalCentering
        stackView.addArrangedSubview(firstRowStack)
        
        let secondRowStack = UIStackView(arrangedSubviews: [pressureImageView, pressureLabel])
        secondRowStack.axis = .horizontal
        secondRowStack.spacing = 5
        stackView.addArrangedSubview(secondRowStack)
        
        let thirdRowStack = UIStackView(arrangedSubviews: [tomorrowImageView, tomorrowLabel ])
        thirdRowStack.axis = .horizontal
        thirdRowStack.spacing = 5
        stackView.addArrangedSubview(thirdRowStack)
        
        let smallerGradientView = GradientView()
        smallerGradientView.translatesAutoresizingMaskIntoConstraints = false
        smallerGradientView.layer.cornerRadius = 10
        smallerGradientView.clipsToBounds = true
        view.addSubview(smallerGradientView)
        
        smallerGradientView.addGestureRecognizer(tapGestureRecognizer)
        smallerGradientView.isUserInteractionEnabled = true
        
        let smallImageView = UIImageView(image: UIImage(named: "accuweatherIcon"))
        smallImageView.translatesAutoresizingMaskIntoConstraints = false
        smallImageView.contentMode = .scaleAspectFit
        smallerGradientView.addSubview(smallImageView)
        
        let smallLabel = UILabel()
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        smallLabel.font = UIFont(name: "Poppins-Bold", size: 14.0)
        smallLabel.textColor = .white
        smallLabel.textAlignment = .center
        smallLabel.text = NSLocalizedString("clickToSeeMoreDetails", comment: "Click to see more details on the website")
        smallerGradientView.addSubview(smallLabel)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            gradientView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gradientView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            gradientView.bottomAnchor.constraint(equalTo: smallerGradientView.topAnchor, constant: -20),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            cityLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            cityLabel.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: -35),
            cityLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            weatherImageView.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 20),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 200),
            weatherImageView.heightAnchor.constraint(equalToConstant: 200),
            
            dateLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: -20),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            
            lineView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -20),
            lineView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            
            stackView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: gradientView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -20),
            
            windImageView.widthAnchor.constraint(equalToConstant: 30),
            windImageView.heightAnchor.constraint(equalToConstant: 30),
            
            humidityImageView.widthAnchor.constraint(equalToConstant: 30),
            humidityImageView.heightAnchor.constraint(equalToConstant: 30),
            
            pressureImageView.widthAnchor.constraint(equalToConstant: 30),
            pressureImageView.heightAnchor.constraint(equalToConstant: 30),
            
            tomorrowImageView.widthAnchor.constraint(equalToConstant: 30),
            tomorrowImageView.heightAnchor.constraint(equalToConstant: 30),
            
            smallerGradientView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            smallerGradientView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            smallerGradientView.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 20),
            smallerGradientView.heightAnchor.constraint(equalToConstant: 50),
            smallerGradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            smallImageView.leadingAnchor.constraint(equalTo: smallerGradientView.leadingAnchor, constant: 10),
            
            smallImageView.centerYAnchor.constraint(equalTo: smallerGradientView.centerYAnchor),
            smallImageView.widthAnchor.constraint(equalToConstant: 30),
            smallImageView.heightAnchor.constraint(equalToConstant: 30),
            
            smallLabel.leadingAnchor.constraint(equalTo: smallImageView.trailingAnchor, constant: 10),
            smallLabel.centerYAnchor.constraint(equalTo: smallerGradientView.centerYAnchor),
            smallLabel.trailingAnchor.constraint(equalTo: smallerGradientView.trailingAnchor, constant: -10)
        ])
    }
    
}
