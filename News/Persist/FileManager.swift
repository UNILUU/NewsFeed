//
//  FileManager.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import Foundation

public extension FileManager {
    static var documentDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
