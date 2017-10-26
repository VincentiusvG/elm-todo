module Todo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type Msg
    = RemoveTodo Int
    | ToggleTodo Int Bool


type alias Todo =
    { id : Int
    , text : String
    , done : Bool
    }


view : List Todo -> Html Msg
view model =
    let
        todoClass todo =
            if todo.done then
                "done"
            else
                ""

        todoView todo =
            li
                [ class (todoClass todo)
                , onClick (todo.done |> not |> ToggleTodo todo.id)
                ]
                [ div [] [ text todo.text ]
                , button [ onClick (RemoveTodo todo.id) ] [ text "x" ]
                ]
    in
        ul [] (List.map todoView model)


update : Msg -> List Todo -> List Todo
update msg model =
    case msg of
        RemoveTodo id ->
            let
                notOfId todo =
                    todo.id /= id
            in
                model |> List.filter notOfId

        ToggleTodo id isDone ->
            let
                changeDoneForId todo =
                    if todo.id == id then
                        { todo | done = isDone }
                    else
                        todo
            in
                model |> List.map changeDoneForId
