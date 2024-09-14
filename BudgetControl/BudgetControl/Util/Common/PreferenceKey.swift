//
//  PreferenceKey.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

struct SheetFactoryKey: PreferenceKey {
	static var defaultValue: [String: NavigationViewFactory] = [:]
	static func reduce(value: inout [String: NavigationViewFactory],
					   nextValue: () -> [String: NavigationViewFactory]) {
		// reduce all into one value (dictionary)
		value.merge(nextValue()) { $1 }
	}
}

struct CoverFactoryKey: PreferenceKey {
	static var defaultValue: [String: NavigationViewFactory] = [:]
	static func reduce(value: inout [String: NavigationViewFactory],
					   nextValue: () -> [String: NavigationViewFactory]) {
		// reduce all into one value (dictionary)
		value.merge(nextValue()) { $1 }
	}
}
