gcloud builds submit --tag gcr.io/fathomapi/first
gcloud beta run deploy first --allow-unauthenticated --image gcr.io/fathomapi/first --platform managed --region us-central1 --memory 500M
