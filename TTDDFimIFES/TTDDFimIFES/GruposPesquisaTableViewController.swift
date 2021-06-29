//
//  GruposPesquisaTableViewController.swift
//  TTDD
//
//  Created by Macintosh HD on 16/11/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

struct DescricaoXmlGruposPesquisa {
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

class GruposPesquisaTableViewController: UITableViewController, XMLParserDelegate {
    
    var elementName: String = String()
    var descricao:[String]=[]
    var descricoes: [DescricaoXmlGruposPesquisa]=[]
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
    var array_kind = [String]()
    var array_texto = [String]()
    var array_proximo = [Int]()
    var array_indice = [Int]()
    var array_classes = [String]()
    var array_assunto = [String]()
    var array_fase_corrente = [String]()
    var array_fase_intermediaria = [String]()
    var array_destinacao = [String]()
    var array_observacoes = [String]()
    var item_selecionado: Int = 0
    var coluna_selecionada: Int = 0
    var grupo_buscado: String=String()
    var proximo_buscado: Int=Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "kind", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate=self
                parser.parse()
            }
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(GruposPesquisaTableViewController.longPress(sender:)))
        tableView.addGestureRecognizer(longPress)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                    self.performSegue(withIdentifier: "segueGruposToTemporal", sender: self)
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
            let row = DescricaoXmlGruposPesquisa(id: id, grupo:grupo, kind: kind, assunto:assunto, fase_corrente:fase_corrente, fase_intermediaria: fase_intermediaria,
                                                 destinacao:destinacao,observacoes:observacoes,indice:indice,proximo:proximo)
            descricoes.append(row)
            if grupo==grupo_buscado{
                var pos = 1
                if kind == "c" { pos = 1 }
                if kind == "s" { pos = 2 }
                if kind == "g" { pos = 3 }
                if kind == "z" { pos = 4 }
                if kind == "m" { pos = 5 }
                if kind == "n" { pos = 6 }
                
                //print("kind = "+kind+" pos = "+String(pos))
                /*
                 array_proximo.append(proximo)
                 array_classes.append(grupo)
                 array_assunto.append(assunto)
                 texto = grupo + " " + assunto + String(pos)
                 array_texto.append(texto)
                 array_fase_corrente.append(fase_corrente)
                 array_fase_intermediaria.append(fase_intermediaria)
                 array_destinacao.append(destinacao)
                 array_observacoes.append(observacoes)
                 */
                pos = pos-1
                for _ in 1...pos+1 { array_kind.append("") }
                for _ in 1...pos+1 { array_proximo.append(0) }
                for _ in 1...pos+1 { array_indice.append(0) }
                for _ in 1...pos+1 { array_classes.append("") }
                for _ in 1...pos+1 { array_assunto.append("") }
                for _ in 1...pos+1 { array_texto.append("") }
                for _ in 1...pos+1 { array_fase_corrente.append("") }
                for _ in 1...pos+1 { array_fase_intermediaria.append("") }
                for _ in 1...pos+1 { array_destinacao.append("") }
                for _ in 1...pos+1 { array_observacoes.append("") }
                
                array_kind[pos]=kind
                array_proximo[pos]=proximo
                array_indice[pos]=indice
                array_classes[pos]=grupo
                array_assunto[pos]=assunto
                texto = grupo + " " + assunto
                array_texto[pos]=texto
                array_fase_corrente[pos]=fase_corrente
                array_fase_intermediaria[pos]=fase_intermediaria
                array_destinacao[pos]=destinacao
                array_observacoes[pos]=observacoes
                count_proximo = count_proximo + 1
                
                if pos>=1 {
                    pos = pos - 1
                    for n in 0...descricoes.count-1 {
                        if descricoes[n].proximo == indice {
                            array_kind[pos] = descricoes[n].kind
                            array_proximo[pos] = descricoes[n].proximo
                            array_indice[pos] = descricoes[n].indice
                            array_classes[pos] = descricoes[n].grupo
                            array_assunto[pos] = descricoes[n].assunto
                            texto = descricoes[n].grupo + " " + descricoes[n].assunto
                            array_texto[pos] = texto
                            array_fase_corrente[pos] = descricoes[n].fase_corrente
                            array_fase_intermediaria[pos] = descricoes[n].fase_intermediaria
                            array_destinacao[pos] = descricoes[n].destinacao
                            array_observacoes[pos] = descricoes[n].observacoes
                            indice = descricoes[n].indice
                            break;
                        }
                    }
                    
                    if pos>=1 {
                        pos = pos - 1
                        for n in 0...descricoes.count-1 {
                            if descricoes[n].proximo == indice {
                                array_kind[pos] = descricoes[n].kind
                                array_proximo[pos] = descricoes[n].proximo
                                array_indice[pos] = descricoes[n].indice
                                array_classes[pos] = descricoes[n].grupo
                                array_assunto[pos] = descricoes[n].assunto
                                texto = descricoes[n].grupo + " " + descricoes[n].assunto
                                array_texto[pos] = texto
                                array_fase_corrente[pos] = descricoes[n].fase_corrente
                                array_fase_intermediaria[pos] = descricoes[n].fase_intermediaria
                                array_destinacao[pos] = descricoes[n].destinacao
                                array_observacoes[pos] = descricoes[n].observacoes
                                indice = descricoes[n].indice
                                break;
                            }
                        }
                        
                        if pos>=1 {
                            pos = pos - 1
                            for n in 0...descricoes.count-1 {
                                if descricoes[n].proximo == indice {
                                    array_kind[pos] = descricoes[n].kind
                                    array_proximo[pos] = descricoes[n].proximo
                                    array_indice[pos] = descricoes[n].indice
                                    array_classes[pos] = descricoes[n].grupo
                                    array_assunto[pos] = descricoes[n].assunto
                                    texto = descricoes[n].grupo + " " + descricoes[n].assunto
                                    array_texto[pos] = texto
                                    array_fase_corrente[pos] = descricoes[n].fase_corrente
                                    array_fase_intermediaria[pos] = descricoes[n].fase_intermediaria
                                    array_destinacao[pos] = descricoes[n].destinacao
                                    array_observacoes[pos] = descricoes[n].observacoes
                                    indice = descricoes[n].indice
                                    break;
                                }
                            }
                            
                            if pos>=1 {
                                pos = pos - 1
                                for n in 0...descricoes.count-1 {
                                    if descricoes[n].proximo == indice {
                                        array_kind[pos] = descricoes[n].kind
                                        array_proximo[pos] = descricoes[n].proximo
                                        array_indice[pos] = descricoes[n].indice
                                        array_classes[pos] = descricoes[n].grupo
                                        array_assunto[pos] = descricoes[n].assunto
                                        texto = descricoes[n].grupo + " " + descricoes[n].assunto
                                        array_texto[pos] = texto
                                        array_fase_corrente[pos] = descricoes[n].fase_corrente
                                        array_fase_intermediaria[pos] = descricoes[n].fase_intermediaria
                                        array_destinacao[pos] = descricoes[n].destinacao
                                        array_observacoes[pos] = descricoes[n].observacoes
                                        indice = descricoes[n].indice
                                        break;
                                    }
                                }
                                
                                if pos>=1 {
                                    pos = pos - 1
                                    for n in 0...descricoes.count-1 {
                                        if descricoes[n].proximo == indice {
                                            array_kind[pos] = descricoes[n].kind
                                            array_proximo[pos] = descricoes[n].proximo
                                            array_indice[pos] = descricoes[n].indice
                                            array_classes[pos] = descricoes[n].grupo
                                            array_assunto[pos] = descricoes[n].assunto
                                            texto = descricoes[n].grupo + " " + descricoes[n].assunto
                                            array_texto[pos] = texto
                                            array_fase_corrente[pos] = descricoes[n].fase_corrente
                                            array_fase_intermediaria[pos] = descricoes[n].fase_intermediaria
                                            array_destinacao[pos] = descricoes[n].destinacao
                                            array_observacoes[pos] = descricoes[n].observacoes
                                            indice = descricoes[n].indice
                                            break;
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaReusoGruposPesquisa", for: indexPath)
        
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier=="segueGruposToKindS"{
            if let indexPath=tableView.indexPathForSelectedRow {
                let tableViewControllerDestino = segue.destination as! KindSTableViewController
                let indice1 = array_indice[indexPath.row]
                tableViewControllerDestino.proxima_tela = indice1
                print ("GruposPesquisa to kindS - "+String(indice1)+" "+String(indexPath.row))
            }
        }
        
        if segue.identifier=="segueGruposToKindG"{
            if let indexPath=tableView.indexPathForSelectedRow {
                let tableViewControllerDestino = segue.destination as! KindGTableViewController
                let indice1 = array_indice[indexPath.row]
                tableViewControllerDestino.proxima_tela = indice1
                print ("GruposPesquisa to kindG - "+String(indice1)+" "+String(indexPath.row))
            }
        }
        
        if segue.identifier=="segueGruposToKindZ"{
            if let indexPath=tableView.indexPathForSelectedRow {
                let tableViewControllerDestino = segue.destination as! KindZTableViewController
                let indice1 = array_indice[indexPath.row]
                tableViewControllerDestino.proxima_tela = indice1
                print ("GruposPesquisa to kindZ - "+String(indice1)+" "+String(indexPath.row))
            }
        }
        
        if segue.identifier=="segueGruposToKindM"{
            if let indexPath=tableView.indexPathForSelectedRow {
                let tableViewControllerDestino = segue.destination as! KindMTableViewController
                let indice1 = array_indice[indexPath.row]
                tableViewControllerDestino.proxima_tela = indice1
                print ("GruposPesquisa to kindM - "+String(indice1)+" "+String(indexPath.row))
            }
        }
        
        if segue.identifier=="segueGruposToKindN"{
            if let indexPath=tableView.indexPathForSelectedRow {
                let tableViewControllerDestino = segue.destination as! KindNTableViewController
                let indice1 = array_indice[indexPath.row]
                tableViewControllerDestino.proxima_tela = indice1
                print ("GruposPesquisa to kindN - "+String(indice1)+" "+String(indexPath.row))
            }
        }
        
        if segue.identifier=="segueGruposToTemporal"{
            //print("entrei no segueSToTemporal")
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
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var proximo1 = 1
        var kind1 = ""
        if let indexPath=tableView.indexPathForSelectedRow {
            proximo1 = indexPath.row
            kind1 = array_kind[proximo1]
        }
        print("shouldPerform "+String(proximo1)+kind1)
        
        // a celulaReusoGrupos tem segue para kindZ no default, neste caso basta dar return, nos demais reoriente para a segue correta
        if kind1=="c"{
            self.performSegue(withIdentifier: "segueGruposToHome", sender: self)
            return false
        }
        if kind1=="s"{
            self.performSegue(withIdentifier: "segueGruposToKindS", sender: self)
            return false
        }
        if kind1=="g"{
            self.performSegue(withIdentifier: "segueGruposToKindG", sender: self)
            return false
        }
        if kind1=="m"{
            self.performSegue(withIdentifier: "segueGruposToKindM", sender: self)
            return false
        }
        if kind1=="n"{
            self.performSegue(withIdentifier: "segueGruposToKindN", sender: self)
            return false
        }
        return true
    }
    
}

