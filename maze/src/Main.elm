module Main exposing (main)

import BoxDrawing exposing (..)
import Matrix exposing (..)
import Maze exposing (graph)


main : Program () () ()
main =
    picture ( 100, 100 ) <|
        [ group
            (List.range 1 (height graph)
                |> List.concatMap
                    (\i ->
                        List.range 1 (width graph)
                            |> List.concatMap
                                (\j ->
                                    [ rectangle 6 6 single
                                        |> move i j
                                    ]
                                )
                    )
            )
        ]
