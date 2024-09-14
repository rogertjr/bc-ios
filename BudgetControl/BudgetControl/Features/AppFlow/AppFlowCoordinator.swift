//
//  AppFlowCoordinator.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation
import SwiftUI

protocol FlowCoordinatorProtocol: AnyObject {
	associatedtype Route: Codable, Hashable
	associatedtype Destination: View
	associatedtype RootView: View

	var navigationController: NavigationController { get }
	
	/// Method that navigates through the views/coordinators
	/// Wrapped in `@ViewBuilder` and `@MainActor` to ensure main thread updates
	/// Parameter route: An instance of a `View` type to navigate to
	/// Returns `Destination`
	@ViewBuilder @MainActor func coordinate(_ route: Route) -> Destination
	
	/// Holds a `View` instance of the root view
	@ViewBuilder @MainActor var rootView: RootView { get }
}
