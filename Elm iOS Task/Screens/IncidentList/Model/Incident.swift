//
//  Incident.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

enum IncidentStatus: String, CaseIterable, Identifiable {

    var id: String { self.rawValue }

    case submitted = "Submitted"
    case inProgress = "In Progress"
    case completed = "Completed"
    case rejected = "Rejected"

    var statusNum: Int {
        switch self {
        case .submitted:
            return 0
        case .inProgress:
            return 1
        case .completed:
            return 2
        case .rejected:
            return 3
        }
    }
}

struct Incident: Codable, Identifiable {
    
    let id: String
    let description: String
    let status: Int
    let createdAt: String
    let updatedAt: String
    let latitude: Double
    let longitude: Double

    var statusText: IncidentStatus {
        if status == 0 {
            return .submitted
        } else if status == 1 {
            return .inProgress
        } else if status == 2 {
            return .completed
        } else {
            return .rejected
        }
    }
}

struct IncidentArrayResponse: Codable {

    var incidents: [Incident]
}
