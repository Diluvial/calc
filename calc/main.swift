//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

class mathEquation {
    var equation: [String]
    
    init(equation: [String]) {
        self.equation = equation
    }
    
    //Check the users input for errors before calculated
    func checkEquation() {
        var position: Int = 0
        
        //Will check if the input can be calculated
        if equation.count <= 0 {
            print("There are no values in your input")
            exit(1)
        }
        
        //Begins or ends with an integer
        if equation[0] == "/" || equation[0] == "x" || equation[0] == "%" || equation[0] == "+" || equation[0] == "-" {
            print("You must begin the equation with an integer")
            exit(1)
        }
        if equation[equation.count - 1] == "/" || equation[equation.count - 1] == "x" || equation[equation.count - 1] == "%" || equation[equation.count - 1] == "+" || equation[equation.count - 1] == "-" {
            print("You must end the equation with an integer")
            exit(1)
        }
        
        //Check the Integers entered are legitimate
        for value in equation {
            if value != "/" && value != "x" && value != "%" && value != "+" && value != "-" {
                if let _ = Int(value) {
                    position += 1
                } else {
                    print("You must enter an integer")
                    exit(1)
                }
            }
        }
        
        //Will check to see if there are two equations running consectutive to each other
        position = 0
        for value in equation {
            if value == "/" || value == "x" || value == "%" || value == "+" || value == "-" {
                if equation[position + 1] == "/" || equation[position + 1] == "x" || equation[position + 1] == "%" || equation[position + 1] == "+" || equation[position + 1] == "-"{
                    print("You cannot have two equations running consectutive to each other")
                    exit(1)
                }
                position += 1
            } else {
                position += 1
            }
        }
    }
    
    //Performs the calculation
    func calculate() {
        var position: Int = 0
        
        //Function to remove values from string
        func removePositions() {
            equation.remove(at: position)
            equation.remove(at: position - 1)
            position -= 1
        }
        
        //Check for '/' operands
        for value in equation {
            if value == "/" {
                //Will check if being devided by zero
                if equation[position + 1] == "0" {
                    print("You cannot devide by zero")
                    exit(1)
                } else if equation[position - 1] == "0" {
                    equation[position + 1] = "0"
                //Will run the normal operation
                } else {
                    equation[position + 1] = String(Int(equation[position - 1])! / Int(equation[position + 1])!)
                }
                //Remove values from string
                removePositions()
            } else {
                position += 1
            }
        }
        
        position = 0
        //Check for 'x' operands
        for value in equation {
            if value == "x" {
                equation[position + 1] = String(Int(equation[position - 1])! * Int(equation[position + 1])!)
                //Remove values from string
                removePositions()
            } else {
                position += 1
            }
        }
        
        position = 0
        //Check for '%' operands
        for value in equation {
            if value == "%" {
                //Will check if being mod by zero
                if equation[position + 1] == "0" {
                    print("You cannot mod by zero")
                    exit(1)
                } else if equation[position - 1] == "0" {
                    equation[position + 1] = "0"
                //Will run the normal operation
                } else {
                    equation[position + 1] = String(Int(equation[position - 1])! % Int(equation[position + 1])!)
                }
                //Remove values from string
                removePositions()
            } else {
                position += 1
            }
        }
        
        position = 0
        //Check for '+' & '-' operands
        for value in equation {
            if value == "+" {
                equation[position + 1] = String(Int(equation[position - 1])! + Int(equation[position + 1])!)
                //Remove values from string
                removePositions()
            } else if value == "-" {
                equation[position + 1] = String(Int(equation[position - 1])! - Int(equation[position + 1])!)
                //Remove values from string
                removePositions()
            } else {
                position += 1
            }
        }
        
        //Will check if there are more than one integer remaining
        if equation.count > 1 {
            print("Calcualtion cannot be complete, as missing an equation between two numbers")
            exit(1)
        }
        //Prints out the final value as an integer
        print(Int(equation[0])!)
    }
}

//Reads the users input
var userInput = ProcessInfo.processInfo.arguments
userInput.removeFirst() // remove the name of the program

//Creates an instance of the class mathEquation and executes it
let equation = mathEquation(equation: userInput)
equation.checkEquation()
equation.calculate()
