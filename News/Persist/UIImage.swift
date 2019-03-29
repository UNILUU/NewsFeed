//
//  UIImage.swift
//  News
//
//  Created by Xiaolu Tian on 3/28/19.
//

import Foundation
import UIKit
extension UIImage {
    
//    static func getImageCachesDirectory(name: String) -> UIImage? {
//        return UIImage(contentsOfFile:FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(name).appendingPathExtension("jpg").path)
//    }
//
//    func save(directory: FileManager.SearchPathDirectory, name: String) throws {
//        let kindDirectoryURL = URL( fileURLWithPath: "", relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
//        do {
//            try self.jpegData(compressionQuality:0.7)?.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("jpg"),options: .atomic)
//        }catch{
//            print(error)
//        }
//        try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: true)
//        try self.jpegData(compressionQuality:0.7)?.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("jpg"),options: .atomic)
    
//    static func getPNGFromDocumentDirectory(name: String) -> UIImage? {
//        return UIImage(contentsOfFile:FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(name).appendingPathExtension("jpg").path
//        )
//    }
//
//    func save(directory: FileManager.SearchPathDirectory, name: String) throws {
//        let kindDirectoryURL = URL( fileURLWithPath: "", relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
//
////        try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: true)
//
//        try self.jpegData(compressionQuality:0.7)?.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("jpg"),options: .atomic)
//    }

        
        static func getImageFrom(directory: FileManager.SearchPathDirectory, name: String) -> UIImage? {
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            return UIImage(contentsOfFile: url.appendingPathComponent(name).appendingPathExtension("jpg").path)
        }
        
        func save(directory: FileManager.SearchPathDirectory, name: String) throws {
            let kindDirectoryURL = URL( fileURLWithPath: "", relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
            do {
                if let data = self.jpegData(compressionQuality:0.7){
                    let name = kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("jpg")
                    try data.write(to: name)
                }
            } catch{
                print("error saving file:", error)
            }
        }
    
}
