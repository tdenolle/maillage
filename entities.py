class AbstractCsvItem(object):
    def __init__(self, row):
        self._url = row[0]
        self._data = row[1:] if len(row)>1 else []

    @property
    def url(self):
        return self._url

    @property
    def data(self):
        return self._data

    @property
    def is_full(self):
        raise NotImplementedError()


class Source(AbstractCsvItem):
    def __init__(self, row):
        AbstractCsvItem.__init__(self, row)
        self._max_links = 25
        self._targets = []

    @property
    def targets(self):
        return self._targets

    @property
    def is_full(self):
        return len(self._targets) >= self._max_links


class Target(AbstractCsvItem):
    def __init__(self, row):
        AbstractCsvItem.__init__(self, row)
        self._points = 0
        self._nb_links = 0
        self._max_links = 0

    @property
    def nb_links(self):
        return self._nb_links

    @nb_links.setter
    def nb_links(self, value):
        self._nb_links = value

    @property
    def max_links(self):
        return self._max_links

    @property
    def is_full(self):
        return self._nb_links >= self._max_links

    @property
    def points(self):
        return self._points

    @points.setter
    def points(self, value):
        self._points = value
        self._max_links = value  # temporary considering point price = 1
