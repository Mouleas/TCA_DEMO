//
//  LapInfoSheet.swift
//  TCA_DEMO
//
//  Created by Mouleaswar Shanmugam on 06/10/24.
//

import ComposableArchitecture
import SwiftUI

struct LappedTimeModalView: View {
    let store: Store<LappedTimeModal.State, LappedTimeModal.Action>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Lapped Time: \(viewStore.lappedTime) seconds")
                    .font(.largeTitle)
                    .padding()

                Button("Delete Item") {
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 20)
            .frame(width: 300, height: 200)
        }
    }
}

