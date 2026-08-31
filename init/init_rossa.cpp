/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <cutils/properties.h>
#include <fstream>
#include <iostream>
#include <string>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

#define ISMATCH(a,b)    (!strncmp(a,b,PROP_VALUE_MAX))

void init_dsds() {
    property_set("ro.multisim.set_audio_params", "true");
    property_set("ro.multisim.simslotcount", "2");
    property_set("persist.radio.multisim.config", "dsds");
}

void init_ss() {
    property_set("ro.multisim.set_audio_params", "false");
    property_set("ro.multisim.simslotcount", "1");
    property_set("persist.radio.multisim.config", "ss");
}

bool FileExists(const std::string& path)
{
        return std::ifstream(path.c_str()).good();
}

void vendor_load_properties()
{
    char platform[PROP_VALUE_MAX];
    char bootloader[PROP_VALUE_MAX];
    char device[PROP_VALUE_MAX];
    char devicename[PROP_VALUE_MAX];
    int rc;

    rc = property_get("ro.board.platform", platform, "");
    if (!rc || !ISMATCH(platform, ANDROID_TARGET))
        return;

    property_get("ro.bootloader", bootloader, "G360F");

    if (strstr(bootloader, "G360FY")) {
        property_set("ro.product.model", "SM-G360FY");
        property_set("ro.product.device", "rossa");
		property_set("ro.product.name", "coreprimeltexx");
	} else if (strstr(bootloader, "G360R6")) {
        property_set("ro.product.model", "SM-G360R6");
        property_set("ro.product.device", "coreprimeltelra");
        property_set("ro.product.name", "coreprimeltelra");
    } else if (strstr(bootloader, "G360T")) {
        property_set("ro.product.model", "SM-G360T");
        property_set("ro.product.device", "cprimeltetmo");
        property_set("ro.product.name", "cprimeltetmo");
    } else {
        property_set("ro.product.model", bootloader);
        property_set("ro.product.device", "rossa");
    }

	int curlang;
	curlang = property_get("ro.product.locale", platform, ""); 
	if (!curlang) {	
		property_set("ro.product.locale", "en-US");
	}

		INFO("INIT: sim_count detecting");
		std::ifstream fin("proc/simslot_count");
		char buff[10];

		if (fin.is_open())
		{
			fin >> buff;
			fin.close();

			if (strstr(buff,"2")) {
			init_dsds();
			} else {
			init_ss();
			}
		} else {
		init_ss();
		}

    property_get("ro.product.device", device, "G360?");
    strlcpy(devicename, device, sizeof(devicename));
    INFO("Found bootloader id %s setting build properties for %s device\n", bootloader, devicename);
}
