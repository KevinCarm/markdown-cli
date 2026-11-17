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
        let text = lines.joined(separator: "\n")
        let result = applyFormat(using: text)
        
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
        
        let markdownFile = markdownPath?.appending(path: "file.md")
        do {
            try result.write(
                to: markdownFile!,
                atomically: true,
                encoding: .utf8
            )
        }
    }
}
