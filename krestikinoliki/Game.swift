//
//  Game.swift
//  krestikinoliki
//
//  Created by mavluda on 28/2/23.
//

import Foundation

protocol Menu{
    func startGame()
    func endGame()
}

class Game: Menu{
    private var gameField = [[String]]()
    
    private func getEmpty(x: Int,y: Int) -> Bool{
        if gameField[y-1][x-1] != ""{return false}else{return true}
    }
    
    private func makeBusy(x: Int,y:Int,sign:String) -> Bool{
        if sign == "X" || sign == "O"{
            if gameField[y-1][x-1] == ""{
                gameField[y-1][x-1] = sign
                print("Клетка \(x)-\(y) была занята \(sign)")
                return true
            }else{
                print("Клетка уже занята")
                return false
            }
        }else{
            print("Неверный знак для установки")
            return false
        }
    }
    
    private func getOwner(x: Int,y:Int) -> String{
        return gameField[y-1][x-1]
    }
    
    private func checkFieldForPlace() -> Bool{
        var availability = false
        for i in gameField{
            for item in i{
                if item == ""{
                    availability = true
                    break
                }
            }
        }
        return availability
    }
    
    private var countX = 0
    private var countO = 0
    
    private func checkWinner() -> Bool{
        let combinationsX = [[1,2,3],[1,2,3],[1,2,3],[1,1,1],[2,2,2],[3,3,3],[1,2,3],[3,2,1]]
        let combinationsY = [[1,1,1],[2,2,2],[3,3,3],[1,2,3],[1,2,3],[1,2,3],[1,2,3],[3,2,1]]
        
        var check = false
        
        for i in 0..<combinationsX.count{
            if countX == 3 || countO == 3{
                check = true
                break
            }else{
                countO = 0
                countX = 0
                for i2 in 0..<3{
                    if getOwner(x: combinationsY[i][i2], y: combinationsX[i][i2]) == "X"{
                        countX += 1
                    }else if getOwner(x: combinationsY[i][i2], y: combinationsX[i][i2]) == "O"{
                        countO += 1
                    }
                }
            }
        }
        
        return check
    }
    
    private func getWinner(){
            if countX == 3{
                print("X - Winner")
            }else if countO == 3{
                print("O - Winner")
            }
    }
    
    private func fillField(){
        for _ in 0..<3{
            gameField.append(["","",""])
        }
    }
    
    private func dice() -> Int{
        print("Сейчас разыграется первый ход")
        let random = Int.random(in: 0...1)
        return random
    }
    
    private func printField(){
        var stringField = ""
        
        for i in gameField{
            for item in i{
                stringField += "[\(item)]"
            }
            stringField += "\n"
        }
        print(stringField)
    }
    
    private func makeStep(sign: String){
        var check = false
        
        while check == false{
            print("Введите клетку по вертикали(Y)")
            let xString = readLine()!
            print("Введите клетку по горизонтали(X)")
            let yString = readLine()!
            
            if Int(xString) != nil && Int(yString) != nil{
                print("Идёт проверка клетки")
                let x = Int(xString)!
                let y = Int(yString)!
                if getEmpty(x: y, y: x){
                    print("Клетка \(y)-\(x) свободна. Занимаем")
                    if makeBusy(x: y, y: x, sign: sign){
                        print("Клетка успешно занята")
                        check = true
                        }else{
                            print("Возникла ошибка. Клетка не была занята")
                        }
                }else{
                    print("Возникла ошибка. Клетка не была занята")
                }
            }else{
                print("Координаты введены неверно.Попробуйте снова")
            }
        }
    }
    
    func startGame() {
        fillField()
        
        var current = ""
        
        if dice() == 0{
            current = "X"
        }else{
            current = "O"
        }
        
        while checkFieldForPlace(){

if checkWinner() == true{
                endGame()
                printField()
                break
            }else{
                printField()
                print("Ходит \(current)")
                    makeStep(sign: current)
                    if current == "X"{
                        current = "O"
                    }else{
                        current = "X"
                    }
            }
        }
    }
    
    func endGame(){
        getWinner()
    }
    
    
    
}
