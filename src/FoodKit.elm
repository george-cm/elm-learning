module FoodKit exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Regex
import String exposing (lines)
import Dict exposing (Dict)


-- MAIN


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



--  MODEL


type alias Model =
    { orderDate : String
    , input1 : String
    , name1 : String 
    , input2 : String 
    , name2 : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { orderDate = ""
    , input1 = ""
    , name1 = ""
    , input2 = ""
    , name2 = "" }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ChangeInput1 String
    | ChangeInput2 String
    | ChangeOrderDate String
    | ChangeName1 String
    | ChangeName2 String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeInput1 newContent ->
            ( { model | input1 = newContent}
            , Cmd.none
            )
        
        ChangeInput2 newContent ->
            ( { model | input2 = newContent}
            , Cmd.none
            )

        ChangeOrderDate newDate ->
            ( { model | orderDate = newDate }
            , Cmd.none
            )

        ChangeName1 newName ->
            ( { model | name1 = newName }
            , Cmd.none
            )
        ChangeName2 newName ->
            ( { model | name2 = newName }
            , Cmd.none
            )

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        colsNo = 120
        rowsNo = 27
    in
    div[]
        [h1 [] [ Html.text "FoodKit Order Processor" ]
        , div [] [ input [type_ "text", placeholder "Input date yyyy/mm/dd", value model.orderDate, onInput ChangeOrderDate ] []
        , input [type_ "text", placeholder "Name", value model.name1, onInput ChangeName1 ] []]
        , div [] [ textarea [Html.Events.onInput ChangeInput1, Html.Attributes.cols colsNo, Html.Attributes.rows rowsNo] [ Html.text model.input1 ]
        , textarea [Html.Attributes.cols colsNo, Html.Attributes.rows rowsNo] [ Html.text (String.join "\n" (createOutput model 1 (createOutput2 (processInput model.input1))))]]
        , div [] [ input [type_ "text", placeholder "Name", value model.name2, onInput ChangeName2 ][]]
        , div [] [ textarea [Html.Events.onInput ChangeInput2, Html.Attributes.cols colsNo, Html.Attributes.rows rowsNo] [ Html.text model.input2 ]
        , textarea [Html.Attributes.cols colsNo, Html.Attributes.rows rowsNo] [ Html.text (String.join "\n" (createOutput model 2 (diffInputs model.input1 model.input2)))]]
        ]


diffInputs : String -> String -> List String
diffInputs input1 input2=
    let
        input1List = createOutput2 (processInput input1)
        d1 = buildDict Dict.empty input1List
        input2List = createOutput2 (processInput input2)
        d2 = buildDict Dict.empty input2List

        partialFinalCount = finalCount d1 d2
        diffList = List.concat (List.map (\x -> List.repeat (partialFinalCount x) x) (Dict.keys d2))
        -- diffList = List.map (\x -> (String.fromInt (Maybe.withDefault 0 (Dict.get x d2))) ++ "\t" ++ x) (Dict.keys d2)
        -- diffList = Dict.keys d2
    in
    diffList

finalCount : Dict String Int -> Dict String Int -> String -> Int
finalCount dict1 dict2 k =
    let
        d1count = Maybe.withDefault 0 (Dict.get k dict1)
        d2count = Maybe.withDefault 0 (Dict.get k dict2)
    in
    d2count - d1count
    


buildDict : Dict String Int -> List String -> Dict String Int
buildDict d lines =
    case lines of
        x :: xs ->
            if not (Dict.member x d) then
                buildDict (Dict.insert x (countElemOccurance x lines) d) xs
            else
                buildDict d xs
        [] ->
            d

countElemOccurance : String -> List String -> Int
countElemOccurance elem list =
    case list of
       x :: xs ->
            if x == elem then
                1 + (countElemOccurance elem xs)
            else 
                0 + (countElemOccurance elem xs)
       [] -> 
            0


processInput : String -> List String
processInput input =
    let
        pattern = "^(.*)\\t(?=\\1)"

        options = {caseInsensitive = False, multiline = True}
        
        maybeRegex = Regex.fromStringWith options pattern

        regex = Maybe.withDefault Regex.never maybeRegex
        noDuplicates = Regex.replace regex (\_ -> "") input

        pattern2 = "(.*)\\n+(?=(SUPE|ALEGE-TI MESELE|MIX & MATCH|MESE))"

        maybeRegex2 = Regex.fromStringWith options pattern2

        regex2 = Maybe.withDefault Regex.never maybeRegex2

        extendedLines = Regex.replace regex2 (\m ->(get1stMatch m) ++ "\t") noDuplicates

        lines = String.split "\n" extendedLines
    in
    lines


get1stMatch : Regex.Match -> String
get1stMatch match =
    case match.submatches of        
        firstMatch :: _-> Maybe.withDefault "" firstMatch
        _ -> ""


getBuc : String -> Maybe Int
getBuc line =
    let
        segments = String.split "\t" line
        thirdSegment = Maybe.withDefault "" (List.head (List.drop 2 segments))
        buc = String.toInt (String.replace " buc" "" thirdSegment)
    in
    buc

removeExtraColumns : List String -> String
removeExtraColumns lineSegments =
    case (List.take 2 lineSegments) of
        lst ->
            String.join "\t" lst


createOutput2 : List String -> List String
createOutput2 lines = 
    case lines of 
        x :: xs ->
            case (getBuc x) of
                Just n ->
                    List.repeat n (removeExtraColumns (String.split "\t" x)) ++ (createOutput2 xs)
                Nothing ->
                    List.singleton (removeExtraColumns (String.split "\t" x)) ++ (createOutput2 xs)
        [] -> 
            []

createOutput : Model -> Int -> List String -> List String
createOutput model m lines =
    let
        name = 
            case m of
                1 -> model.name1
                2 -> model.name2
                _ -> ""
    in
    case lines of 
        x :: xs ->
            List.singleton (model.orderDate ++ "\t" ++ name ++ "\t" ++  x) ++ (createOutput model m xs)            
        [] -> 
            []