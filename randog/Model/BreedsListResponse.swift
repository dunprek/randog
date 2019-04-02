//
//  BreedsListResponse.swift
//  randog
//
//  Created by Gideon Steven Tobing on 02/04/19.
//  Copyright © 2019 Gideon. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String:[String]]
}
