//
//  BudgetControlApp.swift
//  BudgetControl
//
//  Created by Rogério do Carmo Toledo Júnior on 05/06/24.
//

import SwiftUI
import SwiftData

@main
struct BudgetControlApp: App {
	// MARK: - Properties
	let tabBarCoordinator = TabBarCoordinator(session: SessionManager(), selectedTab: .dashboard)

	// MARK: - Layout
	var body: some Scene {
		WindowGroup {
			TabBarView(coordinator: tabBarCoordinator)
		}
	}
}
