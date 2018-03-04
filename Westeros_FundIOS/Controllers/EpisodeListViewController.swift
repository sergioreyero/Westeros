//
//  EpisodeListViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

protocol EpisodeListViewControllerDelegate: class {
    // should, will, did
    func episodeListViewController(_ viewController: EpisodeListViewController, didSelectEpisode: Episode)
}

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var episodeListTableView: UITableView!
    
    // Mark: - Properties
    let model: [Episode]
    weak var delegate: EpisodeListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asignamos la fuente de datos
        episodeListTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension EpisodeListViewController: UITableViewDataSource {
    
    func tableView(_ episodeListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ episodeListTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EpisodeCell"
        
        // Descubrir la episodio que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Preguntar por una celda (a una cache) o Crearla
        let cell = episodeListTableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar celda y episodio
        cell.textLabel?.text = episode.title
        
        // Devolver la celda
        return cell
    }
}

