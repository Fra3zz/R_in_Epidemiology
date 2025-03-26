import serial
from serial.tools import list_ports
import os

# Debug env setting
DEBUG = bool(int(os.getenv("DEBUG", 0)))

def get_seed_from_truerng():
    rng_com_port = None
    
    # Call list_ports to get com port info
    ports_available = list_ports.comports()

    # Loop on all available ports to find TrueRNG
    print('Com Port List')
    for temp in ports_available:
        # Print port information
        print(f'{temp.device} : {temp.hwid}')
        if '04D8:F5FE' in temp.hwid:
            print('Found TrueRNG on ' + temp.device)
            if rng_com_port is None:  # always chooses the 1st TrueRNG found
                rng_com_port = temp.device
        if '16D0:0AA0' in temp.hwid:
            print('Found TrueRNGpro on ' + temp.device)
            if rng_com_port is None:  # always chooses the 1st TrueRNG found
                rng_com_port = temp.device
        if '04D8:EBB5' in temp.hwid:
            print('Found TrueRNGproV2 on ' + temp.device)
            if rng_com_port is None:  # always chooses the 1st TrueRNG found
                rng_com_port = temp.device

    if rng_com_port is None:
        raise Exception("TrueRNG device not found")

    # Open the serial port
    ser = serial.Serial(rng_com_port, 115200, timeout=10)

    try:
        # Read 8 bytes from TrueRNG
        random_bytes = ser.read(1500)
        
        if DEBUG:
            print(random_bytes.hex())
        
        # Convert bytes to an integer seed
        seed = int.from_bytes(random_bytes, byteorder='big')
    finally:
        # Ensure the serial port is closed
        ser.close()

    return seed

if DEBUG:
    get_seed_from_truerng()