## JPG image EXIF remover


### Project split into:
- tf all the terraform scripts to deploy
    - IAM - The User, groups and roles deployment
    - S3 - Source and Destination buckets 
    - LAMBDA - Lambda function and layers for external dependancies

- Testing
    - Setting the environment variable to 'dev' is for testing using localstack
    - localstack would be ran with docker compose and endpoints set to localhost

### Data Flow 

UserA uploads image to source s3 bucket (img-src)
Source bucket notifies lambda with a put object event notification
JpegTransform lambda downloads new jpeg strips the image of EXIF metadata and uploads to destination bucket

