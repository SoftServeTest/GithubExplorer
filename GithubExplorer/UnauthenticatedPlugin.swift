//
//  UnauthenticatedPlugin.swift
//  GithubExplorer
//
//  Created by Vladyslav Brylinskyi on 06/12/16.
//  Copyright © 2016 BVS. All rights reserved.
//

import Foundation
import Moya
import Result

public final class UnauthenticatedPlugin: PluginType {
    public func didReceiveResponse(_ result: Result<Moya.Response, Moya.Error>, target: TargetType) {
        
        switch result {
        case let .success(response):
            if response.statusCode == 401 {
                self.presentLoginView()
            }
        default:
            break
        }
    }
        
    func presentLoginView() {
        let controller = UIApplication.shared.keyWindow?.rootViewController
        guard let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        controller?.present(loginViewController, animated: true, completion: nil)
    }
}
