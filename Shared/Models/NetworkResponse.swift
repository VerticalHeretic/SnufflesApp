//
//  NetworkResponse.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

struct NetworkResponse<Object: Decodable>: Decodable {
    let info: Info
    let results: [Object]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
