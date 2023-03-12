from PIL import Image
import boto3
import os
def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    try:
        exif_redact(bucket, key)
    except Exception as e:
        print(e)


def exif_redact(bucket, key):
    if key in ['jpg','jpeg']:

        download_path = '/tmp/'+key
        
        img = s3Client.download_file(Bucket = bucket, Key = key, Filename = download_path)

        image = Image.open(download_path)

        data = list(image.getdata())
        image_without_exif = Image.new(image.mode, image.size)
        image_without_exif.putdata(data)

        image_without_exif.save(download_path)
        
        s3Client.upload_file(Filename = download_path, Bucket= os.environ['destination_bucket'], Key='clean_'+key)