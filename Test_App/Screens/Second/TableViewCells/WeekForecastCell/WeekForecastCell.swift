//
//  WeekForecastCell.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/17/22.
//

import UIKit

class WeekForecastCell: UITableViewCell {
    
    let monday: DailyForecastView = {
        let monday = DailyForecastView()
        monday.dayLabel.text = "Monday"
        return monday
    }()
    
    let tuesday: DailyForecastView = {
        let tuesday = DailyForecastView()
        tuesday.dayLabel.text = "Tuesday"
        return tuesday
    }()
    
    let wednesday: DailyForecastView = {
        let wednesday = DailyForecastView()
        wednesday.dayLabel.text = "Wednesday"
        return wednesday
    }()
    
    let thursday: DailyForecastView = {
        let thursday = DailyForecastView()
        thursday.dayLabel.text = "Thursday"
        return thursday
    }()
    
    let friday: DailyForecastView = {
        let friday = DailyForecastView()
        friday.dayLabel.text = "Friday"
        return friday
    }()
    
    let saturday: DailyForecastView = {
        let saturday = DailyForecastView()
        saturday.dayLabel.text = "Saturday"
        return saturday
    }()
    
    let sunday: DailyForecastView = {
        let sunday = DailyForecastView()
        sunday.dayLabel.text = "Sunday"
        return sunday
    }()
    
    let dailyForecastStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "BlueBackground")
        setupView()
    }
    
    private func setupView() {
        self.addSubview(dailyForecastStackView)
        dailyForecastStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        for dailyView in [monday, tuesday, wednesday, thursday, friday, saturday, sunday] {
            dailyForecastStackView.addArrangedSubview(dailyView)
        }
    }
}
