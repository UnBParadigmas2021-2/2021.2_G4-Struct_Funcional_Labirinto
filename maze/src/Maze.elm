module Maze exposing (drawGraph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, unsafeGet, width)
import Random


remainder : Int -> Int -> Int
remainder dividend divisor =
    if dividend == 0 || divisor == 1 then
        0

    else if dividend < divisor then
        dividend

    else
        remainder (dividend - divisor) divisor


checkDiagonal : Int -> Int -> Bool
checkDiagonal i size =
    let
        row =
            (i - 1) // size

        column =
            remainder (i - 1) size
    in
    row == column || row - 1 == column


generator : Random.Generator Int
generator =
    Random.int 0 1


calc : Int -> Int
calc i =
    (i ^ 7) // 777


getSeed : Int -> Random.Seed
getSeed i =
    Random.initialSeed (calc i)


generateList : Int -> List Int
generateList size =
    List.range 1 (size * size)
        |> List.concatMap
            (\i ->
                if checkDiagonal i size then
                    [ 0 ]

                else
                    [ Tuple.first <| Random.step generator (getSeed i) ]
            )


graph : Int -> Matrix Int
graph size =
    Matrix.graphFromList size size (generateList size)


infinity : number
infinity =
    10000000


borderConditional : Int -> Int -> Int -> Bool
borderConditional i j sizeGraph =
    i == 1 || j == 1 || i == sizeGraph || j == sizeGraph


mazeConditional : Int -> Int -> Int -> Bool
mazeConditional i j sizeGraph =
    (i == 1 && j == 1)
        || (i == 1 && j == 2)
        || (i == sizeGraph && j == sizeGraph)
        || (i == sizeGraph && j == sizeGraph - 1)


drawGraph : Matrix Int -> Int -> List BoxDrawing.Shape
drawGraph maze sizeGraph =
    List.range 1 (height maze)
        |> List.concatMap
            (\i ->
                List.range 1 (width maze)
                    |> List.concatMap
                        (\j ->
                            if mazeConditional i j sizeGraph then
                                [ rectangle 0 0 single
                                    |> move infinity infinity
                                ]

                            else if unsafeGet i j maze == 1 || borderConditional i j sizeGraph then
                                [ rectangle 1 1 single
                                    |> move j i
                                ]

                            else
                                [ rectangle 0 0 single
                                    |> move infinity infinity
                                ]
                        )
            )