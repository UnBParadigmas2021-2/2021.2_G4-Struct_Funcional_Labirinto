module Maze exposing (draw_graph, graph)

import BoxDrawing exposing (move, rectangle, single)
import Matrix exposing (Matrix, height, width, unsafeGet)
import Random 

rows : Int
rows = 80

columns : Int
columns = 80

size : Int -> Int -> Int
size a b =
    a*b

generator : Random.Generator Int
generator = 
    Random.int 0 1

calc : Int -> Int
calc n = (n^7)//777

get_seed : Int -> Random.Seed
get_seed i = Random.initialSeed (calc i)

generate_list : Int -> List Int
generate_list m =
    List.range 1 m
        |> List.concatMap
            (\i ->
                [ Tuple.first <| Random.step generator (get_seed i)]
            )


graph : Matrix Int
graph =
    Matrix.graphFromList rows columns (generate_list (size rows columns))

infinity : number
infinity = 10000000

border_conditional : Int -> Int -> Bool
border_conditional i j = 
    (i == 1 || j == 1 || i == rows || j == columns)

entrance_conditional: Int -> Int -> Bool
entrance_conditional i j =
    (i == 12 && j == 1)

exit_conditional i j =
    (i == 75  && j == 80)
    
draw_graph : Matrix Int -> List BoxDrawing.Shape
draw_graph m =
    List.range 1 (height m)
        |> List.concatMap
            (\i ->
                List.range 1 (width m)
                    |> List.concatMap
                        (\j ->
                          if entrance_conditional i j  || exit_conditional i j then
                          [ rectangle 0 0 single
                              |> move infinity infinity
                          ]
                          else if (unsafeGet i j m) == 1 || border_conditional i j then
                            [ rectangle 1 1 single
                                |> move j i
                            ]
                          else
                            [ rectangle 0 0 single
                                |> move infinity infinity
                            ]
                        )
            )
