//
//  ActionInputForm.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import Foundation

struct ActionInputForm {
    var title: String
    var value: String
    var inputTypes: [ActionInputType]
    var selection: ActionInputType
    
    init(fieldType: InputFieldType) {
        title = fieldType.title
        value = ""
        inputTypes = fieldType.selections
        selection = fieldType.selections.first!
    }
}
