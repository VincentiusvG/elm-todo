module Main exposing (..)

import Html exposing (..)


--should be useful in a few minutes:
--import Html.Attributes exposing (..)
--import Html.Events exposing (..)


type Msg
    = WhaitWutNoMessageHere


model : { data : String }
model =
    { data = "world"
    }


view : { a | data : String } -> Html msg
view model =
    --say hello
    text ("Hello " ++ model.data)


update : a -> b -> b
update msg model =
    --update does not change model
    model



-- behold, the main part to glue it all together


main : Program Never { data : String } msg
main =
    Html.beginnerProgram
        { view = view
        , update = update
        , model = model
        }
