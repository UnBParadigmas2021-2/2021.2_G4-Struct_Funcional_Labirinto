module Main exposing (main)

import BoxDrawing exposing (group, render)
import Html
import Maze exposing (drawGraph, graph, rows, columns)


main : Html.Html msg
main =
    Html.pre []
        [ Html.text <|
            render ( rows, columns ) <|
                [ group
                    (drawGraph graph)
                ]
        ]
