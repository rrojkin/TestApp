//
//  ForecastDetailsCell.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/17/22.
//

import UIKit

struct ForecastDetails {
    let leftTitle: String?
    let rightTitle: String?
    
    let leftDescription: String?
    let rightDescription: String?
}

class ForecastDetailsCell: UITableViewCell {
    
    var data: ForecastDetails? {
        didSet {
            leftTitleText.text = data?.leftTitle
            rightTitleText.text = data?.rightTitle
            
            leftDescriptionText.text = data?.leftDescription
            rightDescriptionText.text = data?.rightDescription
        }
    }
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftTitleText: UILabel = {
        let text = UILabel()
        text.text = "Title"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 13)
        text.textColor = .white.withAlphaComponent(0.5)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var rightTitleText: UILabel = {
        let text = UILabel()
        text.text = "Title"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 13)
        text.textColor = .white.withAlphaComponent(0.5)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var leftDescriptionText: UILabel = {
        let text = UILabel()
        text.text = "Description"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 28)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var rightDescriptionText: UILabel = {
        let text = UILabel()
        text.text = "Description"
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 28)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var viewDescriptionStack: UIStackView = {
        let viewDescriptionStack = UIStackView()
        viewDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
        viewDescriptionStack.axis = .horizontal
        viewDescriptionStack.distribution = .fillEqually
        viewDescriptionStack.contentMode = .scaleAspectFit
        viewDescriptionStack.alignment = .center
        return viewDescriptionStack
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "BlueBackground")
        setupView()
    }
    
    private func setupView() {
        self.addSubview(viewDescriptionStack)
        viewDescriptionStack.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        leftView.addSubviews(leftTitleText, leftDescriptionText)
        
        NSLayoutConstraint.activate([
            leftTitleText.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
            leftTitleText.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 5),
            leftTitleText.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -5),
            
            leftDescriptionText.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 5),
            leftDescriptionText.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -5),
            leftDescriptionText.topAnchor.constraint(equalTo: leftTitleText.bottomAnchor, constant: 5),
            leftDescriptionText.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -5)
        ])
        
        rightView.addSubviews(rightTitleText, rightDescriptionText)
        
        NSLayoutConstraint.activate([
            rightTitleText.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 5),
            rightTitleText.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 5),
            rightTitleText.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -5),
            
            rightDescriptionText.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 5),
            rightDescriptionText.bottomAnchor.constraint(equalTo: rightView.bottomAnchor, constant: -5),
            rightDescriptionText.topAnchor.constraint(equalTo: rightTitleText.bottomAnchor, constant: 5),
            rightDescriptionText.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -5)
        ])
        
        viewDescriptionStack.addArrangedSubview(leftView)
        viewDescriptionStack.addArrangedSubview(rightView)
    }
}
