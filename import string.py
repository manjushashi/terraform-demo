import string
import sys
def generate_config():
    email_id = sys.argv[1]
    print(email_id)
    replacements = {'foo/terraform.tfstate': email_id+'/project.tfstate'}
    lines = []
    with open('/home/yashwanth_kumar/cloudrun/terraform/backend.tf') as infile:
        for line in infile:
            for src, target in replacements.items():
                line = line.replace(src, target)
            lines.append(line)
    with open('/home/yashwanth_kumar/cloudrun/terraform/backend.tf', 'w') as outfile:
        for line in lines:
            outfile.write(line)

generate_config()