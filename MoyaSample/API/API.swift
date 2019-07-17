//
//  API.swift
//  MoyaSample
//
//  Created by 藤井陽介 on 2019/07/17.
//  Copyright © 2019 touyou. All rights reserved.
//

import Moya
import RxSwift

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

class Api {
    static let shared = Api()
    private let provider = MoyaProvider<MultiTarget>()

    func request<R>(_ request: R) -> Single<R.Response> where R: ApiTargetType {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(R.Response.self)
    }
}

protocol ApiTargetType: TargetType {
    associatedtype Response: Codable
}

extension ApiTargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var headers: [String : String]? { return nil }
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
}

enum GitHub {
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
