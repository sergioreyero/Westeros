//
//  SeasonListViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 03/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

let SEASON_KEY = "SeasonKey"
let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonDidChange"
let LAST_SEASON = "LAST_SEASON"

protocol SeasonListViewControllerDelegate: class {
    // should, will, did
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}


class SeasonListViewController: UITableViewController {
    @IBOutlet weak var seasonListTableView: UITableView!
    
    // Mark: - Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastRow = UserDefaults.standard.integer(forKey: LAST_SEASON)
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
        
        let cellId = "SeasonCell"
        
        // Descubrir cual es la temporada que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincroniza season (model) con cell (vista)
        cell?.textLabel?.text = season.name
        
        return cell!
        
    }
    
    // MARK: Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que temporada han pulsado
        let season = model[indexPath.row]
        
        // Aviso al delegado
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        // Mando la misma info a traves de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY : season])
        
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la ultima temporada seleccionada
        saveLastSelectedSeason(at: indexPath.row)
    }
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_SEASON)
        // Por si las moscas
        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        
        // Averiguar la temporada de ese row
        let season = model[row]
        
        // Devolverla
        return season
    }
}
