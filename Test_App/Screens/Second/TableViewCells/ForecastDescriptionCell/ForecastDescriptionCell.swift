//
//  ForecastDescriptionCell.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/17/22.
//

import UIKit

class ForecastDescriptionCell: UITableViewCell {
    
    let forecastDescriptionText: UILabel = {
        let ForecastDescriptionText = UILabel()
        ForecastDescriptionText.textColor = .white
        ForecastDescriptionText.translatesAutoresizingMaskIntoConstraints = false
        ForecastDescriptionText.text = "Cloudy conditions will continue all day. Wind gusts are up ti 9 mph."
        ForecastDescriptionText.textAlignment = .left
        ForecastDescriptionText.numberOfLines = 0
        return ForecastDescriptionText
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "BlueBackground")
        setupView()
    }
    
    private func setupView() {
        self.addSubview(forecastDescriptionText)
        forecastDescriptionText.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
}
