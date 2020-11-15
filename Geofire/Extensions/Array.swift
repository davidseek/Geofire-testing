//
//  Array.swift
//  Geofire
//
//  Created by David Seek on 11/15/20.
//

import Foundation

extension Array where Element: Equatable {

    mutating func remove(object: Element) {

        if let index = firstIndex(of: object) {

            remove(at: index)
        }
    }
}
