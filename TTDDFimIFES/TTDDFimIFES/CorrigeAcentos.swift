//
//  CorrigeAcentos.swift
//  TTDDFimIFES
//
//  Created by Macintosh HD on 24/10/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import Foundation

class CorrigeAcentos{
    var assunto: String
    init(assunto: String){
        self.assunto = assunto
    }
    func getCorrigeAcentos() -> String {
        assunto = assunto.replacingOccurrences(of: "MÔ", with: "M Ô")
        assunto = assunto.replacingOccurrences(of: "TESÀ", with: "TES À")
        assunto = assunto.replacingOccurrences(of: "OÓ", with: "O Ó")
        assunto = assunto.replacingOccurrences(of: "COMÓ", with: "COM Ó")
        assunto = assunto.replacingOccurrences(of: "AÀ", with: "A À")
        return assunto
    }
}
