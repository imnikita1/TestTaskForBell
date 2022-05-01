//
//  MainViewPresenterProtocol.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    func getNumberOfRows() -> Int
    func getCar(with indexPath: IndexPath) -> Car?
    func didSelectRow(at indexPath: IndexPath)
}
