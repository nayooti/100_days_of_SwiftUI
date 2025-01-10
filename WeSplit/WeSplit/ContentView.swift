import SwiftUI

struct ContentView: View {

    @State var totalMoneySpent = 0.0
    @State var peopleCount = 0
    var tipValue: Double {
        totalMoneySpent * (100 + Double(tipPercentage)) / 100
    }

    @State var tipPercentage = 20

    @FocusState var moneySpentFocused

    var tipPercentages = [5, 10, 20, 0]
    var result: Double {
        let spentByPerson = tipValue / Double(peopleCount + 2)
        return spentByPerson
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("How much did you spend?") {
                    TextField(
                        "Amount",
                        value: $totalMoneySpent,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .focused($moneySpentFocused)
                    .keyboardType(.decimalPad)
                }
                Section {
                    Picker("People", selection: $peopleCount) {
                        ForEach(2 ..< 10) {
                            Text("\($0)")
                        }
                    }
                }
                Section("How much do you want to tip?") {
                    Picker(
                        "Tip percentage",
                        selection: $tipPercentage
                    ) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Amount with Tip") {
                    Text(
                        tipValue,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }

                Section("Amount per person") {
                    Text(
                        result,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }
            }
            .toolbar {
                if moneySpentFocused {
                    Button("Done") {
                        moneySpentFocused = false
                    }
                }
            }
            .navigationTitle("SplitMe")
        }
    }
}

#Preview {
    ContentView()
}
