//
//  VerifyOTPRequestBuilder.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

struct VerifyOTPRequestBuilder: RequestBuilder {

    //MARK: Internal
    var url = "/verify-otp"
    var params: [String : Any]?
    var methodType = MethodType.post
    var requiresAuthorization = false

    //MARK: Initializer
    init(otp: String, email: String) {
        params = [.emailKeyword: email, .otpKeyword: otp]
    }
}

fileprivate extension String {

    static let emailKeyword = "email"
    static let otpKeyword = "otp"
}
