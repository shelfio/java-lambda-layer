## AWS Lambda layer with Java 8

The purpose of this layer is to have externalized Java 8, so we can attach it to the lambda whenever it's needed by software we use.

E.g. after AWS Lambda started to use Amazon Linux 2 OS, Node.js runtime 12.x, 10.x doesn't have Java installed. Previously we had it installed with Node.js 8.10 (Amazon Linux OS), so we were able to use it for other software needs (e.g. Apache Tika).

### How to create a fresh zip archive with Java 8

```bash
mkdir java

docker run --rm -v "$PWD"/java:/lambda/opt lambci/yumda:2 yum install -y java-1.8.0-openjdk-headless.x86_64

cd java
zip -yr ../java .
cd ..

rm -R java
```
