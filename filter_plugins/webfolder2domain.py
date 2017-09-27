import os.path

def webfolder2domain(arg):
    foldername = os.path.basename(os.path.normpath(arg));
    return '.'.join(reversed(foldername.split('.')))


class FilterModule(object):
    def filters(self):
        return {'webfolder2domain': webfolder2domain}
