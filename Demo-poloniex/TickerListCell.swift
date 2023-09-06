//
//  TickerListCell.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import Foundation
import UIKit
import SnapKit

class TickerListCell: UITableViewCell {
    
    static let reuseId = String(describing: TickerListVC.self)
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let highestpriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
       return label
    }()
    
    let percentChanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    var tabCallback: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGray2
        [currencyLabel, highestpriceLabel, priceLabel, percentChanceLabel].forEach(addSubview(_:))
        
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.top.equalToSuperview().inset(20)
        }
        
        highestpriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(currencyLabel.snp.trailing).offset(10)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.top.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(highestpriceLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().inset(20)
        }
        
        percentChanceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        currencyLabel.text = nil
        highestpriceLabel.text = nil
        priceLabel.text = nil
        percentChanceLabel.text = nil
    }
}
