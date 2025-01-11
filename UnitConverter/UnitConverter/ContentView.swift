import SwiftUI

struct ContentView: View {

    @State var input: Int = 0
    @State var inputUnit: LengthUnit = .centimeter
    @State var outputUnit: LengthUnit = .centimeter
    var output: Double {
        let converter = Converter()
        return converter.convert(input, from: inputUnit, to: outputUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Length", value: $input, format: .number).keyboardType(.numberPad)
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) {
                            Text($0.description)
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Output") {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) {
                            Text($0.description)
                        }
                    }.pickerStyle(.segmented)
                    Text("\(output)")
                }
            }.navigationTitle("Length Converter")
        }
    }
}

#Preview {
    ContentView()
}

struct Converter {
    func convert(_ value: Int, from inputUnit: LengthUnit, to outputUnit: LengthUnit) -> Double {
        let inputValue = Double(value)

        let meters: Double
        switch inputUnit {
        case .centimeter:
            meters = inputValue / 100
        case .meter:
            meters = inputValue
        case .inch:
            meters = inputValue * 0.0254
        case .feet:
            meters = inputValue * 0.3048
        }

        switch outputUnit {
        case .centimeter:
            return meters * 100
        case .meter:
            return meters
        case .inch:
            return meters / 0.0254
        case .feet:
            return meters / 0.3048
        }
    }
}

enum LengthUnit: CaseIterable {
    case inch
    case feet
    case centimeter
    case meter

    var description: String {
        switch self {
        case .centimeter:
            return "cm"
        case .feet:
            return "ft"
        case .inch:
            return "in"
        case .meter:
            return "m"
        }
    }
}
