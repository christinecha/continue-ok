import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String

main =
  StartApp.start { model = model, view = view, update = update }

model =
  { num1 = 0
  , num2 = 1
  , adder = ""
  }

view address model =
  div []
    [ button [ onClick address Add1 ] [ text "add 1" ]
    , input
        [ value model.adder
        , on "input" targetValue (\string -> Signal.message address (UpdateAddX string))
        ]
        []
    , button [ onClick address AddX ] [ text "add X" ]
    , text (toString model.num1 ++ " " ++ toString model.num2)
    ]

type Action
  = Add1
  | AddX
  | UpdateAddX (String)

update action model =
  case action of
    Add1 ->
      { model | num1 = model.num1 + 1 }
    AddX ->
      { model | num1 = model.num1 + Result.withDefault 0 (String.toInt model.adder) }
    UpdateAddX adder ->
      { model | adder = adder }
