//
//  SheetPath.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation

protocol SheetCoordinatorProtocol {
	var navigationController: NavigationController { get }
	func presentSheet(onDismiss: (() -> Void)?)
}

protocol SheetControllerProtocol {
	var sheetPath: SheetPath { get }
	func presentSheet<T>(_ route: T, onDismiss: (() -> Void)?)  where T: Codable & Identifiable & Hashable
}

struct SheetPath: Identifiable {
	var id: String { sheet?.id ?? UUID().uuidString }
	var sheet: SheetContainer?
	
	mutating func setSheet<T>(_ sheet: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable {
		self.sheet = SheetContainer(sheet, onDismiss: onDismiss)
	}
}

struct SheetContainer: Identifiable {
	let id: String
	let sheet: Any
	let onDismiss: (() -> Void)?
	
	init<T>(_ sheet: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable {
		// Use the data type we are working with as the identifier for the wrapper
		self.id = String(describing: T.self)
		self.sheet = sheet
		self.onDismiss = onDismiss
	}
}


