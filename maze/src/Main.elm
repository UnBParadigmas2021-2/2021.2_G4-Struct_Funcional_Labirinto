module Main exposing (main)

import BoxDrawing exposing (..)
import Maze exposing (graph)


main : Program () () ()
main =
    picture ( 50, 50 ) <|
        List.map
            (\x ->
                group
                    (List.map
                        (\y ->
                            rectangle 6 6 single
                                |> move (Tuple.first y) (Tuple.second y)
                        )
                        x
                    )
            )
            graph
