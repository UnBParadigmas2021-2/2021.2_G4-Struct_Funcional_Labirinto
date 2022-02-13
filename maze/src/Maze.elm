module Maze exposing (draw_graph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, width)


graph : Matrix number
graph =
    Matrix.repeat 80 80 1


draw_graph : Matrix a -> List BoxDrawing.Shape
draw_graph m =
    List.range 1 (height m)
        |> List.concatMap
            (\i ->
                List.range 1 (width m)
                    |> List.concatMap
                        (\j ->
                            [ rectangle 6 6 single
                                |> move i j
                            ]
                        )
            )
