#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ks/tutorial_ws/src/mick_robot-master/mick_robot-master/sensor_interface/nmea_navsat_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ks/tutorial_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ks/tutorial_ws/install/lib/python2.7/dist-packages:/home/ks/tutorial_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ks/tutorial_ws/build" \
    "/usr/bin/python2" \
    "/home/ks/tutorial_ws/src/mick_robot-master/mick_robot-master/sensor_interface/nmea_navsat_driver/setup.py" \
     \
    build --build-base "/home/ks/tutorial_ws/build/mick_robot-master/mick_robot-master/sensor_interface/nmea_navsat_driver" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ks/tutorial_ws/install" --install-scripts="/home/ks/tutorial_ws/install/bin"
