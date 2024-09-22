//
//  IncidentListViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

final class IncidentListViewModel: ObservableObject {

    //MARK: Private
    private let allIncidents: [Incident]

    //MARK: Interrnal
    @Published var presentedIncidents: [Incident]

    //MARK: Initializer
    init(allIncidents: [Incident]) {
        self.allIncidents = allIncidents
        presentedIncidents = allIncidents
    }

    func filter(by status: IncidentStatus?) {
        guard let status = status else {
            presentedIncidents = allIncidents
            return
        }
        presentedIncidents = allIncidents.filter { $0.statusText == status }
    }
}

