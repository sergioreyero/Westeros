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
    
    @IBOutlet weak var startDateEpisodeLabel: UILabel!
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    //MARK: - Properties
    
    var model: Episode
    
    //MARK: - Initialization
    
    init(model: Episode){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelEpisodeDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Sync
    func syncModelEpisodeDetail(){
        titleLabel.text = model.title
        startDateEpisodeLabel.text = "Launch Date: \(model.parse(date: model.launchDate))"
        seasonEpisodeLabel.text = model.season?.name
    }
    
}

extension EpisodeDetailViewController: EpisodeListViewControllerDelegate{
    func episodeListViewController(_ vc: EpisodeListViewController) {
        navigationController?.pushViewController(self, animated: true)
    }
}
