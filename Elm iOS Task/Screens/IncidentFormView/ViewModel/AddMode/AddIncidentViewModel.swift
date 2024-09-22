//
//  AddIncidentViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

final class AddIncidentViewModel: IncidentFormViewModel {

    override var navigationTitle: String { "Incident Details" }
    override var submitButtonTitle: String { "Submit Incident" }
    override var disableUpdate: Bool { false }
    override var shouldDisableSubmitButton: Bool { incidentDesc.isEmpty || latitude.isEmpty || longitude.isEmpty } 

    //MARK: Internal Functions
    override func submitIncident() {
        Task {
            let resultBuilder = AddIncidentRequestBuilder(
                desc: incidentDesc,
                latitude: latitude,
                longitude: longitude,
                status: selectedStatus)
            do {
                _ = try await networking.fetchData(IncidentArrayResponse.self, with: resultBuilder)
                await incidentSubmittedSuccessfully()
            } catch {
                await handleError(error)
            }
        }
    }

    //MARK: Private Functions
    @MainActor
    private func incidentSubmittedSuccessfully() {
        incidentDesc = ""
        latitude = ""
        longitude = ""
        selectedStatus = .submitted
    }
}
