//
//  OnboardingManager.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import Foundation

protocol OnboardingManagerProtocol: ObservableObject {
	var items: [OnboardingItem] { get set }
	func load()
}

final class OnboardingManager: ObservableObject {
	// MARK: - Properties
	var items: [OnboardingItem] = OnboardingItem.onboardingFlow
	
	// MARK: - Fetch
	func load() { }
}
