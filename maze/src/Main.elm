module Main exposing (main)

import BoxDrawing exposing (group, render)
import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Maze exposing (drawGraph, graph)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


convert : Maybe number -> number
convert input =
    case input of
        Just value ->
            value

        Nothing ->
            0


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ placeholder "50", value model.content, onInput Change ] []
            ]
        , Html.pre []
            [ div []
                [ text <|
                    render ( 100, 100 ) <|
                        [ group
                            (drawGraph
                                (graph
                                    (convert (String.toInt model.content))
                                )
                            )
                        ]
                ]
            ]
        ]
