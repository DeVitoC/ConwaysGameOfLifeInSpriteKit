//
//  GameScene.swift
//  SpriteKitConwayGOL
//
//  Created by Christopher Devito on 6/29/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {

    let settings = SettingsController.shared
    var numRows: Int
    var numCols: Int
    var currentGameBoard: [[Int]] = []
    var inactiveGameBoard: [[Int]] = []
    var didQuit = false

    override init(size: CGSize) {
        numRows = (Int(size.height) - Int(settings.tabBarHeight))/settings.cellSize
        numCols = (Int(size.width) - 5)/settings.cellSize
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        self.removeAllChildren()
        self.removeAllActions()
        setupGameboards()
        setBoard(view: view)
        drawBoard()
        print("numRows: \(numRows), numCols: \(numCols)")
    }

    override func update(_ currentTime: TimeInterval) {
        alternateBoards()
        drawBoard()
    }

    private func setupGameboards() {
        currentGameBoard = create2DBoard()
        inactiveGameBoard = create2DBoard()
    }

    private func create2DBoard() -> [[Int]] {
        var board: [[Int]] = []
        for _ in 0..<numRows {
            let rowArray = Array(repeating: 0, count: numCols)
            board.append(rowArray)
        }
        return board
    }

    private func setBoard(view: SKView) {
        if settings.preset == "Random" {
            for row in 0..<numRows {
                for col in 0..<numCols {
                    let cell = [0, 1].randomElement()!
                    currentGameBoard[row][col] = cell
                }
            }
        } else if settings.preset == "Gosper Glider Gun" {
            gosperGlider()
        } else if settings.preset == "Still Lifes" {
            stillLifes()
        } else if settings.preset == "Oscillators" {
            oscillators()
        } else if settings.preset == "Spaceships" {
            spaceships()
        }
    }

    private func drawBoard() {
        removeAllChildren()
        for row in 0..<numRows {
            for col in 0..<numCols {
                let color: SKColor = currentGameBoard[row][col] == 1 ? settings.liveCellColor : settings.deadCellColor
                drawCircle(withRadius: CGFloat(settings.cellSize/2),
                           atCol: CGFloat(col * settings.cellSize),
                           atRow: CGFloat(row * settings.cellSize),
                           color: color)
            }
        }
    }

    private func drawCircle(withRadius radius: CGFloat, atCol x: CGFloat, atRow y: CGFloat, color: SKColor = .systemTeal) {
        let Circle = SKShapeNode(circleOfRadius: radius ) // Size of Circle
        Circle.position = CGPoint(x: x + 10, y: y + settings.tabBarHeight + 10)
        Circle.fillColor = color
        self.addChild(Circle)
    }

    func alternateBoards() {
        for row in 0..<numRows {
            for col in 0..<numCols {
                let nextCellState = checkSurroundingCells(row, col)
                inactiveGameBoard[row][col] = nextCellState
            }
        }
        swap(&currentGameBoard, &inactiveGameBoard)
    }

    func checkSurroundingCells(_ rowNum: Int, _ colNum: Int) -> Int {
        if settings.preset == "Gosper Glider Gun" && (colNum == numCols - 1 || rowNum == numRows - 1) {
            return 0
        }
        let prevCol = setPrevCol(col: colNum)
        let nextCol = setNextCol(col: colNum)
        let prevRow = setPrevRow(row: rowNum)
        let nextRow = setNextRow(row: rowNum)

        var numAliveNeighbors = 0
        var currentCellValue = 0
        for row in [prevRow, rowNum, nextRow] {
            for col in [prevCol, colNum, nextCol] {
                if col == colNum && row == rowNum {
                    currentCellValue = currentGameBoard[row][col]
                } else if currentGameBoard[row][col] == 1 {
                    numAliveNeighbors += 1
                }
            }
        }
        return testAliveState(currentCell: currentCellValue, numAliveNeighbors: numAliveNeighbors)
    }

    func setPrevCol(col: Int) -> Int {
        if col == 0 {
            return numCols - 1
        } else {
            return col - 1
        }
    }

    func setNextCol(col: Int) -> Int {
        if col == numCols - 1 {
            return 0
        } else {
            return col + 1
        }
    }

    func setPrevRow(row: Int) -> Int {
        if row == 0 {
            return numRows - 1
        } else {
            return row - 1
        }
    }

    func setNextRow(row: Int) -> Int {
        if row == numRows - 1 {
            return 0
        } else {
            return row + 1
        }
    }

    func testAliveState(currentCell: Int, numAliveNeighbors: Int) -> Int {
        if numAliveNeighbors > 3 || numAliveNeighbors < 2 { // dead state
            return 0
        } else if (currentCell == 0 && numAliveNeighbors == 3) || currentCell == 1 { // alive state
            return 1
        } else { // dead state
            return 0
        }
    }

    func gosperGlider() {
        // Gosper Glider Gun
        currentGameBoard[26][2] = 1

        currentGameBoard[24][3] = 1
        currentGameBoard[26][3] = 1

        currentGameBoard[14][4] = 1
        currentGameBoard[15][4] = 1
        currentGameBoard[22][4] = 1
        currentGameBoard[23][4] = 1
        currentGameBoard[36][4] = 1
        currentGameBoard[37][4] = 1

        currentGameBoard[13][5] = 1
        currentGameBoard[17][5] = 1
        currentGameBoard[22][5] = 1
        currentGameBoard[23][5] = 1
        currentGameBoard[36][5] = 1
        currentGameBoard[37][5] = 1

        currentGameBoard[2][6] = 1
        currentGameBoard[3][6] = 1
        currentGameBoard[12][6] = 1
        currentGameBoard[18][6] = 1
        currentGameBoard[22][6] = 1
        currentGameBoard[23][6] = 1

        currentGameBoard[2][7] = 1
        currentGameBoard[3][7] = 1
        currentGameBoard[12][7] = 1
        currentGameBoard[16][7] = 1
        currentGameBoard[18][7] = 1
        currentGameBoard[19][7] = 1
        currentGameBoard[24][7] = 1
        currentGameBoard[26][7] = 1

        currentGameBoard[12][8] = 1
        currentGameBoard[18][8] = 1
        currentGameBoard[26][8] = 1

        currentGameBoard[13][9] = 1
        currentGameBoard[17][9] = 1

        currentGameBoard[14][10] = 1
        currentGameBoard[15][10] = 1
    }

    func stillLifes() {
        // Block
        currentGameBoard[12][12] = 1
        currentGameBoard[12][13] = 1
        currentGameBoard[13][12] = 1
        currentGameBoard[13][13] = 1

        // Bee-hive
        currentGameBoard[16][13] = 1
        currentGameBoard[16][14] = 1
        currentGameBoard[17][12] = 1
        currentGameBoard[17][15] = 1
        currentGameBoard[18][13] = 1
        currentGameBoard[18][14] = 1

        // Loaf
        currentGameBoard[21][13] = 1
        currentGameBoard[21][14] = 1
        currentGameBoard[22][12] = 1
        currentGameBoard[22][15] = 1
        currentGameBoard[23][13] = 1
        currentGameBoard[23][15] = 1
        currentGameBoard[24][14] = 1

        // Boat
        currentGameBoard[27][12] = 1
        currentGameBoard[27][13] = 1
        currentGameBoard[28][12] = 1
        currentGameBoard[28][14] = 1
        currentGameBoard[29][13] = 1

        // Tub
        currentGameBoard[32][13] = 1
        currentGameBoard[33][12] = 1
        currentGameBoard[33][14] = 1
        currentGameBoard[34][13] = 1
    }

    func oscillators() {
        // Blinker
        for col in 12...14 {
            currentGameBoard[2][col] = 1
        }

        // Toad
        for col in 13...15 {
            currentGameBoard[7][col] = 1
        }
        for col in 12...14 {
            currentGameBoard[8][col] = 1
        }

        // Beacon
        currentGameBoard[14][12] = 1
        currentGameBoard[14][13] = 1
        currentGameBoard[15][12] = 1
        currentGameBoard[15][13] = 1
        currentGameBoard[16][14] = 1
        currentGameBoard[16][15] = 1
        currentGameBoard[17][14] = 1
        currentGameBoard[17][15] = 1

        // Pulsar
        for col in 9...11 {
            currentGameBoard[24][col] = 1
            currentGameBoard[29][col] = 1
            currentGameBoard[31][col] = 1
            currentGameBoard[36][col] = 1
        }
        for col in 15...17 {
            currentGameBoard[24][col] = 1
            currentGameBoard[29][col] = 1
            currentGameBoard[31][col] = 1
            currentGameBoard[36][col] = 1
        }
        for row in 26...28 {
            currentGameBoard[row][7] = 1
            currentGameBoard[row][12] = 1
            currentGameBoard[row][14] = 1
            currentGameBoard[row][19] = 1
        }
        for row in 32...34 {
            currentGameBoard[row][7] = 1
            currentGameBoard[row][12] = 1
            currentGameBoard[row][14] = 1
            currentGameBoard[row][19] = 1
        }
    }

    func spaceships() {
        // Light-weight Spaceship
        currentGameBoard[13][5] = 1
        currentGameBoard[13][6] = 1
        currentGameBoard[14][3] = 1
        currentGameBoard[14][4] = 1
        currentGameBoard[14][6] = 1
        currentGameBoard[14][7] = 1
        for col in 3...6 {
            currentGameBoard[15][col] = 1
        }
        currentGameBoard[16][4] = 1
        currentGameBoard[16][5] = 1

        // Middle-weight Spaceship
        for col in 4...8 {
            currentGameBoard[21][col] = 1
        }
        currentGameBoard[22][3] = 1
        currentGameBoard[22][8] = 1
        currentGameBoard[23][8] = 1
        currentGameBoard[24][3] = 1
        currentGameBoard[24][7] = 1
        currentGameBoard[25][5] = 1

        // Heavy-weight Spaceship
        currentGameBoard[30][7] = 1
        currentGameBoard[30][8] = 1
        for col in 3...6 {
            currentGameBoard[31][col] = 1
        }
        currentGameBoard[31][8] = 1
        currentGameBoard[31][9] = 1
        for col in 3...8 {
            currentGameBoard[32][col] = 1
        }
        for col in 4...7 {
            currentGameBoard[33][col] = 1
        }
    }
}
