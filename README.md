# MySql Debezium (CDC) POC
This POC is based on info found [Here](https://github.com/debezium/debezium-examples)

## Install brew and need OSX tools
```bash
# Install brew if missing
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Docker Desktop
brew install --cask docker

# Install jq and docker-compose
brew jq docker-compose

# Hook docker-compose with Docker Desktop
sudo rm /usr/local/bin/docker-compose
sudo ln -s /Applications/Docker.app/Contents/Resources/cli-plugins/docker-compose /usr/local/bin/docker-compose
```

## Start and Stop dockers
```bash
## Start up
./up.sh

## Shutdown    
./down.sh
```

## MySQL kafka connector
```bash
# Install connector
curl -i -X POST \
    -H "Accept:application/json" \
    -H  "Content-Type:application/json" \
    "http://localhost:8083/connectors/" \
    -d @register-mysql.json
```

## Get Connector info
```bash
curl -X GET \
    "http://localhost:8083/connectors/inventory-connector" \
    | jq -r 
```

## Consume messages from a Debezium topic
```bash
docker-compose \
    -f docker-compose-mysql.yaml \
    exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic dbserver1.inventory.customers \
    | jq -r
```

## MySql shell
[some my sql tests found here](./test.sql)
```bash
## My SQL related env variables
export MYSQL_HOST=localhost
export MYSQL_PORT=3306
export MYSQL_ROOT_PASSWORD=debezium
export MYSQL_USER=mysqluser
export MYSQL_PASSWORD=mysqlpw

## MySql root login
./exec.sh 'MYSQL_PWD="${MYSQL_ROOT_PASSWORD}" mysql --user=root'

## MySql debezium login to inventory db
./exec.sh 'mysql -u $MYSQL_USER -p $MYSQL_PASSWORD inventory'

## MySql stuff
show grants for debezium;
show global variables like 'binlog_format';

SELECT * FROM `inventory`.`customers`;

INSERT INTO `inventory`.`customers`
    (`id`, `first_name`, `last_name`, `email`)
VALUES
    (1005, 'Nabil', 'Khan', 'mnabeel1@hotmail.com');

UPDATE `inventory`.`customers`
SET
    `first_name` = 'Nabil M'
WHERE 
    `id` = 1005;

DELETE FROM `inventory`.`customers` WHERE `id` = 1005;
```

## Kafka UI
We can use [Kafka Drop UI](http://localhost:9000) for browsing message in Kafka
