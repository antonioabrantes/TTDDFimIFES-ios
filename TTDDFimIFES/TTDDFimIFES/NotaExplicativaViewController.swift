//
//  NotaExplicativaViewController.swift
//  TTDDFimIFES
//
//  Created by Macintosh HD on 24/10/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import UIKit

struct DescricaoXmlCodClass {
    var id:Int
    var symbol:String
    var assunto:String
    var observacoes:String
}

class NotaExplicativaViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var textViewExplica1: UILabel!
    @IBOutlet weak var textViewExplica2: UILabel!
    
    var iclasses: String=String()
    var iassunto: String=String()
    var elementName: String = String()
    var descricao:[String]=[]
    var descricoes: [DescricaoXmlCodClass]=[]
    var id:  Int=Int()
    var symbol: String=String()
    var assunto: String=String()
    var observacoes: String=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textViewExplica1.text = iclasses+" "+iassunto
        textViewExplica1.numberOfLines = 0
        textViewExplica1.lineBreakMode = NSLineBreakMode.byWordWrapping

        textViewExplica2.numberOfLines = 0
        textViewExplica2.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        // Do any additional setup after loading the view.
        if let path = Bundle.main.url(forResource: "codclas", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate=self
                parser.parse()
            }
        }
    }
    
    // 1
     func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
         
         if elementName == "row" {
             id = Int()
             symbol = String()
             assunto = String()
             observacoes = String()
         }
         
         self.elementName = elementName
     }
     
     // 2
     func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
         if elementName == "row" {
             let row = DescricaoXmlCodClass(id: id, symbol: symbol, assunto: assunto, observacoes:observacoes)
             descricoes.append(row)
             if symbol==iclasses{
                 //print("parser "+String(grupo)+" "+String(assunto))
                 let corrigeAcentos = CorrigeAcentos(assunto: assunto)
                 assunto = corrigeAcentos.getCorrigeAcentos()
                 let corrigeAcentos2 = CorrigeAcentos(assunto: observacoes)
                 observacoes = corrigeAcentos2.getCorrigeAcentos()
                 textViewExplica2.text = observacoes
             }
         }
     }
     
     // 3
     func parser(_ parser: XMLParser, foundCharacters string: String) {
         let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
         
         if (!data.isEmpty) {
             if self.elementName == "id" {
                 id = Int(data) ?? 0
             } else if self.elementName == "symbol" {
                 symbol += data
             } else if self.elementName == "assunto" {
                 assunto += data
             } else if self.elementName == "observacoes" {
                 observacoes += data
             }
         }
         
     }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
