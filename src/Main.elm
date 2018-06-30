module Main exposing (..)

import Navigation
import Router
import Model
import Update exposing (Msg(..))
import View
import Task
import RemoteData
import DatePicker


init : Model.Config -> Navigation.Location -> ( Model.Model, Cmd Update.Msg )
init config location =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init
                |> Tuple.mapSecond (Cmd.map SetDatePicker)

        ( page, token, cmd ) =
            case Router.parseLocation location of
                Just Router.LoggedOut ->
                    ( Model.LoggedOut, Nothing, Cmd.none )

                Just (Router.Loading maybeToken) ->
                    ( Model.Loading "Loading Budgets..."
                    , maybeToken
                    , (send FetchBudgets)
                    )

                Nothing ->
                    ( Model.Error Model.InvalidRoute, Nothing, Cmd.none )
    in
        ( { config = config
          , page = page
          , token = token
          , transactions = RemoteData.NotAsked
          , budgets = RemoteData.NotAsked
          , filters = Model.emptyFilters
          , datePicker = datePicker
          }
        , Cmd.batch [ cmd, datePickerCmd ]
        )


main =
    Navigation.programWithFlags (always NoOp)
        { view = View.view
        , init = init
        , update = Update.update
        , subscriptions = always Sub.none
        }


send : msg -> Cmd msg
send msg =
    Task.succeed msg
        |> Task.perform identity
