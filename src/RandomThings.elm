module RandomThings exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { dieFace : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text (String.fromInt model.dieFace) ]
        , img [ src (getDieFaceUrl model.dieFace), Html.Attributes.style "display" "block" ] []
        , button [ onClick Roll, Html.Attributes.style "display" "block" ] [ Html.text "Roll" ]
        , getSvgDieFace model.dieFace
        ]


getSvgDieFace : Int -> Html msg
getSvgDieFace dieFaceNum =
    let
        side : Int
        side =
            100

        xpos : Int
        xpos =
            10

        ypos : Int
        ypos =
            10
    in
    svg
        [ Svg.Attributes.width "120"
        , Svg.Attributes.height "120"
        , viewBox "0 0 120 120"
        ]
        (rect
            [ x (String.fromInt xpos)
            , y (String.fromInt ypos)
            , Svg.Attributes.width (String.fromInt side)
            , Svg.Attributes.height (String.fromInt side)
            , rx "15"
            , ry "15"
            , stroke "black"
            , fill "white"
            ]
            []
            :: (case dieFaceNum of
                    1 ->
                        [ circle
                            [ cx (String.fromInt (xpos + side // 2))
                            , cy (String.fromInt (ypos + side // 2))
                            , r "20"
                            , fill "red"
                            ]
                            []
                        ]

                    2 ->
                        [ circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        ]

                    3 ->
                        [ circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 2)))
                            , cy (String.fromInt (ypos + 1 * (side // 2)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        ]

                    4 ->
                        [ circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        ]

                    5 ->
                        [ circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 2)))
                            , cy (String.fromInt (ypos + 1 * (side // 2)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        ]

                    6 ->
                        [ circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 3 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 4)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 2)))
                            , cy (String.fromInt (ypos + 1 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        , circle
                            [ cx (String.fromInt (xpos + 1 * (side // 2)))
                            , cy (String.fromInt (ypos + 3 * (side // 4)))
                            , r "10"
                            , fill "black"
                            ]
                            []
                        ]

                    _ ->
                        []
               )
        )


getDieFaceUrl : Int -> String
getDieFaceUrl dieFaceNum =
    case dieFaceNum of
        1 ->
            "/images/1_dot.png"

        2 ->
            "/images/2_dots.png"

        3 ->
            "/images/3_dots.png"

        4 ->
            "/images/4_dots.png"

        5 ->
            "/images/5_dots.png"

        6 ->
            "/images/6_dots.png"

        _ ->
            ""



-- if dieFaceNum == 1 then
--     "/images/1_dot.png"
-- else if dieFaceNum == 2 then
--     "/images/2_dots.png"
-- else if dieFaceNum == 3 then
--     "/images/3_dots.png"
-- else if dieFaceNum == 4 then
--     "/images/4_dots.png"
-- else if dieFaceNum == 5 then
--     "/images/5_dots.png"
-- else
--     "/images/6_dots.png"
