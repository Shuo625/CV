from ast import arg
from parso import parse
import yaml
import argparse
import os
import shutil


parser = argparse.ArgumentParser(description='CV Generator')

parser.add_argument('--apply_dir', default=None, required=True, 
                    type=str, help='directory of one applyment')


CWD = os.path.dirname(os.path.realpath(__file__))
CV_DIR = os.path.join(CWD, '../CV')

CV_CONTENTS = [
    'profile',
    'education',
    'experiences',
    'projects',
    'skills'
]


def write_contents(file: str, contents: list):
    with open(file, mode='r') as f:
        lines = f.readlines()

    for idx, line in enumerate(lines):
        if line.startswith('\\begin'):
            for i, content in enumerate(contents):
                lines.insert(idx + i + 1, content)
            
            break

    with open(file, mode='w') as f:
        f.writelines(lines)


def generate_cv(lang: str):
    cv_file = shutil.copyfile(os.path.join(CV_DIR, '_cv.tex'), os.path.join(CV_DIR, 'cv.tex'))

    cv_contents = ['\input{%s/%s}\n' % (lang, content) for content in CV_CONTENTS]

    write_contents(cv_file, cv_contents)


def generate_experiences(lang: str, experiences: list):
    experiences_file = shutil.copyfile(os.path.join(CV_DIR, lang, '_experiences.tex'), os.path.join(CV_DIR, lang, 'experiences.tex'))

    experiences_contents = []

    _experiences = os.listdir(os.path.join(CV_DIR, lang, 'experiences'))

    for experience in experiences:
        for _experience in _experiences:
            if _experience.startswith(experience):
                experiences_contents.append(os.path.splitext(_experience)[0])

    experiences_contents = ['\input{%s/experiences/%s}\n' % (lang, content) for content in experiences_contents]

    write_contents(experiences_file, experiences_contents)


def generate_projects(lang: str, projects: list):
    projects_file = shutil.copyfile(os.path.join(CV_DIR, lang, '_projects.tex'), os.path.join(CV_DIR, lang, 'projects.tex'))

    projects_contents = []

    _projects = os.listdir(os.path.join(CV_DIR, lang, 'projects'))

    for project in projects:
        for _project in _projects:
            if _project.startswith(project):
                projects_contents.append(os.path.splitext(_project)[0])

    projects_contents = ['\input{%s/projects/%s}\n' % (lang, content) for content in projects_contents]

    write_contents(projects_file, projects_contents)


def compile(lang: str, apply_dir: str):
    CC = 'xelatex'

    os.chdir(CV_DIR)
    os.system(f'{CC} cv.tex')
    os.chdir(CWD)

    shutil.move(os.path.join(CV_DIR, 'cv.pdf'), os.path.join(CWD, apply_dir, f'{lang}.pdf'))


def clear(lang: str):
    os.chdir(CV_DIR)
    command = f'rm *.aux *.log *.out {lang}/*.aux cv.tex {lang}/experiences.tex {lang}/projects.tex'
    os.system(command)
    os.chdir(CWD)


def generate_CV(apply_dir: str, lang: str):
    with open(os.path.join(apply_dir, 'cv.yaml'), mode='r') as f:
        CV_config = yaml.load(f)

    experiences = CV_config['experiences']
    projects = CV_config['projects']

    generate_cv(lang)
    generate_experiences(lang, experiences)
    generate_projects(lang, projects)

    compile(lang, apply_dir)

    clear(lang)


if __name__ == '__main__':
    args = parser.parse_args()

    os.chdir(CWD)

    generate_CV(args.apply_dir, 'en')
    generate_CV(args.apply_dir, 'cn')
