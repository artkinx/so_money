#!/bin/bash

flutter upgrade
dart analyze lib/*
dart format .
dart pub publish --dry-run

