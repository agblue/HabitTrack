//
//  AddHabitView.swift
//  HabitTrack
//
//  Created by Danny Tsang on 9/26/23.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habitData: HabitData

    @State private var name = ""
    @State private var description = ""
    @FocusState private var nameIsFocused: Bool

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $name)
                        .focused($nameIsFocused)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    addNewHabit()
                }
            }
            .onAppear {
                nameIsFocused = true
            }
        }
    }

    func addNewHabit() {
        guard name != "" && description != "" else { return }
        let habit = Habit(name: name, description: description)
        habitData.habits.append(habit)
        dismiss()
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        let data = HabitData()
        AddHabitView(habitData: data)
    }
}
