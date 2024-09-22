//
//  IncidentFormViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import Foundation

class IncidentFormViewModel: ObservableObject {

    //MARK: Internal
    var navigationTitle: String  { "" }
    var submitButtonTitle: String  { "" }
    var disableUpdate: Bool  { false }
    var shouldDisableSubmitButton: Bool { true }
    var networking: NetworkManager
    var errorMessage: String = ""

    @Published var incidentDesc = ""
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var selectedStatus = IncidentStatus.submitted
    @Published var isShowingError = false

    //MARK: Initializer
    init(networking: NetworkManager = NetworkManagerImp.shared) {
        self.networking = networking
    }

    func submitIncident() { fatalError("This Method should always be overriden") }
}

extension IncidentFormViewModel:  ErrorAlertType { }
