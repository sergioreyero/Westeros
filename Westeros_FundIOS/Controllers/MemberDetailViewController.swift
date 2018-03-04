//
//  MemberDetailViewController.swift
//  Westeros_FundIOS
//
//  Created by Sergio Reyero on 04/03/2018.
//  Copyright © 2018 Sergio Reyero. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    @IBOutlet weak var namePersonLabel: UILabel!
    @IBOutlet weak var aliasPersonLabel: UILabel!
    
    //MARK: - Properties
    var model: Person
    
    //MARK: - Initialization
    init(model:Person){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
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
    
    func syncModelWithView(){
        namePersonLabel.text = "Name: \(model.name)"
        aliasPersonLabel.text = "Alias: \(model.alias)"
        title = model.fullName
    }
}


extension MemberDetailViewController: MemberListViewControllerDelegate{
    func MemberListViewController(_ vc: MemberListViewController) {
        //        self.model = member
        //        syncModelWithView()
        navigationController?.pushViewController(self, animated: true)
    }
}
