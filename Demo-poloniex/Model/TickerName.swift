//
//  TickerName.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import Foundation

struct TickerName: Decodable {
    
    let currency: String
    let highestprice: String
    let price: String
    let percentChance: String
    let priceCerrency: String
   
}
