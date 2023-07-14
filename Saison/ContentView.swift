//
//  ContentView.swift
//  Saison
//
//  Created by David Tacite on 14/07/2023.
//

import SwiftUI
import SaisonData

struct ContentView: View {
    @State private var currentMonth: Int = 0
    @State private var date: Date = Date()
    @State private var elements = [Element]()
    
    let columns = [ GridItem(.flexible()), GridItem(.flexible()),
                    GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        List {
            Section {
                Text(getCurrentMonth(date:date))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.largeTitle)
            }
            .listRowBackground(Color.clear)
            Section(header: Text("Fruit")) {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: columns, spacing: 10) {
                        ForEach(elements) { element in
                            Text(element.name)
                        }
                    }
                }
                .padding(.bottom, 10)
            }
            .listRowBackground(Color.clear)
            Section(header: Text("légume")) {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: columns, spacing: 10) {
                        ForEach(elements) { element in
                            Text(element.name)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .listRowBackground(Color.clear)
            Section {
                HStack(alignment: .center) {
                    Button("Previous month") {
                        date = date.getPreviousMonth()
                        currentMonth = getCurrentMonth(date: date)
                    }
                    .font(.callout)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.custom)
                    .foregroundStyle(.black)
                    .cornerRadius(15)
                    .buttonStyle(BorderlessButtonStyle())
                    Button("Next month") {
                        date = date.getNextMonth()
                        currentMonth = getCurrentMonth(date: date)
                    }
                    .font(.callout)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.custom)
                    .foregroundStyle(.black)
                    .cornerRadius(15)
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .listRowBackground(Color.clear)

        }
        .background(Color.yellow)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.never)
        .onAppear {
            Elements.shared.fillData()
            elements = Elements.shared.getElements()
            currentMonth = getCurrentMonth(date: date)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    private func isA(typeFood: FoodType, element: Element) -> Bool {
        let test: [Int] = element.months
        return(test.contains(currentMonth) && element.type == typeFood)
    }

    private func getCurrentMonth(date: Date) -> String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"

        let name = nameFormatter.string(from: date)
        return name
    }
    
    private func getCurrentMonth(date: Date) -> Int {
        return Calendar.current.component(.month, from: date) - 1
    }

}

extension Date {
    func getNextMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }

    func getPreviousMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
}
