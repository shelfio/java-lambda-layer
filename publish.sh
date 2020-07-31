#!/usr/bin/env bash

LAYER_NAME='java'
LAYER_VERSION=1
BUCKET_NAME=shelf-lambda-layers-"$TARGET_REGION"

aws s3 cp ./java.zip s3://"$BUCKET_NAME"/java.zip

LAYER_VERSION=$(
  aws lambda publish-layer-version --region "$TARGET_REGION" \
    --layer-name $LAYER_NAME \
    --content S3Bucket="$BUCKET_NAME",S3Key=java.zip \
    --description "Java 8" \
    --query Version \
    --output text
)

aws lambda add-layer-version-permission \
  --region "$TARGET_REGION" \
  --layer-name $LAYER_NAME \
  --statement-id sid1 \
  --action lambda:GetLayerVersion \
  --principal '*' \
  --query Statement \
  --output text \
  --version-number "$LAYER_VERSION"
