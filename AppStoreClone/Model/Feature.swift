//
//  Feature.swift
//  AppStore
//
//  Created by Eunyeong Kim on 2021/08/10.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
