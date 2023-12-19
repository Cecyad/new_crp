import sys
import os
import pymsteams

def send_notification():
    PROJECT_TRIBE=os.getenv('TRIBE')
    PROJECT_TYPE=os.getenv('PROJECT_TYPE')
    PATH_DEVELOPMENT_VAULT=os.getenv('PATH_DEVELOPMENT_VAULT')
    PATH_STAGING_VAULT=os.getenv('PATH_STAGING_VAULT')
    PATH_PRODUCTION_VAULT=os.getenv('PATH_PRODUCTION_VAULT')
    PATH_REPOSITORY=sys.argv[1]
    DSN_SENTRY_PROJECT=sys.argv[2] if PROJECT_TYPE != " " else None

    webhook = {
      "notification": "https://uas.webhook.office.com/webhookb2/d4b00fe0-5896-4179-82da-be3cac82bc87@93b172be-ebbf-4603-9dce-88e2e9ac421a/IncomingWebhook/3c16c014307042ab86499fe5362923ef/5d4e989f-fe44-4686-b589-1c44eff7a20c",
    }

    teamsConnector = pymsteams.connectorcard(webhook.get(PROJECT_TRIBE,"Tribe not found"))
    teamsConnector.title(f"<b>Repository Information</b>")
    if PROJECT_TYPE == " ":
        teamsConnector.text(f"<b>Path repository</b>  <br> {PATH_REPOSITORY}")
    else:
        teamsConnector.text(f"<b>Path repository</b>  <br> {PATH_REPOSITORY} <br> <br> <b>DSN Sentry project</b> <br> {DSN_SENTRY_PROJECT} <br> <br> <b>Path development vault</b> <br> {PATH_DEVELOPMENT_VAULT} <br> <br> <b>Path staging vault</b> <br> {PATH_STAGING_VAULT} <br> <br> <b>Path production vault</b> <br> {PATH_PRODUCTION_VAULT}")
    teamsConnector.send()

if __name__ == "__main__":
    send_notification()