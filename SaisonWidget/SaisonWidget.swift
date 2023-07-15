//
//  SaisonWidget.swift
//  SaisonWidget
//
//  Created by David Tacite on 14/07/2023.
//

import WidgetKit
import SwiftUI
import SaisonData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    init() {
        Elements.shared.fillData()
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct FruitsWidgetEntryView : View {
    var entry: Provider.Entry

    @State var elements = [Element]()
    @State var fruits = [Element]()
    var body: some View {
        VStack(spacing: 10) {
            Text(getCurrentMonth(date: entry.date))
            if let fruit = fruits.randomElement() {
                Text(fruit.name)
            }
            if let fruit = fruits.randomElement() {
                Text(fruit.name)
            }
            if let fruit = fruits.randomElement() {
                Text(fruit.name)
            }
        }
        .onAppear {
            elements = Elements.shared.getElements()
            fruits = getFruits()
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
    
    private func getFruits() -> [Element] {
        let month = Calendar.current.component(.month, from: entry.date) - 1
        let fruits = elements.filter { element in
            return (element.type == .Fruit && element.months.contains(month))
        }
        return fruits
    }
    
    private func getCurrentMonth(date: Date) -> String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"

        let name = nameFormatter.string(from: date)
        return name
    }
}

struct VegetablesWidgetEntryView: View {
    var entry: Provider.Entry

    @State var elements = [Element]()
    @State var vegetable = [Element]()
    var body: some View {
        VStack(spacing: 10) {
            Text(getCurrentMonth(date: entry.date))
            if let vegetable = vegetable.randomElement() {
                Text(vegetable.name)
            }
            if let vegetable = vegetable.randomElement() {
                Text(vegetable.name)
            }
            if let vegetable = vegetable.randomElement() {
                Text(vegetable.name)
            }
        }
        .onAppear {
            elements = Elements.shared.getElements()
            vegetable = getVegetables()
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
    
    private func getVegetables() -> [Element] {
        let month = Calendar.current.component(.month, from: entry.date) - 1
        let vegetable = elements.filter { element in
            return (element.type == .Vegetable && element.months.contains(month))
        }
        return vegetable
    }
    
    private func getCurrentMonth(date: Date) -> String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"

        let name = nameFormatter.string(from: date)
        return name
    }
}

struct FruitsWidget: Widget {
    let kind: String = "FruitsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FruitsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Fruits de saison")
        .description("3 fruits de saisons")
        .supportedFamilies([.systemSmall])
    }
}

struct VegetablesWidget: Widget {
    let kind: String = "VegetableWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            VegetablesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Légumes de saison")
        .description("3 légumes de saisons")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    FruitsWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .distantFuture, emoji: "🤩")
}
