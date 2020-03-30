//
//  PacotesViagensViewController.swift
//  Alura Viagens
//
//  Created by Takuma Shimabukuro on 2020/03/25.
//  Copyright © 2020年 Alura. All rights reserved.
//

import UIKit

class PacotesViagensViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UICollectionViewDelegate {

    
    @IBOutlet weak var colecaoDePacotes: UICollectionView!
    
    @IBOutlet weak var pesquisarViagens: UISearchBar!
    
    @IBOutlet weak var listaContadorPacotes: UILabel!
    
    let listaComTodasViagens:Array<PacoteViagem> = PacoteViagemDAO().retornaTodasAsViagens()
    var listaViagens: Array<PacoteViagem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaViagens = listaComTodasViagens
        colecaoDePacotes.dataSource = self
        colecaoDePacotes.delegate = self
        pesquisarViagens.delegate = self
        self.listaContadorPacotes.text = self.atualizaContadorLabel()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacoteViagemCollectionViewCell
        
        let pacoteAtual = listaViagens[indexPath.row]
        
        cell.configurarCelula(pacote: pacoteAtual)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let larguraDaCelula = collectionView.bounds.width / 2
            return CGSize(width: larguraDaCelula - 20, height: 160)
        } else {
            let larguraDaCelula = collectionView.bounds.width / 3
            return CGSize(width: larguraDaCelula - 20, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhe") as! DetalhesViagemViewController
        
        let pacote = listaViagens[indexPath.row]
        controller.pacoteSelecionado = pacote
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let filtroListaViagem = NSPredicate(format: "viagem.titulo contains[c] %@", searchText)
            let listaFiltrada: Array<PacoteViagem> = (listaComTodasViagens as NSArray).filtered(using: filtroListaViagem) as! Array
            listaViagens = listaFiltrada
            
        } else {
            listaViagens = listaComTodasViagens
        }
        self.listaContadorPacotes.text = self.atualizaContadorLabel()
        colecaoDePacotes.reloadData()
    }
    
    func atualizaContadorLabel() -> String {
        return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
    }
    

}
