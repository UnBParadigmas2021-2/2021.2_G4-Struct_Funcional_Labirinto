module Maze exposing (draw_graph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, width, unsafeGet)


graph : Matrix Int
graph =
    Matrix.graphFromList 4 3 [
        0, 0, 1, 
        1, 1, 0, 
        0, 1, 1, 
        1, 1, 1
    ]

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
