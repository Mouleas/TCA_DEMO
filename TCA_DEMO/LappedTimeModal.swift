//
//  LapInfo.swift
//  TCA_DEMO
//
//  Created by Mouleaswar Shanmugam on 06/10/24.
//

import SwiftUI
import ComposableArchitecture

struct LappedTimeModal: Reducer {
    struct State: Equatable {
        var lappedTime: Int?
    }

    enum Action: Equatable {
        case deleteLap
    }

    var body: some ReducerOf<LappedTimeModal> {
        Reduce { state, action in
            return .none
        }
    }
}

