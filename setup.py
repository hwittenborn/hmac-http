#!/usr/bin/env python3
from setuptools import setup, find_packages

setup(
    name="hmac-http",
    version=0.1,
    author="Hunter Wittenborn",
    author_email="hunter@hunterwittenborn.com",
    description="Python library for the draft-cavage-http-signatures-10 specification",
    url="https://github.com/hwittenborn/hmac-http",
    packages=find_packages(),
)
