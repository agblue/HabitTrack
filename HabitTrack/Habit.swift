//
//  Habit.swift
//  HabitTrack
//
//  Created by Danny Tsang on 9/26/23.
//

import Foundation

class HabitData: ObservableObject {
    @Published var habits: [Habit] {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }

    init() {
        if let habitItems = UserDefaults.standard.data(forKey: "habits") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: habitItems) {
                habits = decodedItems
                return
            }
        }
        habits = []
    }

    func increment(habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id}) else { return }
        habits[index].increment()
    }

    func decrement(habit: Habit) {
        guard habit.count > 0 else { return }
        guard let index = habits.firstIndex(where: { $0.id == habit.id}) else { return }
        habits[index].decrement()
    }

}

struct Habit: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var count: Int

    init(id: UUID = UUID(), name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
        self.count = 0
    }

    mutating func increment() {
        count += 1
    }

    mutating func decrement() {
        count -= 1
    }
}

