//
//  EpisodeDetailViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    // Mark: - Properties
    var model: Episode
    
    // Mark: - Initialization
    init(model: Episode) {
        // Primero, limpias tu propio desorder
        self.model = model
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.title
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        titleLabel.text = "Episode '\(model.title)'"
    }
}

//extension EpisodeDetailViewController: EpisodeListViewControllerDelegate {
//    func episodeListViewController(_ viewController: EpisodeListViewController, didSelectEpisode episode: Episode) {
//        self.model = episode
//        syncModelWithView()
//    }
//}

