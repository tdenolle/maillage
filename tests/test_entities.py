from unittest import TestCase
from maillage.entities import Target


class TestTarget(TestCase):

    def setUp(self):
        self._target = Target(["/annuaire/rennes-35/restaurants",1,2,3,4,5])

    def test_nb_links(self):
        self._target.nb_links = 3;
        self.assertEqual(self._target.nb_links,3)

    def test_is_full(self):
        self._target.points = 5;
        self.assertFalse(self._target.is_full)
        self._target.nb_links = 5
        self.assertTrue(self._target.is_full)

    def test_points(self):
        self._target.points = 10;
        self.assertEqual(self._target.points,10)
