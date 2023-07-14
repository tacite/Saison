//
//  ElementView.swift
//  Saison
//
//  Created by David Tacite on 14/07/2023.
//

import SwiftUI
import SaisonData

struct ElementView: View {
    @State var element: Element
    var body: some View {
        HStack {
            Text(element.name)
                .bold()
            Spacer()
            Text(element.emoji)
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

#Preview {
    ElementView(element: Element(name: "Pomme", months: [4, 5], type: .Fruit, emoji: "🍏", local: true))
}
