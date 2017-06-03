//
//  TinyPixDocument.swift
//  TinyPix
//
import UIKit

class TinyPixDocument
{
    var arr = [ [0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0] ]
    
    func stateAt(row: Int, column: Int) -> Int {
        return arr[row][column]
    }
    
    func setState(_ state: Int, atRow row: Int, column: Int) {
        arr[row][column] = state
    }
    
    func toggleStateAt(row: Int, column: Int) {
        let state = stateAt(row: row, column: column)
        if state == 0 {
            setState(1, atRow: row, column: column)
        } else {
            setState(0, atRow: row, column: column)
        }
    }
    
}
