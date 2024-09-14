//
//  OnboardingSplashFlowCoordinator.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 14/09/24.
//

import Foundation
import SwiftUI

enum OnboardingSplashFlowCoordinatorRoute: Codable, Hashable, Identifiable {
	var id: String { String(describing: self) }
	
	case sheet
	case cover
}

protocol OnboardingSplashFlowCoordinatorProtocol: FlowCoordinatorProtocol,
												  AlertCoordinatorTrait,
												  CoverCoordinatorProtocol,
												  SheetCoordinatorProtocol {
	var navigationController: NavigationController { get }
	var rootView: RootView { get }
}

@Observable final class OnboardingSplashFlowCoordinator: OnboardingSplashFlowCoordinatorProtocol {
	typealias Route = OnboardingSplashFlowCoordinatorRoute
	
	weak var delegate: SettingsFlowCoordinatorDelegate?
	let navigationController: NavigationController
	private var sessionManager: SessionManager
	
	init(sessionManager: SessionManager,
		 navigationController: NavigationController = NavigationController()) {
		self.sessionManager = sessionManager
		self.navigationController = navigationController
	}
	
	@ViewBuilder
	var rootView: some View {
		OnboardingView(actionHandler: sessionManager.completeOnboarding)
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

extension OnboardingSplashFlowCoordinator {
	@ViewBuilder @MainActor
	func coordinate(_ route: Route) -> some View {
		switch route {
		case .sheet:
			Text("Sheet")
		case .cover:
			Text("Cover")
		}
	}
}
