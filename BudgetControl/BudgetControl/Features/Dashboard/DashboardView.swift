//
//  DashboardView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
	let viewModel: ViewModel
	
    var body: some View {
		VStack {
			Text("Dash view")
			Button("Go to overview") {
				viewModel.didTapButton()
			}
			.padding(.top)
		}
    }
}

#Preview {
	DashboardView(viewModel: DashboardViewModel(coordinator: DashboardFlowCoordinator()))
}
