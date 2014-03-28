#!/bin/bash

echo "Uploading pdf..."
s3cmd put ./paper.pdf s3://morrisoncole.co.uk/heisentest/report.pdf
s3cmd setacl --acl-public s3://morrisoncole.co.uk/heisentest/report.pdf