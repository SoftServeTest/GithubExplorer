//
//  GithubService.swift
//  GithubExplorer
//
//  Created by Vladyslav Brylinskyi on 05/12/16.
//  Copyright © 2016 BVS. All rights reserved.
//

import Moya

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let endpointClosure = { (target: GithubService) -> Endpoint<GithubService> in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(target)

    if let username = storage.name, let password = storage.password {
        let authString =  username + ":" + password
        let data = authString.data(using: .ascii)
        let authValue = "Basic " + data!.base64EncodedString()
        return defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": authValue])
    } else {
        return defaultEndpoint
    }
}

let provider = MoyaProvider<GithubService>(endpointClosure: endpointClosure ,plugins:[NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter), UnauthenticatedPlugin()])

enum GithubService {
    case user
    case repos
    case createRepo(name: String)
}

extension GithubService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .user:
            return "/user"
        case .repos:
            return "/user/repos"
        case .createRepo(_):
            return "/user/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .user, .repos:
            return .get
        case .createRepo(_):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .user, .repos:
            return nil
        case .createRepo(let name):
            return ["name": name]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .user, .repos, .createRepo(_):
            return "Test data here".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .user, .repos, .createRepo(_):
            return .request
        }
    }
}
