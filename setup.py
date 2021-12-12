#!/usr/bin/env python3
from setuptools import setup, find_packages
from json import loads

with open(".data.json", "r") as file:
    data = file.read()
    version = loads(data)["version"]

setup(
    name="hmac-http",
    version=version,
    author="Hunter Wittenborn",
    author_email="hunter@hunterwittenborn.com",
    description="Python library for the draft-cavage-http-signatures-10 specification",
    url="https://github.com/hwittenborn/hmac-http",
    packages=find_packages(),
    include_package_data=True,
    install_requires=["setuptools", "wheel"],
)
