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
	
	let coordinator: TabBarCoordinator
	
	var body: some View {
		@Bindable var coordinator = coordinator
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
