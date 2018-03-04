//
//  EpisodeListViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

let EPISODE_KEY = "EpisodeKey"
let EPISODE_DID_CHANGE_NOTIFICATION_NAME = "EpisodeDidChange"
let LAST_EPISODE = "LAST_EPISODE"

protocol EpisodeListViewControllerDelegate: class {
    // should, will, did
    func episodeListViewController(_ viewController: EpisodeListViewController, didSelectEpisode: Episode)
}

class EpisodeListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [Episode]
    weak var delegate: EpisodeListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(style: .plain)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastRow = UserDefaults.standard.integer(forKey: LAST_EPISODE)
        let indexPath = IndexPath(row: lastRow, section: 0)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        // Descubrir cual es la episodio que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincroniza episode (model) con cell (vista)
        cell?.textLabel?.text = episode.title
        
        return cell!
        
    }
    
    // MARK: Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que episodio han pulsado
        let episode = model[indexPath.row]
        
        // Aviso al delegado
        delegate?.episodeListViewController(self, didSelectEpisode: episode)
        
        // Mando la misma info a traves de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(EPISODE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [EPISODE_KEY : episode])
        
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la ultima episodio seleccionada
        saveLastSelectedEpisode(at: indexPath.row)
    }
}

extension EpisodeListViewController {
    func saveLastSelectedEpisode(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_EPISODE)
        // Por si las moscas
        defaults.synchronize()
    }
    
    func lastSelectedEpisode() -> Episode {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_EPISODE)
        
        // Averiguar la episodio de ese row
        let episode = model[row]
        
        // Devolverla
        return episode
    }
}

