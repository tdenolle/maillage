
class Utils(object):

    @staticmethod
    def memory_usage_psutil():
        # return the memory usage in MB
        import psutil
        import os
        pid = os.getpid()
        process = psutil.Process(pid)
        mem = process.get_memory_info()[0] / float(2 ** 20)
        return "Memory usage (%s) : %d MB" % (pid, mem)