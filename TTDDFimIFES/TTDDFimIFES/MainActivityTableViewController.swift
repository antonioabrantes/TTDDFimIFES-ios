//
//  MainActivityTableViewController.swift
//  TTDD
//
//  Created by Macintosh HD on 07/10/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

struct DescricaoXml {
    var id:Int
    var grupo:String
    var kind:String
    var assunto:String
    var fase_corrente:String
    var fase_intermediaria:String
    var destinacao:String
    var observacoes:String
    var indice:Int
    var proximo:Int
}


class MainActivityTableViewController: UITableViewController, XMLParserDelegate {
    
    var descricoes: [DescricaoXml]=[]
    //var elementName: String=String()
    var id:  Int=Int()
    var grupo: String=String()
    var kind: String=String()
    var assunto: String=String()
    var fase_corrente: String=String()
    var fase_intermediaria: String=String()
    var destinacao: String=String()
    var observacoes: String=String()
    var indice: Int=Int()
    var proximo: Int=Int()
    var proxima_tela: Int = 0
    var count_proximo: Int = 0
    var texto: String = ""
    var array_texto = [String]()
    var array_proximo = [Int]()
    var array_classes = [String]()
    var array_assunto = [String]()
    var array_fase_corrente = [String]()
    var array_fase_intermediaria = [String]()
    var array_destinacao = [String]()
    var array_observacoes = [String]()
    var elementName: String = String()

    
    var descricao:[String]=[ "100 — ENSINO SUPERIOR",
                             "200 — PESQUISA",
                             "300 — EXTENSÃO",
                             "400 — EDUCAÇÃO BÁSICA E PROFISSIONAL",
                             "500 — ASSISTÊNCIA ESTUDANTIL"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "kind", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate=self
                parser.parse()
            }
            
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "row" {
            id = Int()
            grupo = String()
            kind = String()
            assunto = String()
            fase_corrente = String()
            fase_intermediaria = String()
            destinacao = String()
            observacoes = String()
            indice = Int()
            proximo = Int()
        }
        
        self.elementName = elementName
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if elementName == "row" {
            let row = DescricaoXml(id: id, grupo:grupo, kind: kind, assunto:assunto, fase_corrente:fase_corrente, fase_intermediaria: fase_intermediaria,
                                   destinacao:destinacao,observacoes:observacoes,indice:indice,proximo:proximo)
            descricoes.append(row)
            if indice==proxima_tela{
                array_proximo.append(proximo)
                array_classes.append(grupo)
                array_assunto.append(assunto)
                texto = grupo + " " + assunto
                array_texto.append(texto)
                array_fase_corrente.append(fase_corrente)
                array_fase_intermediaria.append(fase_intermediaria)
                array_destinacao.append(destinacao)
                array_observacoes.append(observacoes)
                count_proximo = count_proximo + 1
            }
        }
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "id" {
                id = Int(data) ?? 0
            } else if self.elementName == "grupo" {
                grupo += data
            } else if self.elementName == "kind" {
                kind += data
            } else if self.elementName == "assunto" {
                assunto += data
            } else if self.elementName == "fase_corrente" {
                fase_corrente += data
            } else if self.elementName == "fase_intermediaria" {
                fase_intermediaria += data
            } else if self.elementName == "destinacao" {
                destinacao += data
            } else if self.elementName == "observacoes" {
                observacoes += data
            } else if self.elementName == "indice" {
                indice = Int(data) ?? 0
            } else if self.elementName == "proximo" {
                proximo = Int(data) ?? 0
            }
            //print("entrei"+self.elementName+assunto)
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return descricao.count
        //eturn books.count
        return array_texto.count//descricoes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        
        //let selecao = descricao[indexPath.row]
        //cell.textLabel?.text=selecao
        
        //let book1 = books[indexPath.row]
        //cell.textLabel?.text = book1.bookAuthor
        
        //let selecao1 = descricoes[indexPath.row]
        //cell.textLabel?.text = selecao1.assunto
        //cell.textLabel?.text = String(selecao1.proximo)
        
        let selecao1 = array_texto[indexPath.row]
        cell.textLabel?.text = selecao1
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier=="segueToKindS"{
            if let indexPath=tableView.indexPathForSelectedRow {
                let tableViewControllerDestino = segue.destination as! KindSTableViewController
                let proximo1 = array_proximo[indexPath.row]
                tableViewControllerDestino.proxima_tela = proximo1
            }
        }
    }
    
    
}

