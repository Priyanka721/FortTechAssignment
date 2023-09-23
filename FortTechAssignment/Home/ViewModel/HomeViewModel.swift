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
        homeData.append(HomeDataModel(latitude: "12.628849", longitude: "12.628849", timeStamp: "22-03-23"))
        homeData.append(HomeDataModel(latitude: "92.628849", longitude: "92.628849", timeStamp: "02-03-23"))
        homeData.append(HomeDataModel(latitude: "56.628849", longitude: "56.628849", timeStamp: "19-03-23"))
        homeData.append(HomeDataModel(latitude: "91.628849", longitude: "91.628849", timeStamp: "30-03-23"))
        homeData.append(HomeDataModel(latitude: "23.628849", longitude: "23.628849", timeStamp: "18-03-23"))
        homeData.append(HomeDataModel(latitude: "23.628849", longitude: "23.628849", timeStamp: "14-03-23"))
        completion(homeData)
    }
    
}
