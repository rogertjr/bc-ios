//
//  OnboardingView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

private extension CGFloat {
	static let yOffset: Self = 50
	static let buttonHeight: Self = 50
	static let buttonWidth: Self = 150
	static let buttonFontSize: Self = 20
	static let cornerRadius: Self = 10
}

private extension Double {
	static let delay: Self = 0.25
}

struct OnboardingView: View {
	// MARK: - Properties
	@ObservedObject private var manager = OnboardingManager()
	@State private var showButton = false
	let actionHandler: () -> Void
	
	// MARK: - Layout
	var body: some View {
		TabView {
			ForEach(manager.items) { item in
				OnboardingInfoView(item: item)
					.onAppear {
						if item == manager.items.last {
							withAnimation(.spring().delay(.delay)) {
								showButton = true
							}
						}
					}
					.overlay(alignment: .bottom) {
						if showButton {
							Button("Continue") {
								actionHandler()
							}
							.font(.system(size: .buttonFontSize,
										  weight: .bold,
										  design: .rounded))
							.frame(width: .buttonWidth, height: .buttonHeight)
							.foregroundColor(.black)
							.background(
								.white,
								in: RoundedRectangle(cornerRadius: .cornerRadius,
													 style: .continuous)
							)
							.offset(y: .yOffset)
							.transition(.scale.combined(with: .opacity))
							
						}
					}
			}
		}
		.tabViewStyle(.page)
		.indexViewStyle(.page(backgroundDisplayMode: .always))
		.task {
			manager.load()
		}
	}
}

// MARK: - Preview
#Preview {
	OnboardingView(actionHandler: {
		
	})
}
