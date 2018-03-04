//
//  EpisodeListViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

protocol EpisodeListViewControllerDelegate: class{
    func episodeListViewController(_ vc:EpisodeListViewController)
}

class EpisodeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // Mark: - Properties
    var model: [Episode]
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
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func seasonDidChange(notification: Notification) {
        // Extraer el userInfo de la notification
        guard let info = notification.userInfo else {
            return
        }
        let season = info[SEASON_KEY] as? Season
        
        // Actualizar el modelo
        guard let model = season?.sortedEpisodes else { return }
        self.model = model
        
        // Sincronizar la vista
        tableView.reloadData()
    }
}

extension EpisodeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        
        // Descubrir la persona que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Preguntar por una celda (a una cache) o Crearla
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar celda y persona
        cell.textLabel?.text = episode.title
        
        // Devolver la celda
        return cell
    }
}

extension EpisodeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let episode = model[indexPath.row]
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
        
        delegate?.episodeListViewController(self)
    }
}



