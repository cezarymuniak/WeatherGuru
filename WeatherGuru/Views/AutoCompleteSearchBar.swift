//
//  AutoCompleteSearchBar.swift
//  WeatherGuru
//
//  Created by CM on 30/04/2023.
//

import UIKit


class AutoCompleteSearchBar: UISearchBar, UITableViewDataSource, UITableViewDelegate {
    var autoCompleteTableView: UITableView!
    var autoCompleteSuggestions: [String] = []
    var suggestions: [String] = []
    var textField: UITextField?
    var errorLabel: UILabel?


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    func setupTableView() {
        autoCompleteTableView = UITableView(frame: CGRect.zero)
        autoCompleteTableView.delegate = self
        autoCompleteTableView.dataSource = self
        autoCompleteTableView.isHidden = true

        self.superview?.addSubview(autoCompleteTableView)

        textField = self.value(forKey: "searchField") as? UITextField
        textField?.addTarget(self, action: #selector(searchBarDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func searchBarDidChange() {
        autoCompleteTableView.isHidden = false
        
        guard let text = textField?.text, !text.isEmpty else {
            autoCompleteTableView.isHidden = true
            errorLabel?.isHidden = true
            return
        }
        
        let pattern = "^([a-zA-Z\\u0080-\\u024F]+(?:. |-| |'))*[a-zA-Z\\u0080-\\u024F]*$"
        
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: text.utf16.count)
            if regex.firstMatch(in: text, options: [], range: range) != nil {
                updateSuggestions()
                errorLabel?.isHidden = true
            } else {
                autoCompleteTableView.isHidden = true
                errorLabel?.isHidden = false
            }
        }
    }


    func updateSuggestions() {
        guard let text = textField?.text, !text.isEmpty else {
            autoCompleteTableView.isHidden = true
            return
        }

        autoCompleteSuggestions = suggestions.filter { $0.lowercased().contains(text.lowercased()) }
        autoCompleteTableView.reloadData()

        if autoCompleteSuggestions.count > 0 {
            autoCompleteTableView.isHidden = false
        } else {
            autoCompleteTableView.isHidden = true
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteSuggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "autoCompleteCell")
        cell.textLabel?.text = autoCompleteSuggestions[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField?.text = autoCompleteSuggestions[indexPath.row]
        autoCompleteTableView.isHidden = true
        self.endEditing(true)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        autoCompleteTableView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height, width: self.frame.width, height: 200)
    }
}
