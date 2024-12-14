//
//  ActionInputField.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct ActionInputField: View {
    @Binding var form: ActionInputForm
    
    var body: some View {
        HStack {
            Text(form.title)
            
            TextField(form.selection.placeholder, text: $form.value)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .onChange(of: form.value) { oldValue, newValue in
                    guard newValue.last != "." else { return }
                    
                    let string = newValue.replacingOccurrences(of: ",", with: "")
                    form.value = string.formattedNumber
                }
            
            Picker("", selection: $form.selection) {
                ForEach(form.inputTypes, id: \.self) { type in
                    Text(type.abbr)
                }
            }
            .frame(width: 72, alignment: .trailing)
            .tint(Color.primary)
        }
    }
}

#Preview {
    ActionInputField(form: .constant(ActionInputForm(fieldType: .currentEXP)))
}
