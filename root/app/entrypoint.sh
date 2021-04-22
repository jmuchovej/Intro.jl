#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    connection_file=/tmp/connection-file.json
else
    connection_file=${1}
fi

case "${1}" in
    "kernel")
        cat ${connection_file}

        # Modify the damn connection file to use proper IP address now
        sed -i 's;127.0.0.1;0.0.0.0;' ${connection_file}

        /usr/local/julia/bin/julia \
            -i \
            --color=yes \
            ${IJULIA_KERNEL} \
            ${connection_file}
        ;;
    "lab"|"notebook")
        echo "Already running as a background service. Exiting..."
        exit 0
        ;;
    "sh"|"bash")
        /bin/bash
        ;;
    *)
        /usr/local/julia/bin/julia ${@}
        ;;
esac
