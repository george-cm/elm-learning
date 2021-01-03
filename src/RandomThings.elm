module RandomThings exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random



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
        [ h1 [] [ text (String.fromInt model.dieFace) ]
        , img [ src (getDieFaceUrl model.dieFace) ] []
        , button [ onClick Roll ] [ text "Roll" ]
        ]


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
