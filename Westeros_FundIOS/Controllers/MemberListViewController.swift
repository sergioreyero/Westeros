//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

protocol MemberListViewControllerDelegate: class{
    func MemberListViewController(_ vc:MemberListViewController)
}

class MemberListViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Mark: - Properties
    var model: [Person]
    var delegate: MemberListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        // Asignamos la fuente de datos
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification) {
        // Extraer el userInfo de la notification
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let house = info[HOUSE_KEY] as? House
        
        // Actualizar el modelo
        guard let model = house?.sortedMembers else { return }
        self.model = model
        
        // Sincronizar la vista
        syncModelWithView()
    }
    
    func syncModelWithView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MemberListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        
        // Descubrir la persona que tenemos que mostrar
        let person = model[indexPath.row]
        
        // Preguntar por una celda (a una cache) o Crearla
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar celda y persona
        cell.textLabel?.text = person.fullName
        
        // Devolver la celda
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let member = model[indexPath.row]
        let memberDetailViewController = MemberDetailViewController(model: member)
        navigationController?.pushViewController(memberDetailViewController, animated: true)
        
        delegate?.MemberListViewController(self)
    }
}










