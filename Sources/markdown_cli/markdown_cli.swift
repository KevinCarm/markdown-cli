// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

@main
struct markdown_cli: ParsableCommand {
    
    static let configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Read multiline text"
    )
    
    @Flag(name: .shortAndLong, help: "Show received text")
    var vervose = false
    
    func run() throws {
        var lines: [String] = []
        
        while let line = readLine(strippingNewline: true) {
            lines.append(line)
        }
        
        let homePath = getHome()
        let markdownPath = homePath?.appending(path: "markdown")
        let exists = existsDirectory(using: (markdownPath!))
        if !exists {
            let fileManager = FileManager()
            do {
                try fileManager.createDirectory(
                    atPath: markdownPath!.relativePath,
                    withIntermediateDirectories: true)
            } catch {
                print("Error during creating /Documents/markdown directory: \(error)")
            }
        }
        
        /*let markdownFile = markdownPath?.appending(path: "file.md")
        do {
            try lines.joined(separator: "\n").write(
                to: markdownFile!,
                atomically: true,
                encoding: .utf8
            )
        } */
    }
    
    
    private func getHome() -> URL? {
        let home = FileManager.default.homeDirectoryForCurrentUser
        #if os(macOS)
        if #available(macOS 13.0, *) {
            return home.appending(path: "Documents")
        } else {
            return home.appendingPathComponent("Documents")
        }
        #elseif os(Linux)
        return home.appendingPathComponent("Documents")
        #else
        fatalError("Platform no found")
        #endif
    }
}
