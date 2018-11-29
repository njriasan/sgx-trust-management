FROM ubuntu
MAINTAINER njriasanovsky@berkeley.edu

RUN apt-get update

RUN apt-get install -y g++ 

RUN apt-get install -y make

RUN apt-get install -y libssl-dev

RUN apt-get install -y libjsoncpp-dev

RUN apt-get install -y libcurl4-openssl-dev

RUN apt-get install -y libprotoc10

add application ~/sgx-trust/application

add aux_lib ~/sgx-trust/aux_lib

add client ~/sgx-trust/client

add defs.h ~/sgx-trust/defs.h

add IAS_report.h ~/sgx-trust/IAS_report.h

add Makefile ~/sgx-trust/Makefile

add service-provider ~/sgx-trust/service-provider

add truce_public_keys.h ~/sgx-trust/truce_public_keys.h

add truce_record.h ~/sgx-trust/truce_record.h

add intel /opt/intel

add missing_libraries/libsgx_urts.so /usr/lib/x86_64-linux-gnu/libsgx_urts.so

add missing_libraries/libsgx_enclave_common.so.1 /usr/lib/x86_64-linux-gnu/libsgx_enclave_common.so.1

add missing_libraries/libsgx_uae_service.so /usr/lib/x86_64-linux-gnu/libsgx_uae_service.so 

RUN cd ~/sgx-trust/ && make clean && make SIMULATE_IAS=1
