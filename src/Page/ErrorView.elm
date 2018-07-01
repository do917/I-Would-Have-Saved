module Page.ErrorView exposing (view)

import Html exposing (..)
import Model exposing (ErrorType(..))
import Update


view : ErrorType -> Html Update.Msg
view error =
    div []
        [ h2 [] [ text "I Would Have Saved..." ]
        , parseError error
        ]


parseError : ErrorType -> Html Update.Msg
parseError errorType =
    case errorType of
        NoAccessToken ->
            text "Could not find access token. Try connecting to YNAB again."

        ApiDown error ->
            let
                _ =
                    Debug.log "api error" error
            in
                text "We're having trouble contacting YNAB. Try connecting to YNAB again."

        InvalidRoute ->
            text "Something in your browser is funky. Try connecting to YNAB again."

        ImpossibleState ->
            text "How did you get here?!?!"
