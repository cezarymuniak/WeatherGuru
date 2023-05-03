//
//  GradientView.swift
//  WeatherGuru
//
//  Created by CM on 01/05/2023.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createGradientLayer()
    }
    
    private func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(red: 97/255, green: 184/255, blue: 245/255, alpha: 1.0).cgColor,
            UIColor(red: 45/255, green: 121/255, blue: 192/255, alpha: 1.0).cgColor
        ]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
}
