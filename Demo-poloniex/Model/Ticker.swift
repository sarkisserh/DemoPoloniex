//
//  Ticker.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import Foundation

struct Ticker: Decodable {
    
    let id: Int
    let last: String
    let lowestAsk: String
    let highestBid: String
    let percentChange: String
    let baseVolume: String
    let quoteVolume: String
    let isFrozen: String
    let postOnly: String
    let high24hr: String
    let low24hr: String
}
