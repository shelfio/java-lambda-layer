## AWS Lambda layer with Java 8

The purpose of this layer is to have externalized Java 8, so we can attach it to the lambda whenever it's needed by software we use.

E.g. after AWS Lambda started to use Amazon Linux 2 OS, Node.js runtime 12.x, 10.x doesn't have Java installed. Previously we had it installed with Node.js 8.10 (Amazon Linux OS), so we were able to use it for other software needs (e.g. Apache Tika).

## Getting Started

Click on Layers and choose "Add a layer", and "Provide a layer version
ARN" and enter the following ARN.

```
arn:aws:lambda:us-east-1:764866452798:layer:java:1
```

## Where it can be used?

This layer was initially designed for [Apache Tika Lambda layer](https://github.com/shelfio/apache-tika-lambda-layer) to run on Node.js 12.x runtime, but you can use it for any other purpose you want.

## What is the executable path to Java inside of Lambda when I attached the layer?

You can find it at `/opt/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.lambda2.0.1.x86_64/jre/bin/java` (`/opt` is a location where lambda unpacks layers).

## Available regions

* us-east-1

### How to create a fresh zip archive with Java 8

```bash
mkdir java

docker run --rm -v "$PWD"/java:/lambda/opt lambci/yumda:2 yum install -y java-1.8.0-openjdk-headless.x86_64

cd java
zip -yr ../java .
cd ..

rm -R java
```

## License

MIT © [Shelf](https://shelf.io)
