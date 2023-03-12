from PIL import Image
import boto3
def lambda_handler(event,context):
    try:
        exif_redact(s3_obj)
    except e:
        print 'error'

def init(self, aws_access_key_id, aws_secret_access_key, region){
    s3Client = boto3.client('s3', aws_access_key_id = aws_access_key_id,
                                  aws_secret_access_key = aws_secret_access_key,
                                  region_name = region)
}

def exif_redact(filesrc):
    if 'jpg' in key or 'jpeg' in key
        img = s3Client.get_object(Bucket = Bucket, Key = key)['Body'].read()
        img_without_exif = Image.new(img.mode, image.size)
        img_without_exif.putdata(image_data)

        img_without_exif.save('clean_'+key)
        
        image
    else: 
        continue