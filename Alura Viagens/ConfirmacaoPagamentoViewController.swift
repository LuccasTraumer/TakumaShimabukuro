//
//  ConfirmacaoPagamentoViewController.swift
//  Alura Viagens
//
//  Created by Takuma Shimabukuro on 2020/03/27.
//  Copyright © 2020年 Alura. All rights reserved.
//

import UIKit

class ConfirmacaoPagamentoViewController: UIViewController {

    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelHotelPacoteViagem: UILabel!
    @IBOutlet weak var labelDataPacoteViagem: UILabel!
    @IBOutlet weak var labelQuantidadePessoas: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    
    var pacoteComprado: PacoteViagem? = nil
    
    @IBOutlet weak var buttonVoltarHome: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pacote = pacoteComprado else { return }
        self.imagemPacoteViagem.image = UIImage(named: pacote.viagem.caminhoDaImagem)
        self.labelTituloPacoteViagem.text = pacote.viagem.titulo.uppercased()
        self.labelHotelPacoteViagem.text = pacote.nomeDoHotel
        self.labelDataPacoteViagem.text = "\(pacote.viagem.quantidadeDeDias) Dias"
        self.labelDescricaoPacoteViagem.text = pacote.descricao
        
        
        self.imagemPacoteViagem.layer.cornerRadius = 10
        self.imagemPacoteViagem.layer.masksToBounds = true
        self.buttonVoltarHome.layer.cornerRadius = 8
        self.buttonVoltarHome.layer.masksToBounds = true
        
    }
    
    @IBAction func botaoVoltarHome(_ sender: Any) {
        if let navigation = self.navigationController {
            navigation.popToRootViewController(animated: true)
        }
    }

}
