//
//  SettingsFlowCoordinator.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation
import SwiftUI

enum SettingsFlowCoordinatorRoute: Codable, Hashable, Identifiable {
	var id: String { String(describing: self) }
	
	case profile
	case sheet
	case cover
}

protocol SettingsFlowCoordinatorDelegate: AnyObject {
	func selectTab(_ tab: TabItem)
	func didFinish()
}

protocol SettingsFlowCoordinatorProtocol: FlowCoordinatorProtocol,
										  AlertCoordinatorTrait,
										  CoverCoordinatorProtocol,
										  SheetCoordinatorProtocol {
	var delegate: SettingsFlowCoordinatorDelegate? { get set }
	var navigationController: NavigationController { get }
	var rootView: RootView { get }
	func goToProfile()
}

@Observable final class SettingsFlowCoordinator: SettingsFlowCoordinatorProtocol {
	typealias Route = SettingsFlowCoordinatorRoute
	
	weak var delegate: SettingsFlowCoordinatorDelegate?
	let navigationController: NavigationController
	
	init(navigationController: NavigationController = NavigationController()) {
		self.navigationController = navigationController
	}
	
	@ViewBuilder
	var rootView: some View {
		SettingsView(viewModel: SettingsViewModel(coordinator: self))
			.navigationDestination(for: Route.self, destination: coordinate(_:))
			.sheetDestination(for: Route.self, sheet: coordinate(_:))
			.coverDestination(for: Route.self, cover: coordinate(_:))
	}
	
	func presentCover(onDismiss: (() -> Void)? = nil) {
		navigationController.presentCover(Route.cover, onDismiss: onDismiss)
	}
	
	func presentSheet(onDismiss: (() -> Void)? = nil) {
		navigationController.presentSheet(Route.sheet, onDismiss: onDismiss)
	}
}

extension SettingsFlowCoordinator {
	func goToProfile() {
		navigationController.push(Route.profile)
	}
	
	@ViewBuilder @MainActor
	func coordinate(_ route: Route) -> some View {
		switch route {
		case .profile:
			Text("Profile")
		case .sheet:
			Text("Sheet")
		case .cover:
			Text("Cover")
		}
	}
}

