//
//  InfoViewController.swift
//  TTDD
//
//  Created by Macintosh HD on 06/12/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var ajuda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ajuda.text = "Guia do Usuário: o TTDD Fim IFES (Tabela de Temporalidade e Destinação de Documentos, da Atividade-Fim das Instituições Federais de Ensino Superior (IFES)) é um aplicativo que possibilita a navegação pela tabela de temporalidade com recursos de busca. O Código de Classificação e a Tabela de Temporalidade e Destinação de Documentos de Arquivos relativos às Atividades-Fim das Instituições Federais de Ensino Superior são baseados na Portaria n.092 do Arquivo Nacional de 23 de setembro de 2011. Para navegar escolha a função Casa que aparece no menu superior. Você pode navegar pelas classes, subclasses, grupos e subgrupos podendo retornar à tela anterior clicando na primeira opção da lista de seleção.\n\n Para ver a temporalidade da opção desejada basta manter a sua seleção por dois segundos, ou seja, ao invés de um clique simples de seleção procure prolongar uma pouco mais nesta mesma opção para o que o aplicativo possa mostrar numa janela temporária as informações de temporalidade.\n\n Escolha a lupa do menu principal para procurar por uma classificação ou por uma palavra específica no campo Assunto da tabela de temporalidade independentemente do índice de assuntos. Para sair para selecionar a opção de saída no menu lateral para que todas as janelas sejam fechadas e o aplicativo encerrado.\n\n\n\n"
        
        // Do any additional setup after loading the view.
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

