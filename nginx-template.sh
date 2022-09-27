#!/usr/bin/env bash

# This script is used to generate nginx configuration files from templates.

FILE_NAME="$1"
TEMPLATE_ID="$2"

case $TEMPLATE_ID in
"80")
TEMPLATE=$(cat <<-END

# $(date)
server {
        listen 80;

        # ========= edit your your domain here =========
        server_name $3;

        location / {
                proxy_set_header X-Forwarded-Host \$host;
                proxy_set_header X-Real-IP \$remote_addr;
                proxy_set_header X-Forwarded-Server \$host;
                proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;

                # ========= edit your app's host here =========
                proxy_pass $4;

                proxy_http_version 1.1;
                proxy_set_header Upgrade \$http_upgrade;
                proxy_set_header Connection "upgrade";
        }
}
END
)
;;
"redirect")
TEMPLATE=$(cat <<-END

# $(date)
server {
    server_name $3;
    return 301 $4\$request_uri;

    # ... other configs
}
END
)
;;
esac

echo "$TEMPLATE" >> "$FILE_NAME"
