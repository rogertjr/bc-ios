//
//  AlertModifier.swift
//  BudgetControl
//
//  Created by Rogério Toledo on 13/09/24.
//

import SwiftUI

struct AlertModifier: ViewModifier {
	
	@Binding var alertPath: AlertPath
	
	init(alertPath: Binding<AlertPath>) {
		self._alertPath = alertPath
	}
	
	func body(content: Content) -> some View {
		content
			.alert(
				alertPath.alert?.title ?? "",
				isPresented: Binding(get: { alertPath.alert != nil }, set: { _ in alertPath.alert = nil }),
				actions: {
					if let buttons = alertPath.alert?.buttons {
						ForEach(buttons) { button in
							Button(button.title, role: button.role, action: button.action)
						}
					}
					
				}, message: {
					if let message = alertPath.alert?.message {
						Text(message)
					}
				})
	}
}


struct AlertFactory: AlertDisplayable {
	var title: String = "Some specific alert title"
	var message: String? = "Some other specific message"
	var buttons: [AlertButton]
	
	enum SomeAlert: AlertDisplayable {
		case alert(buttons: [AlertButton])
		case alertWithTitleAndMessage(buttons: [AlertButton])
		
		var title: String {
			switch self {
			case .alert:                        
				return "Alert with just title"
			case .alertWithTitleAndMessage:     
				return "Alert with title and message"
			}
		}
		
		var message: String? {
			switch self {
			case .alert:
				return nil
			case .alertWithTitleAndMessage: 
				return "This is the message"
			}
		}
		
		var buttons: [AlertButton] {
			switch self {
			case .alert(let buttons),
					.alertWithTitleAndMessage(let buttons):
				return buttons
			}
		}
	}

	init(onAction: @escaping () -> Void, onCancel: @escaping () -> Void) {
		self.buttons = [
			.actionButton(title: "Action Secondary", action: onAction),
			.cancelButton(title: "Action Cancel", action: onCancel)
		]
	}
}
