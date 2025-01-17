//
//  ContentView.swift
//  Project 1
//
//  Created by Aisosa Obasohan on 14/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var bills = 0.00
    @State private var numberOfPeople = 0
    @State private var tip = 20
    @FocusState private var isFocused: Bool
    
    
    let tips = [5, 10, 15, 20, 0]

    
    var totalBill: Double {
       ( bills *  Double(tip) / 100 ) + bills
    }
    
    
    var billPerPerson : Double {
            let peopleCount = Double(numberOfPeople + 2)
            let leaveTip = Double(tip)
            let payableAmount = bills * leaveTip / 100
            
            let finalBill = payableAmount + bills
            let billPerPerson = finalBill / peopleCount
            
            return billPerPerson
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value:$bills, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("No. of People", selection:$numberOfPeople) {
                        ForEach(2..<10) {items in
                            Text("\(items)")
                        }
                    }
                }
                
                
                Section ("You can leave a Tip!") {
                    Picker("Select", selection:$tip) {
                        ForEach(tips, id:\.self) {items in
                            Text(items, format:.percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                Section("Total bill") {
                    Text(totalBill, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                
                Section("Bill per person") {
                    Text(billPerPerson, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            
             
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}
    
    #Preview {
        ContentView()
    }

