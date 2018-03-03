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
    
    var model: Season
    
    // Mark: - Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupUI()
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        name.text = model.name
        totalEpisodes.text = String(model.numberOfEpisodes)
        date.text = model.parse(date: model.startDate)
    }
}
