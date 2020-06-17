//
//  ContentView.swift
//  NGSystemColorComparison
//
//  Created by Noah Gilmore on 6/9/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import SwiftUI

extension Color {
    init(uiColor: UIColor) {
        self.init(red: Double(uiColor.red), green: Double(uiColor.green), blue: Double(uiColor.blue))
    }
}

struct ContentView : View {
    @Environment(\.colorScheme) var colorScheme // will reload this view on colorScheme changes
    @State private var isShowingModal = false

    let colors: [SystemColor]
    var isModal = false

    var body: some View {
        NavigationView {
            List(colors, id: \.name) { color in
                HStack {
                    Color(uiColor: color.color)
                        .frame(width: 30, height: 30)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(color.name)
                        HStack {
                            Text(color.hexDescription)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarItems(trailing: HStack {
                if !self.isModal {
                    Button("Modal") {
                        self.isShowingModal.toggle()
                    }
                }
            })
        }
        .sheet(isPresented: self.$isShowingModal, content: { ContentView(colors: self.colors, isModal: true) })
    }


}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(colors: SystemColor.colors)
        }
    }
}
#endif
