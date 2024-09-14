//
//  TabBarView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

/// Wrapper for a `TabView` that sets each individual tab to a `CoordinatedView`
/// That receives the corresponding Coordinator from the tabBarCoordinator
struct TabBarView: View {
	// MARK: - Properties
	@EnvironmentObject var session: SessionManager
	let coordinator: TabBarCoordinator
	
	// MARK: - Layout
	var body: some View {
		@Bindable var coordinator = coordinator
		
		ZStack {
			switch session.currentState {
			case .onboarding:
				OnboardingView(actionHandler: session.completeOnboarding)
					.transition(.opacity)
			default:
				TabView(selection: $coordinator.selectedTab) {
					ForEach(self.coordinator.tabs, id: \.self) { tabItem in
						switch tabItem {
						case .dashboard:
							dashboardTabItem(tabItem)
						case .settings:
							settingsTabItem(tabItem)
						}
					}
				}
			}
		}
		.task {
			session.configureCurrentState()
		}
	}
}

private extension TabBarView {
	@ViewBuilder func dashboardTabItem(_ tabItem: TabItem) -> some View {
		CoordinatedView(coordinator.dashboardFlowCoordinator)
			.tabItem { itemContent(tabItem) }
			.tag(tabItem)
	}
	
	@ViewBuilder func settingsTabItem(_ tabItem: TabItem) -> some View {
		CoordinatedView(coordinator.settingsFlowCoordinator)
			.tabItem { itemContent(tabItem) }
			.tag(tabItem)
	}
	
	@ViewBuilder
	func itemContent(_ tabItem: TabItem) -> some View {
		VStack {
			Image(systemName: tabItem.imageName)
				.resizable()
				.renderingMode(.template)
				.aspectRatio(contentMode: .fit)
				.frame(width: 22, height: 22)
				.frame(maxWidth: .infinity)
			Text(tabItem.title)
		}
	}
}
