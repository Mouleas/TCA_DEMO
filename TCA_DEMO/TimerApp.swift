//
//  TimerApp.swift
//  TCA_DEMO
//
//  Created by Mouleaswar Shanmugam on 06/10/24.
//
import ComposableArchitecture

struct TimerApp: Reducer {
    @Dependency(\.continuousClock) var clock
    
    struct State: Equatable {
        var isTimerRunning = false
        var secondsElapsed = 0
        var savedTimers = [Int]()
        @PresentationState var lappedTimeModal: PresentationState<LappedTimeModal.State>?
    }
    
    enum Action: Equatable {
        case startTimerTapped
        case stopTimerTapped
        case timerTicked
        case lapTapped(Int)
    }
    
    var body: some ReducerOf<TimerApp> {
        Reduce { state, action in
            switch action {
            case .startTimerTapped:
                state.isTimerRunning = true
                return .run { send in
                    for await _ in clock.timer(interval: .seconds(1)) {
                        await send(.timerTicked)
                    }
                }
                .cancellable(id: Cancellables.Timer, cancelInFlight: true)
                
            case .stopTimerTapped:
                state.isTimerRunning = false
                state.secondsElapsed = 0
                return .cancel(id: Cancellables.Timer)
                
            case .timerTicked:
                state.secondsElapsed += 1
                return .none
                
            case .lapTapped(let time):
                state.savedTimers.append(time)
                return .none
            }
        }
    }
}

private enum Cancellables: Hashable {
    case Timer
}
