import SwiftUI

struct ContentView: View {

    @State var moneySpent = 0.0
    @State var peopleCount = 0
    @State var tipPercentage = 20
    var tipPercentages = [5, 10, 20, 0]
    var result: Double {
        let spentWithTip = moneySpent / 100 * (100 + Double(tipPercentage))
        let spentByPerson = spentWithTip / Double(peopleCount + 2)
        return spentByPerson
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("How much did you spend?") {
                    TextField(
                        "Amount",
                        value: $moneySpent,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    ).keyboardType(.decimalPad)
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
                    }.pickerStyle(.segmented)
                }
                Section("Split per person") {
                    Text(
                        result,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }
            }.navigationTitle("SplitMe")
        }
    }
}

#Preview {
    ContentView()
}
