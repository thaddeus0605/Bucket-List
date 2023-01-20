//
//  FileManager-DocumentsDirectory.swift
//  Bucket List
//
//  Created by Thaddeus Dronski on 1/19/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
