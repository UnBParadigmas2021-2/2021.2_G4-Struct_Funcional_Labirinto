module Main exposing (main)

import BoxDrawing exposing (group, render)
import Html
import Maze exposing (draw_graph, graph)


main : Html.Html msg
main =
    Html.pre []
        [ Html.text <|
            render ( 100, 100 ) <|
                [ group
                    (draw_graph graph)
                ]
        ]
