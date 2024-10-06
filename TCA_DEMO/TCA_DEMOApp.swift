//
//  TCA_DEMOApp.swift
//  TCA_DEMO
//
//  Created by Mouleaswar Shanmugam on 06/10/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_DEMOApp: App {
    var body: some Scene {
        WindowGroup {
            TimerAppView(
                store: .init(
                    initialState: TimerApp.State(),
                    reducer: {TimerApp()._printChanges()}
                )
            )
        }
    }
}
