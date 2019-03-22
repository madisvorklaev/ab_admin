#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Madis Võrklaev, AK31
# Version: 1.0
# Script reads info from a text file and reformats it to match I-Tee format.
# Usage: ./<script name> <inputfile> [-o <outputfile>]
# Usage: ./<script name> -h displays help
 
 
import sys
import argparse
from random import randint, choice
 
 
def readfile(inputfile):
    try:
        with open(inputfile,'r') as f:
            students = []
            for ln in f:
                students.append(ln)
    except IOError:
        print('Error: Can\'t find input file or read data')
        sys.exit(2)
    return students
 
 
def processing(students, outputfile):
    try:
        id = 0
        with open(outputfile, 'w') as f:
            for instance in students:
                student = instance.split()
                j = len(student)
                for i in range(2,j):
                    role = student[0].upper()
                    table = student[1].upper()
                    if student[i] == 's':
                        id = id + 1
                        print('s'+str(id))                                                
                        privilege = 'SELECT'
                        sqlline = str(id)+','+role+','+table+','+privilege+',2000-01-01,2050-01-01,'+'\n'
                        f.write(sqlline)
                    elif student[i] == 'u':
                        id = id + 1  
                        print('u'+str(id))                      
                        privilege = 'UPDATE'
                        sqlline = str(id)+','+role+','+table+','+privilege+',2000-01-01,2050-01-01,'+'\n'
                        f.write(sqlline)
                    elif student[i] == 'd':
                        id = id + 1
                        print('d'+str(id))
                        privilege = 'DELETE'
                        sqlline = str(id)+','+role+','+table+','+privilege+',2000-01-01,2050-01-01,'+'\n'
                        f.write(sqlline)
                    elif student[i] == 'i':
                        id = id + 1
                        print('i'+str(id))
                        privilege = 'INSERT'
                        sqlline = str(id)+','+role+','+table+','+privilege+',2000-01-01,2050-01-01,'+'\n'
                        f.write(sqlline)

                # write everything to an output file
                
    except IOError:
        print('Error: Can\'t write to file', outputfile)
        sys.exit(2)
    else:
        print('Operation was completed successfully! Please check', outputfile)
 
 
# parse cli arguments https://docs.python.org/3.3/library/argparse.html
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process student data for ITee')
    parser.add_argument('inputfile', type = str, help='input file with extension')
    parser.add_argument('-o', '--outputfile', type = str, default = 'output.csv', help='output file with extension')
    args = parser.parse_args()
 
    inputfile = args.inputfile
    outputfile = args.outputfile
   
    print('The input file is: '+inputfile)
    print('The output file is: '+outputfile)
 
    processing(readfile(inputfile), outputfile)

