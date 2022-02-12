module Main exposing (main)

import BoxDrawing exposing (..)


graph : List (List ( number, number ))
graph =
    [ [ ( 1, 1 ), ( 1, 2 ), ( 1, 3 ), ( 1, 4 ) ]
    , [ ( 2, 1 ), ( 2, 2 ), ( 2, 3 ), ( 2, 4 ) ]
    , [ ( 3, 1 ), ( 3, 2 ), ( 3, 3 ), ( 3, 4 ) ]
    , [ ( 4, 1 ), ( 4, 2 ), ( 4, 3 ), ( 4, 4 ) ]
    ]


main : Program () () ()
main =
    picture ( 50, 50 ) <|
        List.map
            (\x ->
                group
                    (List.map
                        (\y ->
                            rectangle 1 1 single
                                |> move (Tuple.first y) (Tuple.second y)
                        )
                        x
                    )
            )
            graph
