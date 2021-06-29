//
//  TemporalViewController.swift
//  TTDD
//
//  Created by Macintosh HD on 27/10/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class TemporalViewController: UIViewController {
    
    @IBOutlet weak var textViewT1: UILabel!
    @IBOutlet weak var textViewT2: UILabel!
    @IBOutlet weak var textViewT3: UILabel!
    @IBOutlet weak var textViewT4: UILabel!
    @IBOutlet weak var textViewT5: UILabel!
    @IBOutlet weak var textViewT6: UILabel!
    
    var iclasses: String=String()
    var iassunto: String=String()
    var ifasecor: String=String()
    var ifaseint: String=String()
    var idestina: String=String()
    var iobserva: String=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewT1.text = iclasses
        textViewT2.text = iassunto
        if ifasecor=="" {
            ifasecor = "-"
        }
        textViewT3.text = ifasecor
        if ifaseint=="" {
            ifaseint = "-"
        }
        textViewT4.text = ifaseint
        textViewT5.text = idestina
        textViewT6.text = "Observações: " + iobserva
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier=="segueTemporalToNota"{
         //print("entrei no segueSToTemporal")
         let viewControllerDestino = segue.destination as! NotaExplicativaViewController
         
         viewControllerDestino.iclasses = iclasses
         viewControllerDestino.iassunto = iassunto
     }
     }
     
    
}

