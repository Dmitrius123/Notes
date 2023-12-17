//
//  AddView.swift
//  Notes
//
//  Created by Дмитрий Куприянов on 7.12.23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Фактура", "Джобни"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Наименование", text: $name)
                Picker("Тип", selection: $type){
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Цена", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Добави")
            .navigationBarItems(trailing: Button("Запази") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amoun: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
