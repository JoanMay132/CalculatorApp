//
//  buttonStyles.swift
//  edutainmentApp
//
//  Created by Joan May on 16/10/24.
//

import SwiftUI

extension View {
    public func newGameButton() -> some View {
        self
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
    
    public func settingsButton() -> some View {
        self
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

