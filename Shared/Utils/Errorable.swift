//
//  Errorable.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import SwiftUI

struct ErrorModifier: ViewModifier {
    @Binding var error: String?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if let error {
                VStack(alignment: .center) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.headline)
                    Text(error)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

extension View {
    func errorable(error: Binding<String?>) -> some View {
        return modifier(ErrorModifier(error: error))
    }
}
