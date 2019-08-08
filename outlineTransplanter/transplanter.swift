// 
//  transplanter.swift
//  outlineTransplanter
//
//  Created by Mitsuhiro Daimon on 2019/08/09.
//
//

import Quartz


func transplant(reference rpath: URL, document dpath: URL) throws {
    
    guard let reference = PDFDocument(url: rpath) else {
        throw TransplantError.invalidArgument(rpath)
    }
    
    guard let document = PDFDocument(url: dpath) else {
        throw TransplantError.invalidArgument(dpath)
    }
    
    document.outlineRoot = reference.outlineRoot
    
    
    guard document.write(to: dpath) else {
        throw TransplantError.failToWrite(dpath)
    }
}


enum TransplantError: Error {
    
    case invalidArgument(URL)
    case failToWrite(URL)
}
