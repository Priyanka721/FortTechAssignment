//
//  HomeViewModel.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 23/09/23.
//

import Foundation

class HomeViewModel {
    var homeData: [HomeDataModel] = []
    
    func fetchHomeData(completion: @escaping ([HomeDataModel]) -> Void) {
        let homeData = DBHelper.shared.read()
        completion(homeData.reversed())
    }
    
}
