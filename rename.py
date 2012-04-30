import os, sys, getopt
opts, extraparams = getopt.getopt(sys.argv[1:],'p:')
path = []
for o,p in opts:
    if o in ('-p',):
        path.append(p)
if path.__len__()>0 and path.__len__()<2 and os.path.isdir(path[0]):
    print 'opening %s'%path
    i=1
    for filename in os.listdir(path[0]):
        if filename[-4:]=='.jpg':
            num=str(i).zfill(4)
            i_file=os.path.join(path[0],filename)
            o_file=os.path.join(path[0],'frame%s.jpg'%num)
            if not os.path.isfile(o_file):
                os.rename(i_file,o_file)
            else:
                print 'ok'
                sys.exit()
            i+=1
    print 'ok'
else:
    print 'no or wrong argument'
    sys.exit()