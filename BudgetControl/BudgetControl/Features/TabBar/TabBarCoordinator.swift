//
//  TabBarCoordinator.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation
import SwiftUI

enum TabItem: Hashable, CaseIterable {
	case dashboard
	case settings
	
	var title: String {
		switch self {
		case .dashboard:
			return "Dashboard"
		case .settings:
			return "Settings"
		}
	}
	
	var imageName: String {
		switch self {
		case .dashboard:
			return "chart.pie.fill"
		case .settings:
			return "gearshape.fill"
		}
	}
}

protocol TabBarCoordinatorProtocol {
	var session: SessionManager { get }
	var onboardingSplashFlowCoordinator: any FlowCoordinatorProtocol { get }
	var dashboardFlowCoordinator: any FlowCoordinatorProtocol { get }
	var settingsFlowCoordinator: any FlowCoordinatorProtocol { get }
	var tabs: [TabItem] { get }
	var selectedTab: TabItem { get }
	func onboardingSplashDidFinish()
}

@Observable final class TabBarCoordinator {
	let session: SessionManager
	let onboardingSplashFlowCoordinator: OnboardingSplashFlowCoordinator
	let dashboardFlowCoordinator: DashboardFlowCoordinator
	let settingsFlowCoordinator: SettingsFlowCoordinator
	let tabs: [TabItem]
	var selectedTab: TabItem = .dashboard
	
	init(session: SessionManager, tabs: [TabItem] = TabItem.allCases, selectedTab: TabItem) {
		self.session = session
		self.onboardingSplashFlowCoordinator = OnboardingSplashFlowCoordinator(sessionManager: session)
		self.dashboardFlowCoordinator = DashboardFlowCoordinator()
		self.settingsFlowCoordinator = SettingsFlowCoordinator()
		self.tabs = tabs
		self.selectedTab = selectedTab
	}
	
	func onboardingSplashDidFinish() {
		session.completeOnboarding()
	}
}

extension TabBarCoordinator: DashboardFlowCoordinatorDelegate, SettingsFlowCoordinatorDelegate {
	func selectTab(_ tab: TabItem) {
		selectedTab = tab
	}
	
	func didFinish() { }
}
