//
//  IncidentListRequestBuilder.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

struct IncidentListRequestBuilder: RequestBuilder {

    var url = "/incident?startDate=2021-11-14"
    var params: [String : Any]?
    var methodType = MethodType.get
    var requiresAuthorization = true
}

fileprivate extension String {

    static let startDateKey = "startDate"
}
