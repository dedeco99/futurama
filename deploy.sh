npm run build
ssh ubuntu@futurama.rabbitsoftware.dev 'rm -rf /home/ubuntu/futurama/dist'
scp -r dist ubuntu@futurama.rabbitsoftware.dev:/home/ubuntu/futurama