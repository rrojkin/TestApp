//
//  SecondViewController.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/10/22.
//

import UIKit

enum viewMode {
    case shown
    case hidden
}

class SecondViewController: UIViewController {

    var labelView: UIView = {
        let view = UIView()
        var mode: viewMode?
        view.backgroundColor = UIColor(named: "BlueBackground")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 34)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "16°"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 96, weight: .thin)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Mostly Cloudy \n H:8° | L:0°"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var collectionViewContainer: UIView = {
        let collectionViewContainer = UIView()
        collectionViewContainer.backgroundColor = .white.withAlphaComponent(0.3)
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewContainer
    }()

    lazy var weatherCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = .init(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        
        let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weatherCollectionView.backgroundColor = UIColor(named: "BlueBackground")
        weatherCollectionView.showsHorizontalScrollIndicator = false
                
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        weatherCollectionView.register(UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
        return weatherCollectionView
    }()
    
    lazy var weatherTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "BlueBackground")
        table.showsVerticalScrollIndicator = false
        
        table.dataSource = self
        table.delegate = self
        
        table.separatorColor = .white.withAlphaComponent(0.3)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(UINib(nibName: String(describing: WeekForecastCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeekForecastCell.self))
        table.register(UINib(nibName: String(describing: ForecastDescriptionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ForecastDescriptionCell.self))
        table.register(UINib(nibName: String(describing: ForecastDetailsCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ForecastDetailsCell.self))
        
        return table
    }()
    
    var labelViewMode: viewMode = .shown {
        didSet {
            updateTopViewConstraints(animated: true)
        }
    }
    
    var descriptionLabelTopAcnh = NSLayoutConstraint()
    var cityLabelTopConstraint = NSLayoutConstraint()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(labelView, collectionViewContainer, weatherTable)
        
        collectionViewContainer.addSubview(weatherCollectionView)
        labelView.addSubviews(cityLabel, tempLabel, descriptionLabel)
        
        view.backgroundColor = UIColor(named: "BlueBackground")
                
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        descriptionLabelTopAcnh = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: labelViewMode == .shown ? tempLabel : cityLabel, attribute: .bottom, multiplier: 1, constant: 16)
        cityLabelTopConstraint = NSLayoutConstraint(item: cityLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: labelViewMode == .shown ? 0 : -20)
                                
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        weatherCollectionView.fillSuperview(padding: .init(top: 1, left: 0, bottom: 1, right: 0))
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            labelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionViewContainer.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 20),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 120),
            
            weatherTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            weatherTable.topAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor, constant: 0),
            weatherTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            weatherTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor, constant: 0),
            cityLabel.widthAnchor.constraint(equalToConstant: 200),
            
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 16),
            tempLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor, constant: 0),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 0)
        ])
        
        updateTopViewConstraints()
    }
    
    private func updateTopViewConstraints(animated: Bool = false) {
        
        view.removeConstraints([descriptionLabelTopAcnh, cityLabelTopConstraint])
                
        self.tempLabel.isHidden = labelViewMode == .hidden
        
        let height = -(self.navigationController?.navigationBar.frame.height ?? 0)
        
        descriptionLabelTopAcnh = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: labelViewMode == .shown ? tempLabel : cityLabel, attribute: .bottom, multiplier: 1, constant: labelViewMode == .shown ? 16 : 0)
        
        cityLabelTopConstraint = NSLayoutConstraint(item: cityLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: labelViewMode == .shown ? 0 : height)
                        
        view.addConstraints([descriptionLabelTopAcnh, cityLabelTopConstraint])
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
        var updatedDate = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "Ka"
        updatedDate = calendar.date(byAdding: .hour, value: indexPath.row, to: Date()) ?? Date()
        
        var labelText = "12AM"
        
        if indexPath.row == 0 {
            cell.timeLabel.text = "Now"
        } else {
            labelText = formatter.string(from: updatedDate)
            
            if formatter.string(from: updatedDate) == "0AM" {
                labelText = "12AM"
            } else if formatter.string(from: updatedDate) == "0PM" {
                labelText = "12PM"
            }
            
            let myMutableString = NSMutableAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)])
            
            if labelText.count == 4 {
                myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12, weight: .medium), range: NSRange(location: 2, length: 2))
                cell.timeLabel.attributedText = myMutableString
            } else {
                myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12, weight: .medium), range: NSRange(location: 1, length: 2))
                cell.timeLabel.attributedText = myMutableString
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height/2, height: collectionView.frame.height)
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = weatherTable.dequeueReusableCell(withIdentifier: String(describing: WeekForecastCell.self), for: indexPath) as! WeekForecastCell
            return cell
        case 1:
            let cell = weatherTable.dequeueReusableCell(withIdentifier: String(describing: ForecastDescriptionCell.self), for: indexPath) as! ForecastDescriptionCell
            return cell
        case 2...6:
            let cell = weatherTable.dequeueReusableCell(withIdentifier: String(describing: ForecastDetailsCell.self), for: indexPath) as! ForecastDetailsCell
            cell.data = createForecastDetails(for: indexPath)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    private func createForecastDetails(for indexPath: IndexPath) -> ForecastDetails? {
        switch indexPath.row {
        case 2:
            return .init(leftTitle: "SUNRISE", rightTitle: "SUNSET", leftDescription: "07:05", rightDescription: "07:05")
        case 3:
            return .init(leftTitle: "CHANCE OF RAIN", rightTitle: "HUMIDITY", leftDescription: "10%", rightDescription: "58%")
        case 4:
            return .init(leftTitle: "WIND", rightTitle: "FEELS LIKE", leftDescription: "s 3 km/hr", rightDescription: "3°")
        case 5:
            return .init(leftTitle: "PRECIPITATION", rightTitle: "PRESSURE", leftDescription: "0 cm", rightDescription: "1025 hPa")
        case 6:
            return .init(leftTitle: "VISIBILITY", rightTitle: "UV INDEX", leftDescription: "16.1 km", rightDescription: "0")
            
        default:
            return nil
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: self.weatherTable)
        if velocity.y < -500 {
            labelViewMode = .hidden
        } else if velocity.y > 500 {
            labelViewMode = .shown
        }
    }
}
