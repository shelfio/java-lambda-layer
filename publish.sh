#!/usr/bin/env bash

aws configure set default.region "$TARGET_REGION" --profile default

LAYER_NAME='java'
LAYER_DESCRIPTION="Java 8"
S3_BUCKET_NAME=shelf-lambda-layers-"$TARGET_REGION"
FILENAME="java.zip"

aws s3 cp ./"$FILENAME" s3://"$S3_BUCKET_NAME"/"$FILENAME"

aws lambda add-layer-version-permission \
  --region "$TARGET_REGION" \
  --layer-name "$LAYER_NAME" \
  --statement-id sid1 \
  --action lambda:GetLayerVersion \
  --principal '*' \
  --version-number "$(
    aws lambda publish-layer-version \
      --region "$TARGET_REGION" \
      --layer-name "$LAYER_NAME" \
      --description "$LAYER_DESCRIPTION" \
      --query Version \
      --output text \
      --content S3Bucket="$S3_BUCKET_NAME",S3Key="$FILENAME"
  )"
