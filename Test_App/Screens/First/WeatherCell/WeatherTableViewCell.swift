//
//  WeatherTableViewCell.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/8/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
        
    var cellType: cellType = .cityCell
    var updateTableview: ((String) -> ())?
    
    lazy var weatherTextField: UISearchBar = {
        let weatherTextField = UISearchBar()
        weatherTextField.placeholder = "Search"
        weatherTextField.delegate = self
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor(named: "TextColor")
        weatherTextField.tintColor = UIColor(named: "TextColor")
        weatherTextField.searchBarStyle = .minimal
        weatherTextField.translatesAutoresizingMaskIntoConstraints = false
        weatherTextField.layer.cornerRadius = 10
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageContainerView.addSubview(imageView)
        return weatherTextField
    }()

    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: "BackgroundColor")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont.boldSystemFont(ofSize: 32)
        locationLabel.textColor = UIColor(named: "TextColor")
        locationLabel.text = "Location"
        locationLabel.numberOfLines = 0
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = UIColor(named: "TextColor")
        timeLabel.text = "12:00"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.font = UIFont.systemFont(ofSize: 40)
        temperatureLabel.textAlignment = .right
        temperatureLabel.text = "16°"
        temperatureLabel.textColor = UIColor(named: "TextColor")
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    lazy var iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "01d@2x.png")
        iconImage.tintColor = UIColor.black
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        return iconImage
    }()
    
    lazy var timeAndLocationContainer: UIView = {
        let timeAndLocationContainer = UIView()
        timeAndLocationContainer.backgroundColor = UIColor(named: "BackgroundColor")
        timeAndLocationContainer.translatesAutoresizingMaskIntoConstraints = false
        return timeAndLocationContainer
    }()
    
    lazy var tempAndImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.removeSubviews(weatherTextField, containerView)
    }
    
    func setUpView(cellType: cellType) {
        switch cellType {
        case .searchCell:
            self.addSubview(weatherTextField)
        case .cityCell:
            self.addSubview(containerView)
            timeAndLocationContainer.addSubviews(timeLabel, locationLabel)
            tempAndImageContainer.addSubviews(iconImage, temperatureLabel)
            containerView.addSubviews(timeAndLocationContainer, tempAndImageContainer)
        }
        
        setupConstraints(cellType: cellType)
    }
    
    func setupConstraints(cellType: cellType) {
        switch cellType {
        case .searchCell:
            weatherTextField.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
            NSLayoutConstraint.activate([
                weatherTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .cityCell:
            containerView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
            
            NSLayoutConstraint.activate([
                timeAndLocationContainer.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 10),
                timeAndLocationContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
                timeAndLocationContainer.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10),
                timeAndLocationContainer.trailingAnchor.constraint(equalTo: tempAndImageContainer.leadingAnchor, constant: -5),
                timeAndLocationContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0),
                
                locationLabel.leadingAnchor.constraint(equalTo: timeAndLocationContainer.leadingAnchor, constant: 5),
                locationLabel.bottomAnchor.constraint(equalTo: timeAndLocationContainer.bottomAnchor, constant: -5),
                locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
                locationLabel.trailingAnchor.constraint(equalTo: timeAndLocationContainer.trailingAnchor, constant: -5),
                
                timeLabel.leadingAnchor.constraint(equalTo: timeAndLocationContainer.leadingAnchor, constant: 5),
                timeLabel.topAnchor.constraint(equalTo: timeAndLocationContainer.topAnchor, constant: 5),
                
                temperatureLabel.trailingAnchor.constraint(equalTo: tempAndImageContainer.trailingAnchor, constant: 0),
                temperatureLabel.topAnchor.constraint(greaterThanOrEqualTo: tempAndImageContainer.topAnchor, constant: 5),
                temperatureLabel.bottomAnchor.constraint(lessThanOrEqualTo: tempAndImageContainer.bottomAnchor, constant: -5),
                temperatureLabel.centerYAnchor.constraint(equalTo: tempAndImageContainer.centerYAnchor, constant: 0),
                temperatureLabel.widthAnchor.constraint(equalToConstant: 88),
                temperatureLabel.heightAnchor.constraint(equalTo: temperatureLabel.widthAnchor),

                iconImage.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -5),
                iconImage.heightAnchor.constraint(equalToConstant: 72),
                iconImage.centerYAnchor.constraint(equalTo: tempAndImageContainer.centerYAnchor),
                iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor, constant: 0),
                iconImage.leadingAnchor.constraint(greaterThanOrEqualTo: tempAndImageContainer.leadingAnchor),
                
                
                tempAndImageContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
                tempAndImageContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
                temperatureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
                
            ])
        }
    }
}

extension WeatherTableViewCell: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        updateTableview?(text)
    }
}

enum cellType {
    case searchCell
    case cityCell
}
