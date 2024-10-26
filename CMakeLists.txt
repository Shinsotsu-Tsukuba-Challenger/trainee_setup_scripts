cmake_minimum_required(VERSION 3.8)
project(trainee_setup_scripts)
find_package(ament_cmake_auto REQUIRED)
ament_auto_find_build_dependencies()
ament_auto_package(
  INSTALL_TO_SHARE
  can
  ether_lidar
  hotspot
  network_routing_eth_to_wlan
  time_synchronization
)