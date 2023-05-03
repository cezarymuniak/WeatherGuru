//
//  MainViewSetup.swift
//  WeatherGuru
//
//  Created by CM on 03/05/2023.
//

import UIKit

extension MainViewController {
    func setupViews() {
        self.view.backgroundColor = .white
        

        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
        containerView.backgroundColor = .white
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = NSLocalizedString("searchBarPlaceholder", comment: "")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(searchBar)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = NSLocalizedString("errorLabelText", comment: "")
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.isHidden = true
        containerView.addSubview(errorLabel)
        
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.layer.cornerRadius = 20
        gradientView.clipsToBounds = true
        containerView.addSubview(gradientView)
        gradientView.alpha = 0
        
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(logoImageView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.tintColor = .clear
        tableView.separatorColor = .white
        tableView.sectionIndexBackgroundColor = .clear
        
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "suggestionCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 900),
            
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            errorLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: 20),
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 180),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            gradientView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gradientView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            gradientView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            gradientView.heightAnchor.constraint(equalToConstant: 320),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 8),
            
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
