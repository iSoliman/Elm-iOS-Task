//
//  RequestBuilder.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

protocol RequestBuilder {

    var url: String { get }
    var params: [String: Any]? { get }
    var methodType: MethodType { get }
    var requiresAuthorization: Bool { get }
}
