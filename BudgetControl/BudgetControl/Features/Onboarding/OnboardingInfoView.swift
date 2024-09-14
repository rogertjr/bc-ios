//
//  OnboardingInfoView.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

private extension CGFloat {
	static let emojiSize: Self = 150
	static let titleFontSize: Self = 35
	static let contentFontSize: Self = 18
	static let titleBottomPadding: Self = 12
}

struct OnboardingInfoView: View {
	// MARK: - Properties
	let item: OnboardingItem
	
	// MARK: - Layout
	var body: some View {
		VStack(spacing: .zero) {
			Text(item.emoji)
				.font(.system(size: .emojiSize))
			
			Text(item.title)
				.font(.system(size: .titleFontSize,
							  weight: .heavy,
							  design: .rounded))
				.padding(.bottom, .titleBottomPadding)
			
			Text(item.content)
				.font(.system(size: .contentFontSize,
							  weight: .light,
							  design: .rounded))
		}
		.multilineTextAlignment(.center)
		.foregroundColor(.black)
		.padding()
	}
}

// MARK: - Preview
#Preview {
	OnboardingInfoView(item: OnboardingItem.onboardingFlow.first!)
		.background(Color.white)
}
