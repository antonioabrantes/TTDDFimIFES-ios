//
//  KindNTableViewController.swift
//  TTDD
//
//  Created by Macintosh HD on 26/10/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

struct DescricaoXmlKindN {
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

class KindNTableViewController: UITableViewController, XMLParserDelegate {
    
    var elementName: String = String()
    var descricao:[String]=[]
    var descricoes: [DescricaoXmlKindN]=[]
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
    var item_selecionado: Int = 0
    var coluna_selecionada: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "kind", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate=self
                parser.parse()
            }
        }
        print("KindN - " + String(proxima_tela))
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(KindNTableViewController.longPress(sender:)))
        tableView.addGestureRecognizer(longPress)
        
    }
    
    
    @objc func longPress(sender:UILongPressGestureRecognizer){
        var fase_corrente1 = ""
        var fase_intermediaria1 = ""
        var destinacao1 = ""
        var observacoes1 = ""
        
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if tableView.indexPathForRow(at: touchPoint) != nil {
                if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
                    print("Long Click pressed "+"\(indexPath.section) \(indexPath.row)")
                    coluna_selecionada = indexPath.row
                    fase_corrente1 = array_fase_corrente[coluna_selecionada]
                    fase_intermediaria1 = array_fase_intermediaria[coluna_selecionada]
                    destinacao1 = array_destinacao[coluna_selecionada]
                    observacoes1 = array_observacoes[coluna_selecionada]
                }
                
                if (fase_corrente1=="" && fase_intermediaria1=="" &&
                    destinacao1=="" && observacoes1==""){
                    let alertController = UIAlertController(title: nil, message:
                        "Não há dados de temporalidade", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
                    
                    present(alertController, animated: true, completion: nil)
                    
                } else {
                    self.performSegue(withIdentifier: "segueNToTemporal", sender: self)
                }
            }
        }
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
            let row = DescricaoXmlKindN(id: id, grupo:grupo, kind: kind, assunto:assunto, fase_corrente:fase_corrente, fase_intermediaria: fase_intermediaria,
                                        destinacao:destinacao,observacoes:observacoes,indice:indice,proximo:proximo)
            descricoes.append(row)
            if indice==proxima_tela{
                //print("parser "+String(grupo)+" "+String(assunto))
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
        return array_texto.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaReusoKindN", for: indexPath)
        
        // Configure the cell...
        let selecao1 = array_texto[indexPath.row]
        cell.textLabel?.text = selecao1
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
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
        if segue.identifier=="segueNToTemporal"{
            //print("entrei no segueNToTemporal")
            let viewControllerDestino = segue.destination as! TemporalViewController
            let iclasses = array_classes[coluna_selecionada]
            let iassunto = array_assunto[coluna_selecionada]
            let ifasecor = array_fase_corrente[coluna_selecionada]
            let ifaseint = array_fase_intermediaria[coluna_selecionada]
            let iobserva = array_observacoes[coluna_selecionada]
            let idestina = array_destinacao[coluna_selecionada]
            
            viewControllerDestino.iclasses = iclasses
            viewControllerDestino.iassunto = iassunto
            viewControllerDestino.ifasecor = ifasecor
            viewControllerDestino.ifaseint = ifaseint
            viewControllerDestino.iobserva = iobserva
            viewControllerDestino.idestina = idestina
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var proximo1 = 1
        if let indexPath=tableView.indexPathForSelectedRow {
            item_selecionado = indexPath.row
            proximo1 = array_proximo[item_selecionado]
            //print("entrei no shouldPerform "+String(proximo1)+" - "+String(item_selecionado))
        }
        if (proximo1==0){
            let alertController = UIAlertController(title: nil, message:
                "Este gupo não tem subgrupos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            
            present(alertController, animated: true, completion: nil)
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
            
            return false
        } else {
            return true
        }
    }
    
    
}

