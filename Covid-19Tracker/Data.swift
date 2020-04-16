//
//  Data.swift
//  Covid-19Tracker
//
//  Created by Sarath Sasi on 08/04/20.
//  Copyright © 2020 XCoders. All rights reserved.
//

import Foundation


struct AllData: Codable, Identifiable {
    let id = UUID()
    var cases: Int
    var deaths: Int
    var recovered: Int
    
    init() {
        self.cases = 0
        self.deaths = 0
        self.recovered = 0
    }
}

struct Country: Codable, Identifiable {
    let id = UUID()
    var country: String
    var cases: Int
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var critical: Int
}

class CountriesDataApi {
    func getData(completion: @escaping ([Country]) -> ()) {
        guard let url = URL(string: "https://corona.lmao.ninja/countries") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let data = try! JSONDecoder().decode([Country].self, from: data!)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        .resume()
    }
    
}
