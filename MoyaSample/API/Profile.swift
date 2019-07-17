//
//  Profile.swift
//  MoyaSample
//
//  Created by 藤井陽介 on 2019/07/17.
//  Copyright © 2019 touyou. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let login: String
    let url: URL
    let name: String?
    let email: String?
}
