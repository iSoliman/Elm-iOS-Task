//
//  MethodTypeMapper.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Alamofire

enum MethodType: String {

    case get
    case post
    case put
    case delete
}

struct MethodTypeMapper {
    
    static func map(methodType: MethodType) -> HTTPMethod {

        switch methodType {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
}
