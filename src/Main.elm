module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type Msg
    = NewTodoChange String
    | AddTodo
    | RemoveTodo Int
    | ToggleTodo Int Bool


model =
    { lastTodoId = 2
    , todos =
        [ { id = 1, text = "todo 1", done = False }
        , { id = 2, text = "todo 2", done = False }
        ]
    , newTodo = ""
    }


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
        div []
            [ ul []
                (model.todos |> List.map todoView)
            , div []
                [ input
                    [ value model.newTodo
                    , onInput NewTodoChange
                    ]
                    []
                , button
                    [ onClick AddTodo ]
                    [ text "+" ]
                ]
            ]


update msg model =
    case msg of
        NewTodoChange newTodoText ->
            { model | newTodo = newTodoText }

        AddTodo ->
            let
                newTodoId =
                    model.lastTodoId + 1

                newTodo =
                    { id = newTodoId, text = model.newTodo, done = False }

                newModel =
                    { model
                        | todos = model.todos ++ [ newTodo ]
                        , lastTodoId = newTodoId
                        , newTodo = ""
                    }
            in
                if String.length model.newTodo > 0 then
                    newModel
                else
                    model

        RemoveTodo id ->
            let
                notOfId todo =
                    todo.id /= id
            in
                { model | todos = model.todos |> List.filter notOfId }

        ToggleTodo id isDone ->
            let
                changeDoneForId todo =
                    if todo.id == id then
                        { todo | done = isDone }
                    else
                        todo
            in
                { model | todos = model.todos |> List.map changeDoneForId }



-- behold, the main part to glue it all together


main =
    Html.beginnerProgram
        { view = view
        , update = update
        , model = model
        }
