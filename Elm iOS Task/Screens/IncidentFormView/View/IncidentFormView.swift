//
//  IncidentFormView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import SwiftUI

enum IncidentFormViewMode {
    case edit(incident: Incident)
    case add
}

struct IncidentFormView: View {
    
    @ObservedObject private var viewModel: IncidentFormViewModel
    
    init(mode: IncidentFormViewMode) {
        switch mode {
        case .add:
            viewModel = AddIncidentViewModel()
        case .edit(let incident):
            viewModel = EditIncidentViewModel(incident: incident)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(viewModel.navigationTitle)) {
                    TextField("Incident Name", text: $viewModel.incidentDesc)
                        .disabled(viewModel.disableUpdate)
                    
                    TextField("Latitude", text: $viewModel.latitude)
                        .disabled(viewModel.disableUpdate)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $viewModel.longitude)
                        .disabled(viewModel.disableUpdate)
                        .keyboardType(.decimalPad)
                    
                    Picker("Status", selection: $viewModel.selectedStatus) {
                        ForEach(IncidentStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                }
                Section {
                    Button(action: viewModel.submitIncident) {
                        Text("Submit Incident")
                    }
                    .disabled(viewModel.shouldDisableSubmitButton)
                }
            }
            .navigationTitle(viewModel.submitButtonTitle)
            .errorAlert(isPresented: $viewModel.isShowingError, errorMessage: viewModel.errorMessage)
        }
    }
}

#Preview {
    IncidentFormView(mode: .add)
}
