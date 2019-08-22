from smbus2 import SMBusWrapper
from sgp30 import Sgp30
import time

import subprocess
from datetime import datetime
from influxdb import InfluxDBClient


def get_temp():
    data=subprocess.Popen(["cat","/sys/bus/i2c/devices/1-0070/hwmon/hwmon1/temp1_input"], stdout=subprocess.PIPE).stdout.read().rstrip()
    return float(data)/1000


def get_hum():
    data=subprocess.Popen(["cat", "/sys/bus/i2c/devices/1-0070/hwmon/hwmon1/humidity1_input"], stdout=subprocess.PIPE).stdout.read().rstrip()
    return float(data)/1000


def main():
    host='localhost'
    port=8086
    dbname = 'sensor'
    client = InfluxDBClient(host=host, port=port, database=dbname)
    with SMBusWrapper(1) as bus:
        sgp=Sgp30(bus,baseline_filename="/tmp/mySGP30_baseline") #things thing with the baselinefile is dumb and will be changed in the future
        sgp.i2c_geral_call() #WARNING: Will reset any device on teh i2cbus that listens for general call
        sgp.init_sgp()
        while True:
            time.sleep(20)
            bundle=sgp.read_measurements()
            #print("CO2: {} TVOC: {}".format(bundle.data[0], bundle.data[1]))
            current_time = datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%SZ')
            json_body = [
                {
                    "measurement": "svm30",
                    "tags": {
                        "location": "office"
                    },
                    "time": current_time,
                    "fields": {
                        "hum": get_hum(),
                        "temp": get_temp(),
                        "co2": bundle.data[0],
                        "tvoc": bundle.data[1]
                    }
                }
            ]
            print("Write points: {0}".format(json_body))
            client.write_points(json_body)


if __name__ == '__main__':
    main()