//
//  MainTabBarVC.swift
//  DYZhiBoDemo
//
//  Created by wayfor on 2018/3/21.
//  Copyright © 2018年 LIUSON. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
//        let childVc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!
//        addChildViewController(childVc)
        setUI(name: "Home")
        setUI(name: "Live")
        setUI(name: "Follow")
        setUI(name: "Mine")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    private func setUI(name:String){
        let childVc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
        addChildViewController(childVc!)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
