//
//  Array+Only.swift
//  Memorize
//
//  Created by Brando Lugo on 12/3/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
