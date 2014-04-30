import logging
import os
from optparse import OptionParser
from maillage.processor import LinkingProcessor

# log4py
from maillage.rules import DataValuesEqualLinkingRule
from maillage.utils import Utils

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s :: %(levelname)s :: %(message)s')
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.DEBUG)
stream_handler.setFormatter(formatter)
logger.addHandler(stream_handler)

# args parser
parser = OptionParser("usage: %prog [options] arg")
parser.add_option("-s", "--sources", dest="sources", help="Sources file path")
parser.add_option("-t", "--targets", dest="targets", help="Targets file path")
parser.add_option("-o", "--output", dest="output", help="Output file path")
parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
parser.add_option("-q", "--quiet", action="store_false", dest="verbose")
(options, args) = parser.parse_args()
#if len(args) != 1:
#parser.error("incorrect number of arguments")
#if options.verbose:
#    print "reading %s..." % options.filename

linking_rules = [DataValuesEqualLinkingRule(5), DataValuesEqualLinkingRule(9), DataValuesEqualLinkingRule(11)]
logger.info(Utils.memory_usage_psutil())
processor = LinkingProcessor(options.sources, options.targets, linking_rules)
logger.info(Utils.memory_usage_psutil())
processor.prioritize()
logger.info(Utils.memory_usage_psutil())
processor.link()
#processor.show_statistics()
#processor.export_linking(options.output)