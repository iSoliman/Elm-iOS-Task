//
//  LoginResultBuilder.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

struct LoginResultBuilder: RequestBuilder {
    
    var url = "/login"
    var methodType = MethodType.post
    var params: [String: Any]?
    var requiresAuthorization = false
    
    init(username: String) {
        params = [.usernameKeyword: username]
    }
}

fileprivate extension String {
    static let usernameKeyword = "username"
}
