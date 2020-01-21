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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? HeroViewController else { return }
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        vc.hero = heroes[index]
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heroes.count == 0 ? label : nil
        return heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellHero = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HeroTableViewCell else { return HeroTableViewCell() }
        
        let hero = heroes[indexPath.row]
        
        cellHero.prepareCell(with: hero)
        
        return cellHero
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 10 && !loadingHeroes &&  heroes.count != total {
            currentPage += 1
            loadHeroes()
        }
    }
}
