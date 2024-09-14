//
//  View+Ext.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

extension View {
	func alert(for alertPath: Binding<AlertPath>) -> some View {
		self.modifier(AlertModifier(alertPath: alertPath))
	}
	
	func sheetDestination<D,C>(for data: D.Type,
							   @ViewBuilder sheet: @escaping (D) -> C) -> some View where D: Identifiable & Hashable, C : View  {
		preference(key: SheetFactoryKey.self, value: [String(describing: data): NavigationViewFactory(data, sheet)])
	}
	
	func coverDestination<D,C>(for data: D.Type,
							   @ViewBuilder cover: @escaping (D) -> C) -> some View where D: Identifiable & Hashable, C : View  {
		preference(key: CoverFactoryKey.self, value: [String(describing: data): NavigationViewFactory(data, cover)])
	}
	
	func sheet(for sheetPath: Binding<SheetPath>) -> some View {
		modifier(SheetModifier(sheetPath: sheetPath))
	}
	
	func cover(for data: Binding<CoverPath>, onDismiss: (() -> Void)? = nil) -> some View {
		modifier(CoverModifier(data: data))
	}
}
