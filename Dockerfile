FROM eclipse-temurin:latest as builder

WORKDIR /home
RUN apt update && apt install unzip
RUN wget https://download2.interactivebrokers.com/portal/clientportal.gw.zip
RUN unzip clientportal.gw.zip

FROM eclipse-temurin:17-jre-alpine

WORKDIR /home/ibkr
COPY --from=builder /home/bin/run.sh ./bin/run.sh
COPY --from=builder /home/root/conf.yaml ./root/conf.yaml
COPY --from=builder /home/root/vertx.jks ./root/vertx.jks
COPY --from=builder /home/build ./build
COPY --from=builder /home/dist ./dist
EXPOSE 5000
CMD [ "./bin/run.sh","root/conf.yaml" ]