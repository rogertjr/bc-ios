//
//  SettingsView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {
	let viewModel: ViewModel
	
    var body: some View {
        Text("Settings View")
		Button("Present alert") {
			viewModel.displayAlert()
		}
		.padding(.top)
    }
}

#Preview {
	SettingsView(viewModel: SettingsViewModel(coordinator: SettingsFlowCoordinator()))
}
