//
//  TickerSectionHeader.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import Foundation
import UIKit

class TickerSectionHeader: UITableViewHeaderFooterView {
    
    static let reuseId = String(describing: TickerSectionHeader.self)
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Currency"
        return label
    }()
    
    let highestpriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Highest price"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Price"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        

        [currencyLabel, highestpriceLabel, priceLabel].forEach(addSubview(_:))

        currencyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        highestpriceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
