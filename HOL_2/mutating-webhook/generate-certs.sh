# Certificate authority key and certificate
openssl req -new -x509 -days 36500 -nodes -subj '/CN=Pod Label Add Webhook' -keyout ca.key -out ca.crt 

# Server key
openssl genrsa -out server.key 2048

# Certificate signing request
openssl req -new -key server.key -subj '/CN=pod-label-add.default.svc' -out server.csr

# Server certificate
openssl x509 -req -days 36500 -extfile <(printf "subjectAltName=DNS:pod-label-add.default.svc") -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt 

# Copy certs to app folder
chmod 644 *.key
cp ca.crt ./certs
cp server.crt ./certs
cp server.key ./certs

# Cleanup
rm ca.crt
rm server.crt
rm server.key
rm ca.key
rm ca.srl
rm server.csr