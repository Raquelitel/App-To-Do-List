//
//  ViewModel.swift
//  Notas
//
//  Created by Raquel on 11/8/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var finished = false
    @Published var updateItem: Notas!
    
    // CoreData
    
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        newNota.finished = finished
        
        do {
            try context.save()
            print("guardado correctamente")
            show.toggle()
            
        } catch let error as NSError{
            // Añadir alerta para el usuario
            print("Error", error.localizedDescription)
        }
        
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext) {
        context.delete(item)
        do {
            try context.save()
            print("eliminado")
        } catch let error as NSError {
            print ("Error", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas) {
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        finished = false
        show.toggle()
    }
    
    func updateData(context:NSManagedObjectContext){
        updateItem.nota = nota
        updateItem.fecha = fecha
        updateItem.finished = false
        
        do {
            try context.save()
            print("update")
            show.toggle()
        } catch let error as NSError {
            print ("error", error.localizedDescription)
        }
    }
    
    func resetData(){
        updateItem = nil
        nota = ""
        finished = false
        fecha = Date()
    }
}
