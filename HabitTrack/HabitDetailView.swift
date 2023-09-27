//
//  HabitDetailView.swift
//  HabitTrack
//
//  Created by Danny Tsang on 9/26/23.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var data: HabitData
    @Environment(\.dismiss) var dismiss

    @State var habit: Habit
    @State private var showDeleteAlert: Bool = false

    var body: some View {
        VStack {
            Spacer()
            Text(habit.name)
                .font(.largeTitle)
                .padding(.bottom)
            Text(habit.description)
                .padding(.bottom, 50)

            HStack {
                Spacer()
                Button() {
                    decrement()
                } label: {
                    Image(systemName: "hand.thumbsdown")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                Spacer()
                Text("\(habit.count)")
                    .font(.largeTitle)
                Spacer()

                Button() {
                    increment()
                } label: {
                    Image(systemName: "hand.thumbsup")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Spacer()
            }
            Spacer()
            Spacer()
            Button("Delete Habit", role: .destructive) {
                showDeleteAlert = true
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .alert("Delete?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteHabit()
            }
        } message: {
            Text("Are you sure you want to delete this habit?")
        }
    }

    private func increment() {
        data.increment(habit: habit)
        if let updatedHabit = data.habits.first(where: { $0.id == habit.id }) {
            habit = updatedHabit
        }
    }

    private func decrement() {
        data.decrement(habit: habit)
        if let updatedHabit = data.habits.first(where: { $0.id == habit.id }) {
            habit = updatedHabit
        }
    }

    private func deleteHabit() {
        guard let index = data.habits.firstIndex(where: { $0.id == habit.id }) else { return }
        data.habits.remove(at: index)
        dismiss()
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let habitData = HabitData()
        let habit = Habit(name: "Sample", description: "This is a test habit")
        HabitDetailView(data: habitData, habit: habit)
    }
}
