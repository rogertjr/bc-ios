//
//  CoverPath.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation

protocol CoverCoordinatorProtocol {
	var navigationController: NavigationController { get }
	func presentCover(onDismiss: (() -> Void)?)
}

protocol CoverControllerProtocol {
	var coverPath: CoverPath { get }
	func presentCover<T>(_ route: T, onDismiss: (() -> Void)?)  where T: Codable & Identifiable & Hashable
}

struct CoverPath: Identifiable {
	var id: String { cover?.id ?? UUID().uuidString }
	var cover: CoverContainer?
	
	mutating func setCover<T>(_ cover: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable  {
		self.cover = CoverContainer(cover, onDismiss: onDismiss)
	}
}

struct CoverContainer: Identifiable {
	let id: String
	let cover: Any
	let onDismiss: (() -> Void)?
	
	init<T>(_ cover: T, onDismiss: (() -> Void)? = nil) where T: Codable & Identifiable & Hashable  {
		self.id = String(describing: T.self)
		self.cover = cover
		self.onDismiss = onDismiss
	}
}
