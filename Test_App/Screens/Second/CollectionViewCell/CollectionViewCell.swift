//
//  CollectionViewCell.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/10/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .white
        timeLabel.text = "12PM"
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = iconImages[Int.random(in: 0...iconImages.count-1)]
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let degreesLabel: UILabel = {
        let degreesLabel = UILabel()
        degreesLabel.textColor = .white
        degreesLabel.text = "\(Int.random(in: 0...12))°"
        degreesLabel.textAlignment = .center
        degreesLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false
        return degreesLabel
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var iconImages = [UIImage(named: "01d@2x"), UIImage(named: "02d@2x"), UIImage(named: "03d@2x"), UIImage(named: "04d@2x"), UIImage(named: "09d@2x"), UIImage(named: "10d@2x"), UIImage(named: "11d@2x"), UIImage(named: "13d@2x"), UIImage(named: "50d@2x")]

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubviews(containerView)
        containerView.fillSuperview()
        
        self.containerView.addSubviews(timeLabel, image, degreesLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
            image.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: degreesLabel.topAnchor, constant: 0),
            
            degreesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            degreesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            degreesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }
}
