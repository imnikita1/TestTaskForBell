//
//  Car.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import Foundation

struct Car: Codable {
    let consList: [String]
    let customerPrice: Double
    let make: String
    let marketPrice: Double
    let model: String
    let prosList: [String]
    let rating: Int
    var imageName: String?
}
