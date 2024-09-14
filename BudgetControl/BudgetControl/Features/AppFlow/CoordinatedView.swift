//
//  CoordinatedView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

/// Takes in a generic type T which conforms to our ``FlowCoordinator`` protocol and binds the navigationPath to the `NavigationStack`.
/// It also sets the coordinators rootView as the navigationStack’s content
struct CoordinatedView<FlowCoordinator: FlowCoordinatorProtocol>: View {
	private let coordinator: FlowCoordinator
	
	init(_ coordinator: FlowCoordinator) {
		self.coordinator = coordinator
	}
	
	var body: some View {
		@Bindable var navigationController = coordinator.navigationController
		NavigationStack(path: $navigationController.navigationPath) {
			coordinator.rootView
		}
		.alert(for: $navigationController.alertPath)
		.cover(for: $navigationController.coverPath)
		.sheet(for: $navigationController.sheetPath)
	}
}
