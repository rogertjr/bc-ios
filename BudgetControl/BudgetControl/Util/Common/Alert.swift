//
//  Alert.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

protocol AlertCoordinatorTrait {
	var navigationController: NavigationController { get }
	func presentAlert<T>(_ alert: T) where T: AlertDisplayable
}

extension AlertCoordinatorTrait {
	func presentAlert<T>(_ alert: T) where T: AlertDisplayable {
		navigationController.presentAlert(alert)
	}
}

protocol AlertDisplayable {
	var title: String { get }
	var message: String? { get }
	var buttons: [AlertButton] { get }
}

struct AlertPath {
	var alert: AlertDisplayable?
	
	mutating func setAlert<T>(_ alert: T) where T: AlertDisplayable {
		self.alert = alert
	}
}

struct AlertButton: Identifiable {
	let id = UUID()
	let title: String
	let role: ButtonRole?
	let action: () -> Void
	
	private init(title: String, role: ButtonRole?, action: @escaping () -> Void) {
		self.title = title
		self.role = role
		self.action = action
	}
	
	static func actionButton(title: String, action: @escaping () -> Void) -> Self {
		AlertButton(title: title, role: nil, action: action)
	}
	
	static func cancelButton(title: String, action: @escaping () -> Void) -> Self {
		AlertButton(title: title, role: .cancel, action: action)
	}
	
	static func destructiveButton(title: String, action: @escaping () -> Void) -> Self {
		AlertButton(title: title, role: .destructive, action: action)
	}
}
