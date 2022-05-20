# Atomic_double_slit_imaging
Processing the live images from atomic position measurement in a double slit interferometer

Using a image stack from a camera focused on the phosphor plate of MCP atomic position detector, this code processes the images showing individual atomic hits into a accumulated average of atom positions.

Processing steps:
Remove background noise
Remove anomalous hot pixels
Binarizing
Convert type in order to implement algebra on data
Finding precise location of atom signal, determine closest pixel co-ordinate

Algorithm adds each frame together and outputs 2 image files.

Created at UCL 2018
