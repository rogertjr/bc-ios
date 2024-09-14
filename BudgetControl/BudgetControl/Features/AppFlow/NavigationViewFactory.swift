//
//  NavigationViewFactory.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation
import SwiftUI

/// PreferenceKey's onChange value must be equatable so we conform to Equatable protocol
struct NavigationViewFactory: Equatable {
	let id: String
	let factory: (Any) -> AnyView
	
	init<D,C>(_ type: D.Type, @ViewBuilder _ factory: @escaping (D) -> C) where D: Identifiable, C: View {
		// We save a string representation of the type as the identifier of the factory.
		self.id = String(describing: type)
		self.factory = { value in
			// This scope is the only scope with information on both the data.Type and the view.Type.
			// So to ensure the data.Type is valid we cast the data from Any and call our closure with the data in it.
			if let value = value as? D {
				AnyView(factory(value))
			} else {
				// If we fail the casting we provide the same warning icon that navigationDestination does
				AnyView(Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow))
			}
		}
	}
	
	static func == (lhs: NavigationViewFactory, rhs: NavigationViewFactory) -> Bool { lhs.id == rhs.id }
}
