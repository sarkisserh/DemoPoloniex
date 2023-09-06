//
//  TiketsService.swift
//  Demo-poloniex
//
//  Created by macbook on 23.07.2023.
//

import Foundation

enum TickersServiceError: Error {
    case unknown
    case noData
}

class TickersService {
    
    static let shared = TickersService()
    
    private init() {}
    
    private let baseUrl = "https://poloniex.com"

    func getTickets(successCompletion: @escaping (TickersResponse) -> Void, errorComletion: @escaping (Error) -> Void) {
        
        guard let url = URL(string:  baseUrl + "/public?command=returnTicker") else {
            DispatchQueue.main.async {
                errorComletion(TickersServiceError.unknown)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    errorComletion(error)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorComletion(TickersServiceError.noData)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tickers = try decoder.decode(TickersResponse.self, from: data)
                DispatchQueue.main.async {
                    successCompletion(tickers)
                }
            }catch{
                print("error", error)
                
                DispatchQueue.main.async {
                    errorComletion(error)
                }
            }
        }
        task.resume()
    }
    
}
