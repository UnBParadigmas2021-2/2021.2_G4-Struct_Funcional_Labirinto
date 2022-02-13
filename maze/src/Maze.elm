module Maze exposing (draw_graph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, width, unsafeGet)


graph : Matrix number
graph =
    Matrix.repeat 80 80 1


draw_graph : Matrix number -> List BoxDrawing.Shape
draw_graph m =
    List.range 1 (height m)
        |> List.concatMap
            (\i ->
                List.range 1 (width m)
                    |> List.concatMap
                        (\j ->
                          if (unsafeGet i j m) == 1 then
                            [ rectangle 6 6 single
                                |> move i j
                            ]
                          else
                            [ rectangle 0 0 single
                                |> move 0 0
                            ]
                        )
            )
