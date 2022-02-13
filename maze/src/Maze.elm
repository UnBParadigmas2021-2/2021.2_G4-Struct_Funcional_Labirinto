module Maze exposing (draw_graph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, width, unsafeGet)

rows : Int
rows = 4

columns : Int
columns = 3

size : Int -> Int -> Int
size a b =
    a*b


generate_list : Int -> List Int
generate_list m =
    List.range 1 m
        |> List.concatMap
            (\i ->
                [1]
            )


graph : Matrix Int
graph =
    Matrix.graphFromList rows columns (generate_list (size rows columns))

infinity : number
infinity = 10000000

draw_graph : Matrix Int -> List BoxDrawing.Shape
draw_graph m =
    List.range 1 (height m)
        |> List.concatMap
            (\i ->
                List.range 1 (width m)
                    |> List.concatMap
                        (\j ->
                          if (unsafeGet i j m) == 1 then
                            [ rectangle 1 1 single
                                |> move j i
                            ]
                          else
                            [ rectangle 0 0 single
                                |> move infinity infinity
                            ]
                        )
            )
