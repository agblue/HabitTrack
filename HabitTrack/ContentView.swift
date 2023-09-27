//
//  ContentView.swift
//  HabitTrack
//
//  Created by Danny Tsang on 9/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = HabitData()
    @State private var showAddHabitView = false

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(data.habits) { habit in
                        NavigationLink {
                            HabitDetailView(data:data, habit: habit)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .lineLimit(1...1)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(habit.description)
                                        .lineLimit(1...1)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button() {
                                    decrementCount(habit: habit)
                                } label: {
                                    Image(systemName: "hand.thumbsdown")
                                }
                                .buttonStyle(.borderless)

                                Text("\(habit.count)")

                                Button() {
                                    incrementCount(habit: habit)
                                } label: {
                                    Image(systemName: "hand.thumbsup")
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                Button("Tap the + to add a new habit!") {
                    showAddHabitView = true
                }
                    .opacity(data.habits.count == 0 ? 1 : 0)
            }
            .navigationTitle("HabiTrack")
            .toolbar( content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        showAddHabitView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            })
            .sheet(isPresented: $showAddHabitView) {
                AddHabitView(habitData: data)
            }
        }
    }

    func decrementCount(habit: Habit) {
        data.decrement(habit: habit)
    }

    func incrementCount(habit: Habit) {
        data.increment(habit: habit)
    }

    func delete(indexSet: IndexSet) {
        data.habits.remove(atOffsets: indexSet)
    }

    func move(fromSet: IndexSet, offset: Int) {
        data.habits.move(fromOffsets: fromSet, toOffset: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
