//
//  DashboardFlowCoordinator.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation
import SwiftUI

enum DashboardFlowTabCoordinatorRoute: Codable, Hashable, Identifiable {
	var id: String { String(describing: self) }
	
	case overview
	case secondDetailView(String)
	case sheet
	case cover
}

protocol DashboardFlowCoordinatorDelegate: AnyObject {
	func selectTab(_ tab: TabItem)
	func didFinish()
}

protocol DashboardFlowCoordinatorProtocol: FlowCoordinatorProtocol,
										   AlertCoordinatorTrait,
										   CoverCoordinatorProtocol,
										   SheetCoordinatorProtocol {
	var delegate: DashboardFlowCoordinatorDelegate? { get set }
	var navigationController: NavigationController { get }
	var rootView: RootView { get }
	func goToOverviewPage()
	func goToSecondDetailView(with string: String)
}

@Observable final class DashboardFlowCoordinator:  DashboardFlowCoordinatorProtocol {
//	var settingsCoordinator: (any SettingsFlowCoordinatorProtocol)?
	typealias Route = DashboardFlowTabCoordinatorRoute
	
	weak var delegate: DashboardFlowCoordinatorDelegate?
	let navigationController: NavigationController
	
	init(navigationController: NavigationController = NavigationController()) {
		self.navigationController = navigationController
	}
	
	@ViewBuilder
	var rootView: some View {
		DashboardView(viewModel: DashboardViewModel(coordinator: self))
			.navigationDestination(for: Route.self, destination: coordinate(_:))
			.sheetDestination(for: Route.self, sheet: coordinate(_:))
			.coverDestination(for: Route.self, cover: coordinate(_:))
	}
	
	func presentSheet(onDismiss: (() -> Void)? = nil) {
		navigationController.presentSheet(Route.sheet, onDismiss: onDismiss)
	}
	
	func presentCover(onDismiss: (() -> Void)? = nil) {
		navigationController.presentCover(Route.cover, onDismiss: onDismiss)
	}
}

extension DashboardFlowCoordinator {
	// example of triggering other coordinators
//	func goToSettings() {
//		settingsCoordinator = SettingsFlowCoordinator(navigationController: navigationController)
//		settingsCoordinator?.delegate = self
//		navigationController.push(Route.overview)
//	}
	
	func goToOverviewPage() {
		navigationController.push(Route.overview)
	}
	
	func goToSecondDetailView(with string: String) {
		navigationController.push(Route.secondDetailView(string))
	}
	
	@ViewBuilder @MainActor
	func coordinate(_ route: Route) -> some View {
		switch route {
		case .overview:
			Text("Overview")
			
		case .secondDetailView(_):
			Text("Second Detail")
			
//		 case .settings:
//			settingsCoordinator?.rootView
		case .sheet:
			Text("Sheet")
				.presentationDetents([.medium])
		case .cover:
			Text("Cover")
		}
	}
}
