#!/usr/bin/env bash

JAVA_VERSION=8
LAYER_NAME='java'
LAYER_VERSION=1

LAYER_VERSION=$(
  aws lambda publish-layer-version --region "$TARGET_REGION" \
    --layer-name $LAYER_NAME \
    --zip-file fileb://java.zip \
    --description "Java v${JAVA_VERSION}" \
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
