//
//  NavigationController.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

protocol NavigationControllerProtocol {
	func push<T>(_ route: T) where T: Codable & Hashable
	func presentAlert<T>(_ alert: T) where T: AlertDisplayable
	func dismiss()
}


protocol AlertControllerProtocol {
	var alertPath: AlertPath { get }
	func presentAlert<T>(_ alert: T) where T: AlertDisplayable
}

@Observable final class NavigationController: NavigationControllerProtocol,
											  AlertControllerProtocol,
											  CoverControllerProtocol,
											  SheetControllerProtocol {
	var navigationPath: NavigationPath = .init()
	var alertPath: AlertPath = .init()
	var coverPath: CoverPath = .init()
	var sheetPath: SheetPath = .init()
	///
	/// Parameter route: A generic type to append into the current navigation path
	func push<T>(_ route: T) where T: Codable & Hashable {
		navigationPath.append(route)
	}
	
	///
	/// Parameter alert: A generic alert type to be presented
	func presentAlert<T>(_ alert: T) where T: AlertDisplayable {
		alertPath.setAlert(alert)
	}
	
	/// Pop the last path item
	/// If the nagivation path is empty, doesn't do anything
	func dismiss() {
		guard !navigationPath.isEmpty else { return }
		navigationPath.removeLast()
	}
	
	func presentSheet<T>(_ route: T, onDismiss: (() -> Void)? = nil)  where T: Codable & Identifiable & Hashable {
		sheetPath.setSheet(route, onDismiss: onDismiss)
	}
	
	func presentCover<T>(_ route: T, onDismiss: (() -> Void)? = nil)  where T: Codable & Identifiable & Hashable {
		coverPath.setCover(route, onDismiss: onDismiss)
	}
}
