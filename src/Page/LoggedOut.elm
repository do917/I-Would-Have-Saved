module Page.LoggedOut exposing (..)

import Model
import Html exposing (Html, text, a)
import Html.Attributes exposing (href)
import Update
import Model


ynabURL : Model.Config -> String
ynabURL { ynab_client_id, ynab_redirect_uri } =
    "https://app.youneedabudget.com/oauth/authorize?client_id="
        ++ ynab_client_id
        ++ "&redirect_uri="
        ++ ynab_redirect_uri
        ++ "&response_type=token"


view : Model.Model -> Html Update.Msg
view model =
    a [ href (ynabURL model.config) ] [ text "Login to YNAB" ]