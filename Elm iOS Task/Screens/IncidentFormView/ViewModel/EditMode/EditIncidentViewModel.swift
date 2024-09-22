//
//  EditIncidentViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

class EditIncidentViewModel: IncidentFormViewModel {

    //MARK: Private
    private let incident: Incident

    //MARK: Internal
    override var navigationTitle: String { "Incident Update" }
    override var submitButtonTitle: String { "Edit Status" }
    override var disableUpdate: Bool { true }
    override var shouldDisableSubmitButton: Bool { incident.statusText == selectedStatus }

    //MARK: Initializer
    init(incident: Incident, networking: NetworkManager = NetworkManagerImp.shared) {
        self.incident = incident
        super.init(networking: networking)
        incidentDesc = incident.description
        selectedStatus = incident.statusText
        longitude = "\(incident.longitude)"
        latitude = "\(incident.latitude)"
    }

    override func submitIncident() {
        Task {
            let requestBuilder = EditIncidentRequestBuilder(incidentId: incident.id, status: selectedStatus)
            do {
                _ = try await networking.fetchData(Incident.self, with: requestBuilder)
            } catch {
                await handleError(error)
            }
        }
    }
}
