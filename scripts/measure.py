import time

def main():
#    measure_sgp30(True, 20)
    while 1:
        measure_sgp30_air(True, 3) ## Measure air quality every 3 seconds

def measure_sgp30(print = False, sleepTime = 20):
    from smbus2 import SMBusWrapper
    from sgp30 import Sgp30
    with SMBusWrapper(1) as bus:
        sgp=Sgp30(bus,baseline_filename="/tmp/mySGP30_baseline")
        sgp.i2c_geral_call()
        if print:
            print(sgp.read_features())
            print(sgp.read_serial())
        sgp.init_sgp()
        if print:
            print(sgp.read_measurements())
        for i in range(sleepTime):
                time.sleep(1)
                if print:
                    print(".",end="")
        last_value = sgp.read_measurements()
        if print:
            print()
            print(last_value)
        return last_value

def measure_sgp30_air(print = False, sleepTime = 3):
    import smbus
    bus = smbus.SMBus(1)
    address = 0x58
    initSleep = 0.8
    time.sleep(sleepTime - (3*initSleep))
    time.sleep(initSleep)
    bus.write_i2c_block_data(address, 0x20, [0x03])
    time.sleep(initSleep)
    bus.write_i2c_block_data(address, 0x20, [0x08])
    time.sleep(initSleep)
    last_value = bus.read_i2c_block_data(address, 0)
    if print:
        print (last_value)
    return last_value

def measure_shtc1_temp(print = False, sleepTime = 2):
    import smbus
    bus = smbus.SMBus(1)
    address = 0x70
    initSleep = 0.8
    time.sleep(sleepTime - (3*initSleep))
    time.sleep(initSleep)
    bus.write_i2c_block_data(address, 0x78, [0x66])
    time.sleep(initSleep)
    last_value = bus.read_i2c_block_data(address, 0)
    if print:
        print (last_value)
    return last_value

def measure_shtc1_rh(print = False, sleepTime = 2):
    import smbus
    bus = smbus.SMBus(1)
    address = 0x70
    initSleep = 0.8
    time.sleep(sleepTime - (3*initSleep))
    time.sleep(initSleep)
    bus.write_i2c_block_data(address, 0x58, [0xE0])
    time.sleep(initSleep)
    last_value = bus.read_i2c_block_data(address, 0)
    if print:
        print (last_value)
    return last_value
