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
	let tabBarCoordinator = TabBarCoordinator()
	@StateObject private var session = SessionManager()

	// MARK: - Layout
    var body: some Scene {
        WindowGroup {
			TabBarView(coordinator: tabBarCoordinator)
				.environmentObject(session)
        }
    }
}
