module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import KeyDown exposing (..)
import Todo


type Msg
    = NewTodoChange String
    | NewTodoKeyDown Int
    | AddTodo
    | TodoMsg Todo.Msg


type alias Model =
    { lastTodoId : Int
    , newTodo : String
    , todos : List Todo.Todo
    }


model : Model
model =
    { lastTodoId = 2
    , todos =
        [ { id = 1, text = "todo 1", done = False }
        , { id = 2, text = "todo 2", done = False }
        ]
    , newTodo = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ Html.map TodoMsg (Todo.view model.todos)
        , div []
            [ input
                [ value model.newTodo
                , onInput NewTodoChange
                , onKeyDown NewTodoKeyDown
                ]
                []
            , button
                [ onClick AddTodo ]
                [ text "+" ]
            ]
        ]


update : Msg -> Model -> Model
update msg model =
    let
        addTodo model =
            if String.length model.newTodo > 0 then
                let
                    newTodoId =
                        model.lastTodoId + 1

                    newTodo =
                        { id = newTodoId, text = model.newTodo, done = False }
                in
                    { model
                        | todos = model.todos ++ [ newTodo ]
                        , lastTodoId = newTodoId
                        , newTodo = ""
                    }
            else
                model
    in
        case msg of
            NewTodoChange newTodoText ->
                { model | newTodo = newTodoText }

            AddTodo ->
                addTodo model

            NewTodoKeyDown keyCode ->
                if keyCode == 13 then
                    addTodo model
                else
                    model

            TodoMsg todoMsg ->
                { model | todos = Todo.update todoMsg model.todos }



-- behold, the main part to glue it all together


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { view = view
        , update = update
        , model = model
        }
