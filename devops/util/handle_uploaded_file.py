__author__ = 'yanjiajia'
def handle_uploaded_file(f):
    with open(f.name, 'wb+') as info:
        for chunk in f.chunks():
            info.write(chunk)
    return f