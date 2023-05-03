//
//  MainViewController.swift
//  WeatherGuru
//
//  Created by CM on 28/04/2023.

import UIKit

class MainViewController: UIViewController {
    let tableView = UITableView()
    let gradientView = GradientView()
    let errorLabel: UILabel = UILabel()
    let searchBar = UISearchBar()
    let logoImageView = UIImageView(image: UIImage(named: "weatherGuruLogo"))
    let scrollView = UIScrollView()
    let containerView = UIView()
    var searchTimer: Timer?
    let viewModel = MainViewModel()
    var locations = [Location]()
    let tapGestureRecognizer = UITapGestureRecognizer(target: MainViewController.self, action: #selector(dismissKeyboard))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearViews()
        setupViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        clearViews()
        setupViews()
    }
    
    
    // MARK: - Setup UI
    func clearViews() {
        searchBar.text = ""
        gradientView.removeFromSuperview()
        gradientView.alpha = 0
    }
    
    
    func expandSearchBar() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    func animatedCloseUp() {
        DispatchQueue.main.async {
            UIView.transition(with: self.gradientView ,
                              duration: 0.6,
                              options: [.transitionCurlUp],
                              animations: {
                UIView.animate(withDuration: 0.6) {
                    self.gradientView.alpha = 0
                    self.clearViews()
                }
            }
            )}
    }
}

// MARK: - Search Locations
private extension MainViewController {
    func searchLocations(_ query: String) {
        viewModel.searchLocations(query) { [weak self] result in
            switch result {
            case .success(_):
                
                DispatchQueue.main.async {
                    self?.errorLabel.isHidden = true
                    
                    UIView.transition(with: self?.gradientView ?? UIView(),
                                      duration: 0.6,
                                      options: [.transitionCurlDown],
                                      animations: { [weak self] in
                        self?.gradientView.alpha = 1
                        self?.expandSearchBar()
                        self?.locations = self?.viewModel.locations ?? Locations()
                    },
                                      completion: { finished in
                        if finished {
                            print("Animation completed!")
                            UIView.animate(withDuration: 0.1) { [weak self] in
                                self?.tableView.reloadData()
                            }
                        } else {
                            print("Animation was interrupted!")
                        }
                    })
                }
                
            case .failure(let error):
                print("Error searching for city: \(error)")
                self?.animatedCloseUp()
            }
        }
    }
}

// MARK: - Keyboard Handling
private extension MainViewController {
    @objc func keyboardWillShow(notification: Notification) {
        // TODO: Apply Search Database based on Core Data or Realm
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) { [self] in
                logoImageView.alpha = 0.0
            }
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight + 350.0, right: 0.0)
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) { [self] in
                logoImageView.alpha = 1.0
            }
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight - 350.0, right: 0.0)
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tableView) == true {
            return false
        }
        return true
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let pattern = "^([a-zA-Z\\u0080-\\u024F]+(?:. |-| |'))*[a-zA-Z\\u0080-\\u024F]*$"
        
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: searchText.utf16.count)
            if regex.firstMatch(in: searchText, options: [], range: range) != nil {
                errorLabel.isHidden = true
            } else {
                animatedCloseUp()
                errorLabel.isHidden = false
            }
        }
        
        searchTimer?.invalidate()
        if searchText.count >= 2 {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { [weak self] _ in
                self?.searchLocations(searchText)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell", for: indexPath)
        let location = viewModel.locations[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Poppins-SemiBold", size: 18.0)
        cell.selectionStyle = .none
        cell.textLabel?.text = location.localizedName
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = viewModel.locations[indexPath.row]
        if let key = selectedLocation.key {
            
            viewModel.searchCurrentWeather(key) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let dailyModel):
                        DispatchQueue.main.async {
                            let detailVC = WeatherDetailViewController()
                            detailVC.dailyModel = dailyModel
                            detailVC.city = selectedLocation.localizedName ?? ""
                            detailVC.key = selectedLocation.key ?? ""
                            detailVC.modalPresentationStyle = .fullScreen
                            detailVC.viewModel = WeatherDetailViewModel(dailyModel: dailyModel)
                            self.present(detailVC, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        print("Error fetching daily weather data: \(error)")
                    }
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
