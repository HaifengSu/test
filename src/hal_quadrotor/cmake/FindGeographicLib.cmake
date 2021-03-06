# set some default search paths
SET( GEOGRAPHICLIB_SEARCH_PATH ${GEOGRAPHICLIB_SEARCH_PATH} "/usr/include" )
SET( GEOGRAPHICLIB_SEARCH_PATH ${GEOGRAPHICLIB_SEARCH_PATH} "/usr/lib" )
SET( GEOGRAPHICLIB_SEARCH_PATH ${GEOGRAPHICLIB_SEARCH_PATH} "/opt/local/include" )
SET( GEOGRAPHICLIB_SEARCH_PATH ${GEOGRAPHICLIB_SEARCH_PATH} "/opt/local/lib" )

# search for the include path and the library path
FIND_PATH( GEOGRAPHICLIB_INCLUDE_DIR Geoid.hpp HINTS ${GEOGRAPHICLIB_SEARCH_PATH} PATH_SUFFIXES GeographicLib )
FIND_LIBRARY( GEOGRAPHICLIB_LIBRARY NAMES Geographic HINTS ${GEOGRAPHICLIB_SEARCH_PATH} )

# mark both variables as advance
MARK_AS_ADVANCED( GEOGRAPHICLIB_INCLUDE_DIR GEOGRAPHICLIB_LIBRARY )