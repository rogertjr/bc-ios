//
//  SettingsViewModel.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation

protocol SettingsViewModelProtocol {
	var coordinator: (any SettingsFlowCoordinatorProtocol)? { get }
	func displayAlert()
}

@Observable final class SettingsViewModel: SettingsViewModelProtocol {
	weak var coordinator: (any SettingsFlowCoordinatorProtocol)?
	
	init(coordinator: SettingsFlowCoordinator?) {
		self.coordinator = coordinator
	}
	
	func displayAlert() {
		coordinator?.presentAlert(
			AlertFactory.SomeAlert.alert(buttons: [
				.actionButton(title: "Action Primary") {
					print("action pressed")
				},
				.destructiveButton(title: "Action Cancel") {
					print("cancel pressed")
				}
			])
		)
	}
}
