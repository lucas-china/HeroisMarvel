//
//  ViewController.swift
//  HeroisMarvel
//
//  Created by Lucas Santana Brito on 29/12/19.
//  Copyright © 2019 lsb.br. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        nameTextField.resignFirstResponder()
        guard let vc = segue.destination as? HeroesTableViewController else { return }
        vc.name = nameTextField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

