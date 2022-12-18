//
//  FirstViewController.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/10/22.
//

import UIKit
import Moya
import Moya_ObjectMapper

class CitiesListViewController: UIViewController {

    var cities = [
        City(name: "Warsaw", lat: 52.237049, long: 21.017532, temp: 16),
        City(name: "Bucharest", lat: 44.439663, long: 26.096306, temp: 16),
        City(name: "Martuni", lat: 40.1377, long: 45.3045, temp: 16),
        City(name: "Shah Alam", lat: 3.09060700, long: 101.52959690, temp: 16),
        City(name: "Palermo", lat: 38.116669, long: 13.366667, temp: 16),
        City(name: "Budapest", lat: 47.497913, long: 19.040236, temp: 16),
        City(name: "Munich", lat: 48.137154, long: 11.576124, temp: 16),
        City(name: "Netivot", lat: 31.42319500, long: 34.59525500, temp: 16),
        City(name: "Santa Cruz de la Sierra", lat: -17.7863, long: -63.1812, temp: 16),
        City(name: "Porto Alegre", lat: -30.033056, long: -51.230000, temp: 16),
    ]
    
    var filterText = ""
    var filteredCities: [City] {
        filterText.isEmpty ? cities : cities.filter { $0.name.lowercased().contains(filterText.lowercased()) }
    }
        
    let weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.textAlignment = .left
        weatherLabel.text = "Weather"
        weatherLabel.font = UIFont.boldSystemFont(ofSize: 36)
        weatherLabel.textColor = UIColor(named: "TextColor")
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherLabel
    }()
    
    let coverUpView: UIView = {
        let coverUpView = UIView()
        coverUpView.backgroundColor = UIColor(named: "BackgroundColor")
        coverUpView.alpha = 1
        coverUpView.isHidden = false
        coverUpView.translatesAutoresizingMaskIntoConstraints = false
        return coverUpView
    }()
        
    lazy var cityTableView: UITableView = {
        let cityTableView = UITableView()
        cityTableView.backgroundColor = UIColor(named: "BackgroundColor")
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.translatesAutoresizingMaskIntoConstraints = false
        return cityTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefresh(refreshControl:)), for: .valueChanged)
                
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        cityTableView.register(UINib(nibName: String(describing: WeatherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeatherTableViewCell.self))
        
        refreshControl.tintColor = .white
        cityTableView.refreshControl = refreshControl
                
        view.addSubviews(coverUpView, weatherLabel, cityTableView)
        
        view.bringSubviewToFront(coverUpView)

        setupConstraints()
        
        getData(cities: cities, completion: { complete in
            if complete {
                self.cityTableView.reloadData()
                self.coverUpView.isHidden = true
            }
        })
    }
    
    func setupConstraints() {
        coverUpView.fillSuperview()
        
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            weatherLabel.heightAnchor.constraint(equalToConstant: 50),
            
            cityTableView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            cityTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            cityTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            cityTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func pullRefresh(refreshControl: UIRefreshControl) {
        print("Time to refresh!")
        getData(cities: cities, completion: { complete in
            refreshControl.endRefreshing()
            if complete {
                self.cityTableView.reloadData()
                self.coverUpView.isHidden = true
            }
            
            print("complete")
        }, pullRefresh: true)
    }
    
    private func getData(cities: [City], completion: ((Bool) -> ())?, pullRefresh: Bool = false) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .gmt
        
        for city in cities {
            NetworkManager.getWeather(lat: city.lat, lon: city.long, success: { weather in
                var fetchedCity = City(name: city.name, lat: city.lat, long: city.long, temp: weather.temp ?? 0.0)
                fetchedCity.icon = weather.weatherInfo?[0].icon
                fetchedCity.time = dateFormatter.string(from: Date().advanced(by: weather.timeZone ?? 0))
                
                if let cityIndex = cities.firstIndex(where: { $0.name == city.name }) {
                    self.cities[cityIndex] = fetchedCity
                }
                
                if cities.last?.name == city.name {
                    completion?(true)
                }
            }, failure: nil)
        }
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Search" : "Cities"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = SecondViewController(nibName: String(describing: SecondViewController.self), bundle: nil)
        secondVC.cityLabel.text = cities[indexPath.row].name
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: String(describing: WeatherTableViewCell.self), for: indexPath) as! WeatherTableViewCell
        
        if indexPath.section == 1 {
            cell.locationLabel.text = filteredCities[indexPath.row].name
            cell.temperatureLabel.text = "\(Int(filteredCities[indexPath.row].temp))°"
            cell.iconImage.image = UIImage(named: "\(filteredCities[indexPath.row].icon ?? "01d@2x")")
            cell.timeLabel.text = filteredCities[indexPath.row].time ?? "12:00"
            cell.cellType = .cityCell
            cell.setUpView(cellType: cell.cellType)
        } else {
            cell.cellType = .searchCell
            cell.setUpView(cellType: cell.cellType)

            cell.updateTableview = { text in
                self.filterText = text
                self.cityTableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
        }
        
        return cell
    }
}



