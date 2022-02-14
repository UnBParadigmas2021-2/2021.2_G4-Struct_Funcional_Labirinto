module Main exposing (main)

import BoxDrawing exposing (group, render)
import Html
import Maze exposing (drawGraph, graph)


main : Html.Html msg
main =
    Html.pre []
        [ Html.text <|
            render ( 100, 100 ) <|
                [ group
                    (drawGraph graph)
                ]
        ]
