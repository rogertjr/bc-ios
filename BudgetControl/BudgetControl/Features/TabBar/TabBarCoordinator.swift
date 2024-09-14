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

@Observable final class TabBarCoordinator {
	let dashboardFlowCoordinator = DashboardFlowCoordinator()
	let settingsFlowCoordinator = SettingsFlowCoordinator()
	let tabs: [TabItem] = TabItem.allCases
	var selectedTab: TabItem = .dashboard
}

extension TabBarCoordinator: DashboardFlowCoordinatorDelegate, SettingsFlowCoordinatorDelegate {
	func selectTab(_ tab: TabItem) {
		selectedTab = tab
	}
	
	func didFinish() { }
}
