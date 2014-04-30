import csv
import gzip
import logging
import time
import math
from maillage.entities import Target
from maillage.utils import Utils


class LinkingProcessor(object):
    def __init__(self, source_file_path, target_file_path, linking_rules):
        self._logger = logging.getLogger()
        self._sources = self.__load_data(source_file_path, "Source")
        #self._targets = []
        self._targets = self.__load_data(target_file_path, "Target")
        self._target_file_path = target_file_path
        self._linking_rules = linking_rules

    def __load_data(self, file_path, class_name):
        module = __import__("entities")
        class_ = getattr(module, class_name)
        data = []
        self._logger.info("Loading %s from %s ...", class_name, file_path)
        with gzip.open(file_path) as gzfile:
            csvreader = csv.reader(gzfile, delimiter=';')
            for row in csvreader:
                data.append(class_(row))
        self._logger.info("%d lines loaded", len(data))
        return data

    def prioritize(self):
        with gzip.open(self._target_file_path) as gzfile:
            csvreader = csv.reader(gzfile, delimiter=';')
            for index, row in enumerate(csvreader):
                t = Target([row[0]])
                t.points = 10
                self._targets.append(t)
        #TODO get prioritizer from IoC and apply points to targets
        # generate a hashtable url;points using file enumerator
        # Temporary apply 10 points by default to targets
        #for t in self._targets:
        #    t.points = 10
            # TODO Point price calculation

    def link(self):
        t = time.time()
        #TODO load rules from IoC
        with gzip.open(self._target_file_path) as gzfile:
            csvreader = csv.reader(gzfile, delimiter=';')
            for index, row in enumerate(csvreader):
                target = Target(row)
                #TODO : delete when prioritization will be ok
                target.points=10
                #self._logger.info("Linking target url : %s", t.url)
                for r in self._linking_rules:
                    for s in self._sources:
                        if target.url != s.url and (not s.is_full) and r.match(target, s):
                            #self._logger.info("Source found : %s", s.url)
                            #time.sleep(1)
                            s.targets.append(target.url)
                            target.nb_links += 1
                        if target.is_full: break;
                        #time.sleep(1)
                    if target.is_full: break;
                #time.sleep(1)
                if index % 100 == 0:
                    self._logger.info('Progress: %d - %d%% - tps %d/s', index, (index * 100 / len(self._targets)),
                                      index / (time.time() - t))
                if index % 1000 == 0:
                    self._logger.info(Utils.memory_usage_psutil())


    def export_linking(self, file_path):
        pass

    def show_statistics(self):
        pass