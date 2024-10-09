//
//  TimerApp.swift
//  TCA_DEMO
//
//  Created by Mouleaswar Shanmugam on 06/10/24.
//
import ComposableArchitecture
import Foundation


struct TimerRecord: Equatable, Identifiable {
    let id: UUID
    let lapTime: Int

    init(id: UUID, lapTime: Int) {
        self.id = id
        self.lapTime = lapTime
    }
}


struct TimerApp: Reducer {
    @Dependency(\.continuousClock) var clock
    
    struct State: Equatable {
        var isTimerRunning = false
        var secondsElapsed = 0
        var savedTimers = IdentifiedArrayOf<TimerRecord>()
        @PresentationState var lappedTimeModal: LappedTimeModal.State?
    }
    
    enum Action: Equatable {
        case startTimerTapped
        case stopTimerTapped
        case timerTicked
        case lapTapped(Int)
        case lapRecordTapped(id : TimerRecord.ID)
        case lappedTimeModal(PresentationAction<LappedTimeModal.Action>)
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
                let newTimerRecord = TimerRecord(id: UUID(), lapTime: time)
                state.savedTimers.append(newTimerRecord)
                return .none
            case .lapRecordTapped(let id):
                if let selectedTimer = state.savedTimers[id: id] {
                    let modalState = LappedTimeModal.State(lappedTime: selectedTimer.lapTime)
                    state.lappedTimeModal =  modalState
                }
                return .none
            case .lappedTimeModal:
                return .none
            }
        }
        .ifLet(\.$lappedTimeModal, action: /Action.lappedTimeModal) {
            LappedTimeModal()
        }
    }
}

private enum Cancellables: Hashable {
    case Timer
}
