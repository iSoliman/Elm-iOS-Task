//
//  HomeViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {

    //MARK: Private
    private var networking: NetworkManager

    //MARK: Internal
    @Published var incidents = [Incident]()
    @Published var isShowingError = false
    var errorMessage = ""

    //MARK: Initializer
    init(networking: NetworkManager = NetworkManagerImp.shared) {
        self.networking = networking
    }

    func fetchIncidents() {
        Task {
            do {
                let requestBuilder = IncidentListRequestBuilder()
                let incidentList = try await networking.fetchData(IncidentArrayResponse.self, with: requestBuilder)
                await incidentListLoadedSuccessfully(incidentList)
            } catch {
                await handleError(error)
            }
        }
    }

    @MainActor
    private func incidentListLoadedSuccessfully(_ incidentList: IncidentArrayResponse) {
        incidents = incidentList.incidents
    }
}

extension HomeViewModel: ErrorAlertType { }
