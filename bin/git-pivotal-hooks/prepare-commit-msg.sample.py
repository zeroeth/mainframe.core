#!/usr/bin/env python

"""
Copyright (c) 2011 Socialize, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions: 

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.  

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.  

"""

import urllib2
import sys
import os.path
import re
from xml.dom.minidom import parse

colors = {
        'accepted':   '\033[92m',
        'started':    '\033[95m',
        'finished':   '\033[94m',
        'unstarted':  '\033[97m',
        'unscheduled':'\033[97m',
        'delivered':  '\033[93m',
        'rejected':   '\033[91m',
        'clear':      '\033[0m'
}

def load_config():
    pivotal_items = {}
    rcfile = os.path.expanduser("~/.pivrc/"+os.path.basename(os.getcwd()))
    with open(rcfile) as f:
        for line in f:
            text = re.split(":\s+", line.strip())
            pivotal_items[text[0]] = text[1]
    return pivotal_items['token'], pivotal_items['filter'], pivotal_items['project_id']


def load_document(token, filter, project_id):
    req = urllib2.Request(
            'http://www.pivotaltracker.com/services/v3/projects/%s/stories/?filter=%s' % (
                project_id, urllib2.quote(filter)))
    req.add_header("X-TrackerToken", token)
    result = urllib2.urlopen(req)
    return result

if __name__ == '__main__':
    rcfile = os.path.expanduser("~/.pivrc/"+os.path.basename(os.getcwd()))
    if not os.path.isfile(rcfile):
        sys.exit()

    files = sys.argv[0]
    msg_file = sys.argv[1]

    token, filter, project_id = load_config()
    pivotal_document = parse(load_document(token, filter, project_id))

    stories = pivotal_document.getElementsByTagName('story')

    stories_to_add = []
    potential_stories_to_add = []
    if stories:
        i = 1
        print "Available Stories"
        stories = sorted(stories, key=lambda story: story.getElementsByTagName('current_state')[0].firstChild.wholeText)
        for story in stories:
            id = story.getElementsByTagName('id')[0].firstChild.wholeText
            name = story.getElementsByTagName('name')[0].firstChild.wholeText
            state = story.getElementsByTagName('current_state')[0].firstChild.wholeText

            state = colors[state] + ("%11s" % state) + colors['clear']

            print "%3s: %s [%s] -- %s" % (i, id, state, name)
            potential_stories_to_add.append((id, name))

            i += 1
    else:
        print "No stories found. Not adding anything to commit message."
        sys.exit()

    sys.stdin = open('/dev/tty')
    items_to_include = re.split(",s*", raw_input(
        "Please choose which story/stories this commit relates to (as a comma separated list):"))
    items_to_include = [i.strip() for i in items_to_include if i]

    if items_to_include:
        for i in items_to_include:
            index = int(i) - 1
            if index < len(potential_stories_to_add):
                stories_to_add.append(potential_stories_to_add[index])
            else:
                print "Sorry, %s was not an option." % i

    if len(stories_to_add) == 0:
        print "No stories found. Not adding anything to commit message."
        sys.exit()

    stringified_stories = ['#%s' % story[0] for story in stories_to_add]

    msg = open(msg_file, 'r').read()
    msg = '[%s] %s' % (' '.join(stringified_stories), msg)
    open(msg_file, 'w').write(msg)
