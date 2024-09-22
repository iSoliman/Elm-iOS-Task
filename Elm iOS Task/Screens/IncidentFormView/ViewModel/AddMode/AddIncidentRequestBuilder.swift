//
//  AddIncidentRequestBuilder.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

struct AddIncidentRequestBuilder: RequestBuilder {

    var url = "/incident"
    var params: [String : Any]?
    var methodType = MethodType.post
    var requiresAuthorization = true
    
    init(desc: String, latitude: String, longitude: String, status: IncidentStatus) {
        params = [
            .descriptionKey: desc,
            .issuerIdKey: "af698686-7470-499b-a745-765e89b3c4b4",
            .statusKey: status.statusNum,
            .typeIdKey: 24
        ]
        if let latitude = Double(latitude) {
            params?[.latitudeKey] = latitude
        }
        if let longitude = Double(longitude) {
            params?[.longitudeKey] = longitude
        }
    }
}

fileprivate extension String {

    static let descriptionKey = "description"
    static let latitudeKey = "latitude"
    static let longitudeKey = "longitude"
    static let statusKey = "status"
    static let typeIdKey = "typeId"
    static let issuerIdKey = "issuerId"
}
