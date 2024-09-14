//
//  DashboardViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation

protocol DashboardViewModelProtocol {
	var coordinator: (any DashboardFlowCoordinatorProtocol)? { get }
	func didTapButton()
}

@Observable class DashboardViewModel: DashboardViewModelProtocol {
	
	weak var coordinator: (any DashboardFlowCoordinatorProtocol)?
	
	init(coordinator: DashboardFlowCoordinator) {
		self.coordinator = coordinator
	}
	
	func didTapButton() {
		coordinator?.presentSheet(onDismiss: {
			print("was dismissed")
		})
	}
}
