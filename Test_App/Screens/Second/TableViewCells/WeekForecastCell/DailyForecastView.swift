//
//  ReusableView.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/12/22.
//

import Foundation
import UIKit

class DailyForecastView: UIView {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Monday"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageAndHumidityContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        stackView.alignment = .center
        stackView.spacing = 1
        return stackView
    }()
    
    lazy var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.image = iconImages[Int.random(in: 0...iconImages.count-1)]
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherImage
    }()
    
    let humidityLabel: UILabel = {
        let humidity = UILabel()
        humidity.text = "\(Int.random(in: 0...80))%"
        humidity.textColor = UIColor(named: "HumidityColor")
        humidity.textAlignment = .left
        humidity.translatesAutoresizingMaskIntoConstraints = false
        return humidity
    }()
    
    let temperaturesContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.contentMode = .scaleAspectFit
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    let lowerTemp: UILabel = {
        let lowerTemp = UILabel()
        lowerTemp.textColor = .white.withAlphaComponent(0.5)
        lowerTemp.text = "4°"
        lowerTemp.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lowerTemp.textAlignment = .left
        lowerTemp.translatesAutoresizingMaskIntoConstraints = false
        return lowerTemp
    }()
    
    let highTemp: UILabel = {
        let highTemp = UILabel()
        highTemp.textColor = .white
        highTemp.text = "14°"
        highTemp.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        highTemp.textAlignment = .left
        highTemp.translatesAutoresizingMaskIntoConstraints = false
        return highTemp
    }()
    
    var iconImages = [UIImage(named: "01d@2x"), UIImage(named: "02d@2x"), UIImage(named: "03d@2x"), UIImage(named: "04d@2x"), UIImage(named: "09d@2x"), UIImage(named: "10d@2x"), UIImage(named: "11d@2x"), UIImage(named: "13d@2x"), UIImage(named: "50d@2x")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
                
        addSubviews(dayLabel, imageAndHumidityContainer, temperaturesContainer)
        imageAndHumidityContainer.addArrangedSubview(weatherImage)
        imageAndHumidityContainer.addArrangedSubview(humidityLabel)
        
        temperaturesContainer.addArrangedSubview(highTemp)
        temperaturesContainer.addArrangedSubview(lowerTemp)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            
            imageAndHumidityContainer.trailingAnchor.constraint(greaterThanOrEqualTo: temperaturesContainer.leadingAnchor, constant: -56),
            imageAndHumidityContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageAndHumidityContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            imageAndHumidityContainer.leadingAnchor.constraint(greaterThanOrEqualTo: dayLabel.trailingAnchor, constant: 0),
            
            temperaturesContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            temperaturesContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            temperaturesContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}
