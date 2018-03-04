//
//  SeasonDetailViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit



class SeasonDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalEpisodes: UILabel!
    @IBOutlet weak var date: UILabel!
    
    // Mark: - Properties
    var model: Season
    
    // Mark: - Initialization
    init(model: Season) {
        // Primero, limpias tu propio desorder
        self.model = model
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        name.text = model.name
        totalEpisodes.text = String(model.numberOfEpisodes)
        date.text = model.parse(date: model.startDate)
    }
    
    // MARK: - UI
    func setupUI() {
        let episodes = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItems = [episodes]
    }
    
    @objc func displayEpisodes() {
        // Creamos el VC
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Hacemos Push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}








