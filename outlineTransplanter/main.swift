// 
//  main.swift
//  outlineTransplanter
//
//  Created by Mitsuhiro Daimon on 2019/08/09.
//
//

import SPMUtility
import Foundation

let parser = ArgumentParser(usage: "<donor> <recipent>", overview: "copy outline data of a PDF to anoter PDF.")
let reference = parser.add(positional: "donor", kind: PathArgument.self, usage: "PDF which contains outline data.", completion: .filename)
let document = parser.add(positional: "recipient", kind: PathArgument.self, usage: "PDF to write outline data.", completion: .filename)

do {
    let arguments = try parser.parse(Array(ProcessInfo.processInfo.arguments.dropFirst()))
    
    if let reference = arguments.get(reference), let document = arguments.get(document) {
        
        try transplant(reference: reference.path.asURL, document: document.path.asURL)
    }
} catch let TransplantError.failToWrite(url) {
    print("Unable to overwrite to \(url.path)")
    exit(1)
} catch let TransplantError.invalidArgument(url) {
    print("\(url.lastPathComponent) is not a valid PDF")
    exit(1)
} catch let error as ArgumentParserError {
    print(error.description)
    exit(1)
} catch {
    print(error.localizedDescription)
    exit(1)
}
