<!-- ABOUT THE PROJECT -->
## About The Project

Modified Atmospheric Surface Flux Stations (ASFS) (see Cox et al., 2023) were experimentally fixed to Ice Gateway-Heavy spar buoys in the Beaufort Sea. 
The project was led by the Office of Naval Research (ONR) and the University of Washington. NOAA/PSL collaborated to support the ASFS science package.
The buoy and science package design are detailed in Webster et al. (2024). The CRBasic code here was used for data logging on Campbell Scientific CR1000X
data loggers.

Code features:
- 10 sec scan cycle for slow sensors
  - RS485 MODBUS sensor communication
  - Analog measurements
- 10 Hz passive buffer accumulation 
  - RS422 sonic anemometer
- 1 Hz subscan
  - VN300 navigation
-  vn300 reconfiguration on reboot
-  anemometer icing detection and management of heater duty cycling
-  coordination with an external linux board for soft shutdowns
-  limited remote communcation capabilities for modbus sensor power management
-  integration with SDM-CD16S DCDC controller for power managment, remotely controllable
-  archived storage on local sd card
-  paritioned internal storage, ftp enabled

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the project_license. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Christopher J. Cox - christopher.j.cox@noaa.gov

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- REFERENCES -->
## References

Cox, C.J., M. Gallagher, M.D. Shupe, P.O.G. Persson, A. Solomon, C.W. Fairall, T. Ayers, B. Blomquist, I. Brooks, D. Costa, A. Grachev, D. Gottas,
J. Hutchings, M. Kutchenreiter, J. Leach, S.M. Morris, V. Morris, J. Osborn, S. Pezoa, A. Preusser, and L. Riihimaki (2023), Continuous observations 
of the surface energy budget and meteorology over Arctic sea ice during MOSAiC. Nature Scientific Data, 10(1), 519, https://10.1038/s41597-023-02415-5 

Webster, S.E., A. Falcone, A. Jost, K. Smith, J. Anderson, B. Cunningham, P. LaMothe, R. Sharman, E. Brosius, C.J. Cox, T. Stanton, and J. Wilkinson (2024) 
Design and field testing of the Heavyweight Gateway Buoy to Support Arctic Science. IEEE Oceans Conference and Exposition, September 2024, Halifax, 
Nova Scotia, Canada, pp. 1-8, https://10.1109/OCEANS55160.2024.10754089 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

