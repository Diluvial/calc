//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

func checkEquation(_ userInput: [String]) {
    var position: Int = 0
    
    //Will check if the input can be calculated
    if userInput.count <= 0 {
        //print("There are no values in your input")
        exit(1)
    }
    
    //Begins or ends with an integer
    if userInput[0] == "/" || userInput[0] == "x" || userInput[0] == "%" || userInput[0] == "+" || userInput[0] == "-" {
        //print("You must begin the equation with an integer")
        exit(1)
    }
    if userInput[userInput.count - 1] == "/" || userInput[userInput.count - 1] == "x" || userInput[userInput.count - 1] == "%" || userInput[userInput.count - 1] == "+" || userInput[userInput.count - 1] == "-" {
        //print("You must end the equation with an integer")
        exit(1)
    }
    
    //Check the Integers entered are legit
    for value in userInput {
        if value != "/" && value != "x" && value != "%" && value != "+" && value != "-" {
            if let _ = Int(value) {
                position += 1
            } else {
                //print("You must enter an integer")
                exit(1)
            }
        }
    }
    
    //Will check to see if there are two equations running consectutive to each other
    position = 0
    for value in userInput {
        if value == "/" || value == "x" || value == "%" || value == "+" || value == "-" {
            if userInput[position + 1] == "/" || userInput[position + 1] == "x" || userInput[position + 1] == "%" || userInput[position + 1] == "+" || userInput[position + 1] == "-"{
                //print("You cannot have two equations running consectutive to each other")
                exit(1)
            }
            position += 1
        } else {
            position += 1
        }
    }
}

//Will solve the equation if passed checkString
func solve(_ equation: [String]) -> Int {
    var equationCopy = equation
    //dump(equationCopy)
    var position: Int = 0
    
    // Check for '/' operands
    for value in equationCopy {
        if value == "/" {

            //Will check if being devided by zero
            if equationCopy[position + 1] == "0" {
                exit(1)
            } else if equationCopy[position - 1] == "0" {
                equationCopy[position + 1] = "0"
                
            //Will run the normal operation
            } else {
                equationCopy[position + 1] = String(Int(equationCopy[position - 1])! / Int(equationCopy[position + 1])!)
            }
            
            //Remove values from string
            equationCopy.remove(at: position)
            equationCopy.remove(at: position - 1)
            position -= 1
            //dump(equationCopy)
        } else {
            position += 1
        }
    }
    
    position = 0
    // Check for 'x' operands
    for value in equationCopy {
        if value == "x" {

            equationCopy[position + 1] = String(Int(equationCopy[position - 1])! * Int(equationCopy[position + 1])!)
            
            // Remove values from string
            equationCopy.remove(at: position)
            equationCopy.remove(at: position - 1)
            position -= 1
            
        } else {
            position += 1
        }
    }
    
    position = 0
    // Check for '%' operands
    for value in equationCopy {
        if value == "%" {

            //Will check if being mod by zero
            if equationCopy[position + 1] == "0" {
                exit(1)
            } else if equationCopy[position - 1] == "0" {
                equationCopy[position + 1] = "0"
                
            //Will run the normal operation
            } else {
            equationCopy[position + 1] = String(Int(equationCopy[position - 1])! % Int(equationCopy[position + 1])!)
            }
            
            // Remove values from string
            equationCopy.remove(at: position)
            equationCopy.remove(at: position - 1)
            position -= 1

        } else {
            position += 1
        }
    }
    
    position = 0
    // Check for '+' & '-' operands
    for value in equationCopy {
        if value == "+" {
            
            equationCopy[position + 1] = String(Int(equationCopy[position - 1])! + Int(equationCopy[position + 1])!)

            // Remove values from string
            equationCopy.remove(at: position)
            equationCopy.remove(at: position - 1)
            position -= 1

        } else if value == "-" {
            equationCopy[position + 1] = String(Int(equationCopy[position - 1])! - Int(equationCopy[position + 1])!)

            // Remove values from string
            equationCopy.remove(at: position)
            equationCopy.remove(at: position - 1)
            position -= 1

        } else {
            position += 1
        }
    }
    
    //Will check if there are more than one integer remaining
    if equationCopy.count > 1 {
        exit(1)
    }
    
    let finalValue = Int(equationCopy[0])!
    return finalValue
}

var userInput = ProcessInfo.processInfo.arguments
userInput.removeFirst() // remove the name of the program
checkEquation(userInput)
print(solve(userInput))
