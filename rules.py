class AbstractLinkingRule(object):
    def __init__(self):
        pass

    def match(self,source,target):
        raise NotImplemented()

class DataValuesEqualLinkingRule(AbstractLinkingRule):
    def __init__(self,data_field_index ):
        AbstractLinkingRule.__init__(self)
        self._data_field_index = data_field_index

    def match(self,source,target):
        return source.data[self._data_field_index]==target.data[self._data_field_index]
