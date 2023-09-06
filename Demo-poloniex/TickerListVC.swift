//
//  ViewController.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import UIKit
import SnapKit

class TickerListVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var timer: Timer?
    let tickerService = TickersService.shared
    var tickerNameList = [TickerName]()
    var oldTickerNameList = [TickerName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadTicker()
        startTimer()

    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTickerData), userInfo: nil, repeats: true)
    }
    
    @objc func updateTickerData() {
        loadTicker()
    }
    
    func setupViews() {
        navigationItem.title = "Tickers"
        tableView.backgroundColor = .lightGray
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(TickerListCell.self, forCellReuseIdentifier: TickerListCell.reuseId)
        tableView.register(TickerSectionHeader.self, forHeaderFooterViewReuseIdentifier: TickerSectionHeader.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func sortTickerList() {
        tickerNameList.sort {
            $0.priceCerrency < $1.priceCerrency
        }
    }
    
    func loadTicker() {
        
        tickerService.getTickets { [weak self] tickets in
            guard let self = self else { return }
            self.tickerNameList.removeAll()
            
            for key in tickets.tickers.keys {
                let components = key.split(separator: "_")
                let firstPartKey = String(components[0])
                let secondPartKey = String(components[1])
                if let value = tickets.tickers[key] {
                    
                    let tikersName = TickerName(currency: secondPartKey,highestprice: value.highestBid + " " + firstPartKey, price: value.last + " " + firstPartKey, percentChance: value.percentChange, priceCerrency: key)

                    self.tickerNameList.append(tikersName)
                }
                
            }
            self.sortTickerList()
            
            if self.oldTickerNameList.isEmpty {
                self.oldTickerNameList = self.tickerNameList
                self.tableView.reloadData()
                
            }else {
                var indexPaths = [IndexPath]()
                if self.tickerNameList.count == self.oldTickerNameList.count {
                    for (index, item) in self.tickerNameList.enumerated() {
                        let oldItem = self.oldTickerNameList[index]
                        if item.price != oldItem.price {
                            let indexPath = IndexPath(row: index, section: 0)
                            indexPaths.append(indexPath)
                        }
                    }
                }
                
                self.oldTickerNameList = self.tickerNameList
                self.tableView.reloadRows(at: indexPaths, with: .left)
            }
            
        } errorComletion: { error in
            print("Ошибка получения списка тикетов", error)
        }

    }
}

extension TickerListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickerNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TickerListCell.reuseId, for: indexPath)
        
        guard let tickerListCell = cell as? TickerListCell else {
            return cell
        }
        
        let index = indexPath.row
        
        let ticker = tickerNameList[index]
        
        setupCell(tickerListCell: tickerListCell, ticker: ticker)
        
        return tickerListCell
    }
    
    func setupCell(tickerListCell: TickerListCell, ticker: TickerName) {
        
        tickerListCell.currencyLabel.text = ticker.currency
        tickerListCell.highestpriceLabel.text = ticker.highestprice
        tickerListCell.priceLabel.text = ticker.price

        if let doubleValue = Double(ticker.percentChance) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            let formattedNumber = numberFormatter.string(from: NSNumber(value: doubleValue)) ?? ""

            let attributedString: NSAttributedString
            if doubleValue >= 0 {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.yellow, .font: UIFont.systemFont(ofSize: 18)
                ]
                attributedString = NSAttributedString(string: "+" + formattedNumber, attributes: attributes)
            } else {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 18)
                ]
                attributedString = NSAttributedString(string: formattedNumber, attributes: attributes)

            }
            tickerListCell.percentChanceLabel.attributedText = attributedString
        }
    }
}

extension TickerListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell =  tableView.dequeueReusableHeaderFooterView(withIdentifier: TickerSectionHeader.reuseId)
        
        guard let headerCell = cell as? TickerSectionHeader else { return cell }
        
        return headerCell
    }
}

