module Maze exposing (columns, drawGraph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, unsafeGet, width)
import Random


rows : Int
rows =
    50


columns : Int
columns =
    50


restoDiv : Int -> Int -> Int
restoDiv dividendo divisor =
    if dividendo == 0 || divisor == 1 then
        0

    else if dividendo < divisor then
        dividendo

    else
        restoDiv (dividendo - divisor) divisor


checkDiagonal : Int -> Int -> Bool
checkDiagonal i m =
    let
        r =
            (i - 1) // m

        c =
            restoDiv (i - 1) m
    in
    r == c || r - 1 == c


generator : Random.Generator Int
generator =
    Random.int 0 1


calc : Int -> Int
calc n =
    (n ^ 7) // 777


getSeed : Int -> Random.Seed
getSeed i =
    Random.initialSeed (calc i)


generateList : Int -> List Int
generateList m =
    List.range 1 (m*m)
        |> List.concatMap
            (\i ->
                if checkDiagonal i m then
                    [ 0 ]

                else
                    [ Tuple.first <| Random.step generator (getSeed i) ]
            )


graph : Int -> Matrix Int
graph model =
    Matrix.graphFromList model model (generateList (model))


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
        || (i == sizeGraph && j == sizeGraph-1)


drawGraph : Matrix Int -> Int -> List BoxDrawing.Shape
drawGraph maze sizeGraph =
    List.range 1 (height maze)
        |> List.concatMap
            (\i ->
                List.range 1 (width maze)
                    |> List.concatMap
                        (\j ->
                            if mazeConditional i j sizeGraph  then
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
