//
//  EditIncidentRequestBuilder.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

struct EditIncidentRequestBuilder: RequestBuilder {

    var url = "/incident/change-status"
    var params: [String : Any]?
    var methodType = MethodType.put
    var requiresAuthorization = true
    
    init(incidentId: String, status: IncidentStatus) {
        params = [
            .incidentIdKey: incidentId,
            .statusKey: status.statusNum,
        ]
    }
}

fileprivate extension String {

    static let incidentIdKey = "incidentId"
    static let statusKey = "status"
}
