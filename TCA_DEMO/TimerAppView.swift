//
//  File.swift
//  TCA_DEMO
//
//  Created by Mouleaswar Shanmugam on 06/10/24.
//

import SwiftUI
import ComposableArchitecture

struct TimerAppView: View {
    let store: StoreOf<TimerApp>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                VStack {
                    Text(String(viewStore.secondsElapsed))
                        .font(.system(size: 64, weight: .bold))
                        .padding()
                    
                    HStack {
                        Button(action: {
                            if viewStore.isTimerRunning {
                                viewStore.send(.stopTimerTapped)
                            } else {
                                viewStore.send(.startTimerTapped)
                            }
                        }) {
                            Text(viewStore.isTimerRunning ? "Stop" : "Start")
                                .font(.title)
                                .padding()
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .background(viewStore.isTimerRunning ? Color.red : Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        if viewStore.isTimerRunning {
                            Button(action: {viewStore.send(.lapTapped(viewStore.secondsElapsed))}, label: {
                                Text("Lap")
                                    .font(.title)
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            })
                        }
                       
                    }
                    .padding()
                }
                
                Spacer()
                List(viewStore.savedTimers, id: \.self) { item in
                    Text("Lapped time: \(item)s")
                        .font(.headline)
                        .padding()
                }
                
            }
        }
        
        
    }
}
