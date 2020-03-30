//
//  DetalhesViagemViewController.swift
//  Alura Viagens
//
//  Created by Takuma Shimabukuro on 2020/03/26.
//  Copyright © 2020年 Alura. All rights reserved.
//

import UIKit

class DetalhesViagemViewController: UIViewController {

    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var labelPrecoPacoteViagem: UILabel!
    
    @IBOutlet weak var scrollPrincipal: UIScrollView!
    
    @IBOutlet weak var textFieldData: UITextField!
    
    var pacoteSelecionado: PacoteViagem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll(notification:)), name: .UIKeyboardWillShow, object: nil)
        
        if let pacote = pacoteSelecionado {
            self.imagemPacoteViagem.image = UIImage(named: pacote.viagem.caminhoDaImagem)
            self.labelTituloPacoteViagem.text = pacote.viagem.titulo
            self.labelDescricaoPacoteViagem.text = pacote.descricao
            self.labelDataViagem.text = pacote.dataViagem
            self.labelPrecoPacoteViagem.text = pacote.viagem.preco
        }
        
    }
    
    func aumentarScroll(notification: Notification) {
        self.scrollPrincipal.contentSize = CGSize(width: self.scrollPrincipal.frame.width, height: self.scrollPrincipal.frame.height + 320)
    }
    
    @IBAction func botaoVOltar(_ sender: UIButton) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    @IBAction func textFieldEntrouFoco(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(exibeDataTextField(sender:)), for: .valueChanged)
    }
    
    func exibeDataTextField( sender: UIDatePicker){
        let formatador = DateFormatter()
        formatador.dateFormat = "dd MM yyyy"
        textFieldData.text = formatador.string(from: sender.date)
    }
    
    @IBAction func confirmarPagamento(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "finalizarCompra") as! ConfirmacaoPagamentoViewController
        controller.pacoteComprado = pacoteSelecionado
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
