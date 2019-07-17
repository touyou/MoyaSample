//
//  Profile.swift
//  MoyaSample
//
//  Created by 藤井陽介 on 2019/07/17.
//  Copyright © 2019 touyou. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct Profile: Codable {
    let login: String
    let url: URL
    let name: String?
    let email: String?
}

extension GitHub {
    struct GetUserProfile: ApiTargetType {
        typealias Response = Profile

        var method: Moya.Method { return .get }
        var path: String { return "/users/\(name.urlEscaped)" }
        var task: Task { return .requestPlain }
        let name: String

        init(name: String) {
            self.name = name
        }
    }
}
