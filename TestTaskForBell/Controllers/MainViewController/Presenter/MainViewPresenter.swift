//
//  MainViewPresenter.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import Foundation

final class MainViewPresenter {

    weak var view: MainViewController?
    var cars: [Car]?

    required init(_ view: MainViewController) {
        self.view = view
        initialSetup()
    }

    private func initialSetup() {
        fetchCars()
    }

    private func fetchCars() {
        if let url = Bundle.main.url(forResource: "car_list", withExtension: "json") {
             do {
                 let data = try Data(contentsOf: url)
                 self.cars = try JSONDecoder().decode([Car].self, from: data)
             } catch {
                 print("error:\(error)")
             }
         }
    }
}

// MARK: - MainViewPresenterProtocol
extension MainViewPresenter: MainViewPresenterProtocol {

    func getNumberOfRows() -> Int {
        cars?.count ?? 0
    }

    func getCar(with indexPath: IndexPath) -> Car? {
        if var car = cars?[indexPath.row] {
            car.imageName = getCarImage(for: car.model)
            return car
        }
        return nil
    }

    private func getCarImage(for carModel: String?) -> String {
        switch carModel {
        case "Range Rover": return "Range_Rover"
        case "Roadster": return "Alpine_roadster"
        case "3300i": return "BMW_330i"
        case "GLE coupe": return "Mercedez_benz_GLC"
        default: return "car_placeholder2"
        }
    }
}
