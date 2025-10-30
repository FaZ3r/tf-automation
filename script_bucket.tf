resource "aws_s3_bucket" "script_bucket"{
    bucket= "tudor_script_bucket"
}

resource "aws_s3_object" "log_script"{
    bucket= aws_s3_bucket.script_bucket.id
    key = "log_generator2.py"
    source ="${path.cwd}/log_generator2.py"
    acl="private"
}