//
//  HeroesTableViewController.swift
//  HeroisMarvel
//
//  Created by Lucas Santana Brito on 11/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var name: String?
    var heroes = [MarvelHero]()
    var loadingHeroes = false
    var currentPage = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        loadHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupLabel() {
        label.text = "Buscando heróis. Aguarde..."
    }
    
    private func loadHeroes() {
        loadingHeroes = true
        MarvelAPI.loadHeros(name: name, page: currentPage) { [weak self] (info) in
            
            guard let info = info else { return }
            self?.heroes += info.data.results
            self?.total = info.data.total
            DispatchQueue.main.async {
                self?.loadingHeroes = false
                self?.label.text = "Não foram encontrados heróis com o nome \(self?.name!)"
                self?.tableView.reloadData()
            }
        }
    }
}

extension HeroesTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView = heroes.count == 0 ? label : nil
        return heroes.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellHero = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        return cellHero!
    }
}
