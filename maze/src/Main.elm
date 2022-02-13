module Main exposing (main)

import BoxDrawing exposing (group, picture)
import Maze exposing (draw_graph, graph)


main : Program () () ()
main =
    picture ( 100, 100 ) <|
        [ group
            (draw_graph graph)
        ]
