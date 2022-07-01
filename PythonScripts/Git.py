import os;
import sys;

os.system(f'cd {sys.argv[1]} && git init')
os.system(f'cd {sys.argv[1]} && git add .')
os.system(f'cd {sys.argv[1]} && git commit -m "save"')
os.system(f'cd {sys.argv[1]} && git branch -M main')
os.system(f'cd {sys.argv[1]} && git remote add origin https://{sys.argv[2]}:{sys.argv[3]}@github.com/{sys.argv[2]}/{sys.argv[4]}.git')
os.system(f'cd {sys.argv[1]} && git pull origin main')
os.system(f'cd {sys.argv[1]} && git push -f origin main')
