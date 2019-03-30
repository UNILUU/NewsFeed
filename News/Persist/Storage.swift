//
//  Storage.swift
//  News
//
//  Created by Xiaolu Tian on 3/29/19.
//
import Foundation

public class Storage {
    
    fileprivate init() { }
    /// Returns URL constructed from specified directory
    static fileprivate func getURL(for directory: FileManager.SearchPathDirectory) -> URL {
        if let url = FileManager.default.urls(for: directory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    /// Store an encodable struct to the specified directory on disk
    static func store<T: Encodable>(_ object: T, to directory: FileManager.SearchPathDirectory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        do {
            let data = try JSONEncoder().encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            print(error)
        }
    }
    
    /// Retrieve and convert a struct from a file on disk
    static func retrieve<T: Decodable>(_ fileName: String, from directory: FileManager.SearchPathDirectory, as type: T.Type) -> T? {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) { return nil}
        if let data = FileManager.default.contents(atPath: url.path) {
            return try? JSONDecoder().decode(type, from: data)
        }
        return nil
    }
}
