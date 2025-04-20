//
//  FilterButton.swift
//  BaliBookEvents
//
//  Created by Saputra on 18/04/25.
//

import SwiftUI

import SwiftUI

struct FilterButton: View {
    var text : String
    @Binding var selectedFilter: String
    
    var body: some View {
            Button(text) {
                selectedFilter = text
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .foregroundStyle(selectedFilter == text ? .white : .black)
            .background(
                Group {
                    if selectedFilter == text {
                        Capsule().fill(Color.blue)
                    } else {
                        Capsule().stroke(Color.black, lineWidth: 1)
                    }
                }
            )
    }
}

#Preview {
    FilterButton(text: "Test", selectedFilter: .constant("All"))
}
