From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] Add GPU_POWER sensors
Date: Sat, 11 Feb 2017 11:25:13 +1100
Message-ID: <909a2650-cafc-6be2-6bf6-8b57f0edecc4@folklore1984.net>
References: <20170210181027.16113-1-tom.stdenis@amd.com>
 <20170210181027.16113-2-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1833429154=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170210181027.16113-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1833429154==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hvbb4SiP2Eeha1jxXvnetNMCq6VgRAiOA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hvbb4SiP2Eeha1jxXvnetNMCq6VgRAiOA
Content-Type: multipart/mixed; boundary="a7E0gdl5tCgUC0Pj8BkkNOkikRCb1DWTL";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <909a2650-cafc-6be2-6bf6-8b57f0edecc4-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] Add GPU_POWER sensors
References: <20170210181027.16113-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <20170210181027.16113-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170210181027.16113-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--a7E0gdl5tCgUC0Pj8BkkNOkikRCb1DWTL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Tom,

On 02/11/2017 05:10 AM, Tom St Denis wrote:
> Add the ability to sample GPU_POWER sensors.  Because
> the sensors have a high latency we read them from a background
> thread which means we've added the requirement for pthreads.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  CMakeLists.txt         |  5 ++-
>  README                 |  6 ++--
>  src/app/top.c          | 88 +++++++++++++++++++++++++++++++++++++++++-=
--------
>  src/lib/CMakeLists.txt |  1 +
>  src/lib/read_sensor.c  | 37 +++++++++++++++++++++
>  src/umr.h              |  5 +++
>  6 files changed, 123 insertions(+), 19 deletions(-)
>  create mode 100644 src/lib/read_sensor.c
>=20
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index ef78c97ad763..7b771d01919b 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -19,6 +19,9 @@ add_definitions(-DUMR_BUILD_REV=3D\"${GIT_REV}\")
>  # Add local repository for FindXXX.cmake modules.
>  SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake_modules/" ${CMAKE_MOD=
ULE_PATH})
> =20
> +find_package(Threads REQUIRED)
> +include_directories(${THREADS_INCLUDE_DIRS})
Do you need this include_directories() line?

> +
>  find_package(Curses REQUIRED)
>  include_directories(${CURSES_INCLUDE_DIRS})
> =20
> @@ -37,7 +40,7 @@ set(REQUIRED_EXTERNAL_LIBS
>  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
> =20
>  # CFLAGS +=3D -Wall -W -O2 -g3 -Isrc/ -DPIC -fPIC
> -set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -W -O2 -g3")
> +set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread -Wall -W -O2 -g3")
You don't really want to have your linkage flags here, I think your
looking for ${CMAKE_THREAD_LIBS_INIT} to go into the
REQUIRED_EXTERNAL_LIBS list.

> =20
>  add_subdirectory(src)
>  add_subdirectory(doc)
> diff --git a/README b/README
> index 13cdac663d20..8a8de8485ac7 100644
> --- a/README
> +++ b/README
> @@ -28,9 +28,9 @@ mailing list at:
>  Building
>  ---------
> =20
> -To build umr you will need pciaccess, ncurses, and libdrm headers and
> -libraries.  Which are available in both Fedora and Ubuntu (as well as
> -other distributions).  To build umr:
> +To build umr you will need pciaccess, ncurses, libdrm, and pthread=20
> +headers and libraries.  Which are available in both Fedora and Ubuntu =

> +(as well as other distributions).  To build umr:
> =20
>      $ mkdir build && cd build/ && cmake ../
>      $ make
> diff --git a/src/app/top.c b/src/app/top.c
> index b081515a5b40..60f629d247f3 100644
> --- a/src/app/top.c
> +++ b/src/app/top.c
> @@ -54,6 +54,7 @@ enum sensor_maps {
>  	SENSOR_IDENTITY=3D0, // x =3D x
>  	SENSOR_D1000,    // x =3D x/1000
>  	SENSOR_D100,    // x =3D x/100
> +	SENSOR_WATT,
>  };
> =20
>  enum sensor_print {
> @@ -61,6 +62,7 @@ enum sensor_print {
>  	SENSOR_MHZ,
>  	SENSOR_PERCENT,
>  	SENSOR_TEMP,
> +	SENSOR_POWER,
>  };
> =20
>  enum drm_print {
> @@ -171,19 +173,14 @@ static struct umr_bitfield stat_uvd_pgfsm7_bits[]=
 =3D {
>  static struct umr_bitfield stat_mc_hub_bits[] =3D {
>  	 { "OUTSTANDING_READ", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_WRITE", 255, 255, &umr_bitfield_default },
> -//	 { "OUTSTANDING_ATOMIC", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_HUB_RDREQ", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_HUB_RDRET", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_HUB_WRREQ", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_HUB_WRRET", 255, 255, &umr_bitfield_default },
> -//	 { "OUTSTANDING_HUB_ATOMIC_REQ", 255, 255, &umr_bitfield_default },=

> -//	 { "OUTSTANDING_HUB_ATOMIC_RET", 255, 255, &umr_bitfield_default },=

>  	 { "OUTSTANDING_RPB_READ", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_RPB_WRITE", 255, 255, &umr_bitfield_default },
> -//	 { "OUTSTANDING_RPB_ATOMIC", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_MCD_READ", 255, 255, &umr_bitfield_default },
>  	 { "OUTSTANDING_MCD_WRITE", 255, 255, &umr_bitfield_default },
> -//	 { "OUTSTANDING_MCD_ATOMIC", 255, 255, &umr_bitfield_default },
>  	 { NULL, 0, 0, NULL },
>  };
this hulk seems unrelated to this patch?


With those fixes,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> =20
> @@ -227,6 +224,10 @@ static struct umr_bitfield stat_vi_sensor_bits[] =3D=
 {
>  	{ "GFX_MCLK", AMDGPU_PP_SENSOR_GFX_MCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
>  	{ "GPU_LOAD", AMDGPU_PP_SENSOR_GPU_LOAD, SENSOR_PERCENT<<4, &umr_bitf=
ield_default },
>  	{ "GPU_TEMP", AMDGPU_PP_SENSOR_GPU_TEMP, SENSOR_D1000|(SENSOR_TEMP<<4=
), &umr_bitfield_default },
> +	{ "VDDC",     AMDGPU_PP_SENSOR_GPU_POWER, SENSOR_WATT|(SENSOR_POWER<<=
4), &umr_bitfield_default },
> +	{ "VDDCI",    AMDGPU_PP_SENSOR_GPU_POWER, SENSOR_WATT|(SENSOR_POWER<<=
4), &umr_bitfield_default },
> +	{ "MAX_GPU",  AMDGPU_PP_SENSOR_GPU_POWER, SENSOR_WATT|(SENSOR_POWER<<=
4), &umr_bitfield_default },
> +	{ "AVG_GPU",  AMDGPU_PP_SENSOR_GPU_POWER, SENSOR_WATT|(SENSOR_POWER<<=
4), &umr_bitfield_default },
>  	{ NULL, 0, 0, NULL },
>  };
> =20
> @@ -256,6 +257,21 @@ static struct umr_bitfield stat_drm_bits[] =3D {
> =20
>  static FILE *logfile =3D NULL;
> =20
> +static volatile int sensor_thread_quit =3D 0;
> +static uint32_t gpu_power_data[4];
> +static void *vi_sensor_thread(void *data)
> +{
> +	struct umr_asic asic =3D *((struct umr_asic*)data);
> +	int size =3D sizeof(gpu_power_data);
> +	char fname[128];
> +
> +	snprintf(fname, sizeof(fname)-1, "/sys/kernel/debug/dri/%d/amdgpu_sen=
sors", asic.instance);
> +	asic.fd.sensors =3D open(fname, O_RDWR);
> +	while (!sensor_thread_quit)
> +		umr_read_sensor(&asic, AMDGPU_PP_SENSOR_GPU_POWER, gpu_power_data, &=
size);
> +	close(asic.fd.sensors);
> +	return NULL;
> +}
> =20
>  static unsigned long last_fence_emitted, last_fence_signaled, fence_si=
gnal_count, fence_emit_count;
>  static void analyze_fence_info(struct umr_asic *asic)
> @@ -428,6 +444,9 @@ static void print_sensors(struct umr_bitfield *bits=
, uint64_t *counts)
>  				case SENSOR_TEMP:
>  					printw("%5d C  ", counts[i]);
>  					break;
> +				case SENSOR_POWER:
> +					printw("%3d.%02d W ", counts[i]/100, counts[i]%100);
> +					break;
>  			};
>  			if ((++print_j & (top_options.wide ? 3 : 1)) !=3D 0)
>  				printw(" |");
> @@ -496,8 +515,8 @@ static void parse_bits(struct umr_asic *asic, uint3=
2_t addr, struct umr_bitfield
> =20
>  static void parse_sensors(struct umr_asic *asic, uint32_t addr, struct=
 umr_bitfield *bits, uint64_t *counts, uint32_t *mask, uint32_t *cmp, uin=
t64_t addr_mask)
>  {
> -	int j;
> -	int32_t value;
> +	int j, size, x;
> +	uint32_t value[16];
> =20
>  	(void)addr;
>  	(void)mask;
> @@ -507,13 +526,34 @@ static void parse_sensors(struct umr_asic *asic, =
uint32_t addr, struct umr_bitfi
>  	if (asic->fd.sensors < 0)
>  		return;
> =20
> -	for (j =3D 0; bits[j].regname; j++) {
> -		lseek(asic->fd.sensors, bits[j].start * 4, SEEK_SET);
> -		read(asic->fd.sensors, &value, 4);
> -		switch (bits[j].stop & 0x0F) {
> -			case SENSOR_IDENTITY:	counts[j] =3D value; break; // identity
> -			case SENSOR_D1000:	counts[j] =3D value/1000; break; // divide by 10=
00 (e.g. KHz =3D> MHz)
> -			case SENSOR_D100:	counts[j] =3D value/100; break; // divide by 100 =
(e.g. 10KHz =3D> MHz)
> +	for (j =3D 0; bits[j].regname; ) {
> +		size =3D 4;
> +		if (bits[j].start =3D=3D AMDGPU_PP_SENSOR_GPU_POWER || !umr_read_sen=
sor(asic, bits[j].start, &value[0], &size)) {
> +			x =3D 0;
> +			if (bits[j].start =3D=3D AMDGPU_PP_SENSOR_GPU_POWER) {
> +				size =3D 4 * sizeof(uint32_t);
> +				memcpy(value, gpu_power_data, size);
> +			}
> +
> +			while (size) {
> +				switch (bits[j].stop & 0x0F) {
> +					case SENSOR_IDENTITY:	counts[j] =3D value[x]; break; // identity
> +					case SENSOR_D1000:	counts[j] =3D value[x]/1000; break; // divide =
by 1000 (e.g. KHz =3D> MHz)
> +					case SENSOR_D100:	counts[j] =3D value[x]/100; break; // divide by=
 100 (e.g. 10KHz =3D> MHz)
> +					case SENSOR_WATT:	counts[j] =3D ((value[x]>>8)*1000);
> +								if ((value[x]&0xFF) < 100)
> +									counts[j] +=3D (value[x]&0xFF)*10;
> +								else
> +									counts[j] +=3D value[x];
> +								counts[j] /=3D 10; // convert to centiwatts since we don't nee=
d 3 digits of excess precision
> +								break;
> +				}
> +				size -=3D 4;
> +				++j;
> +				++x;
> +			}
> +		} else {
> +			++j;
>  		}
>  	}
>  }
> @@ -818,12 +858,13 @@ static void toggle_logger(void)
> =20
>  void umr_top(struct umr_asic *asic)
>  {
> -	int i, j, k;
> +	int i, j, k, use_thread;
>  	struct timespec req;
>  	uint32_t rep;
>  	time_t tt;
>  	uint64_t ts;
>  	char hostname[64] =3D { 0 };
> +	pthread_t sensor_thread;
> =20
>  	if (getenv("HOSTNAME")) strcpy(hostname, getenv("HOSTNAME"));
> =20
> @@ -844,6 +885,18 @@ void umr_top(struct umr_asic *asic)
>  		if (stat_counters[i].is_sensor =3D=3D 0)
>  			grab_bits(stat_counters[i].name, asic, stat_counters[i].bits, &stat=
_counters[i].addr);
> =20
> +	sensor_thread_quit =3D 0;
> +	use_thread =3D 0;
> +
> +	// start thread to grab sensor data for VI
> +	if (asic->family =3D=3D FAMILY_VI) {
> +		if (pthread_create(&sensor_thread, NULL, vi_sensor_thread, asic)) {
> +			fprintf(stderr, "[ERROR] Cannot create vi_sensor_thread\n");
> +			return;
> +		}
> +		use_thread =3D 1;
> +	}
> +
>  	initscr();
>  	start_color();
>  	cbreak();
> @@ -973,4 +1026,9 @@ void umr_top(struct umr_asic *asic)
>  		refresh();
>  	}
>  	endwin();
> +
> +	if (use_thread) {
> +		sensor_thread_quit =3D 1;
> +		pthread_join(sensor_thread, NULL);
> +	}
>  }
> diff --git a/src/lib/CMakeLists.txt b/src/lib/CMakeLists.txt
> index 46c75d61acb4..a5f0bda38689 100644
> --- a/src/lib/CMakeLists.txt
> +++ b/src/lib/CMakeLists.txt
> @@ -14,6 +14,7 @@ add_library(umrcore STATIC
>    find_reg.c
>    mmio.c
>    query_drm.c
> +  read_sensor.c
>    read_sgpr.c
>    read_vram.c
>    ring_decode.c
> diff --git a/src/lib/read_sensor.c b/src/lib/read_sensor.c
> new file mode 100644
> index 000000000000..c4907f83208f
> --- /dev/null
> +++ b/src/lib/read_sensor.c
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright 2017 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +#include "umr.h"
> +
> +int umr_read_sensor(struct umr_asic *asic, int sensor, void *dst, int =
*size)
> +{
> +	int r;
> +	lseek(asic->fd.sensors, sensor*4, SEEK_SET);
> +	r =3D read(asic->fd.sensors, dst, *size);
> +	if (r !=3D *size) {
> +		return -1;
> +	}
> +	*size =3D r;
> +	return 0;
> +}
> diff --git a/src/umr.h b/src/umr.h
> index f2bce13d104b..34e8809eb415 100644
> --- a/src/umr.h
> +++ b/src/umr.h
> @@ -31,6 +31,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <pciaccess.h>
> +#include <pthread.h>
> =20
>  /* sourced from amd_powerplay.h from the kernel */
>  enum amd_pp_sensors {
> @@ -43,6 +44,9 @@ enum amd_pp_sensors {
>  	AMDGPU_PP_SENSOR_GPU_LOAD,
>  	AMDGPU_PP_SENSOR_GFX_MCLK,
>  	AMDGPU_PP_SENSOR_GPU_TEMP,
> +	AMDGPU_PP_SENSOR_VCE_POWER,
> +	AMDGPU_PP_SENSOR_UVD_POWER,
> +	AMDGPU_PP_SENSOR_GPU_POWER,
>  };
> =20
>  enum chipfamily {
> @@ -409,6 +413,7 @@ void umr_enumerate_devices(void);
>  int umr_get_wave_status(struct umr_asic *asic, unsigned se, unsigned s=
h, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws)=
;
>  int umr_get_wave_sq_info(struct umr_asic *asic, unsigned se, unsigned =
sh, unsigned cu, struct umr_wave_status *ws);
>  int umr_read_sgprs(struct umr_asic *asic, struct umr_wave_status *ws, =
uint32_t *dst);
> +int umr_read_sensor(struct umr_asic *asic, int sensor, void *dst, int =
*size);
> =20
>  /* mmio helpers */
>  uint32_t umr_find_reg(struct umr_asic *asic, char *regname);
>=20


--a7E0gdl5tCgUC0Pj8BkkNOkikRCb1DWTL--

--Hvbb4SiP2Eeha1jxXvnetNMCq6VgRAiOA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnlnqAAoJEP4bvbfZuWjbqyUQAKgBL26aKflIkefdYHjADyWI
cA0p4FakeATsIghI1Gn4Z8rAqez6e4rwUzG7eVKVErKZZ6xMt1uFo/NbqJC4sSGE
ClKK3fVxVCeHWgt7ZjTOrwqubdnTaslgDZYT8Ox7JMkog7k8A7YN0IVMN+8s2f4y
dB/eB69w1NkQb/RPtC0k6ivZcCv57g82pLtv1ohKn3Ot7uoB8cgOB1E8L4SKbUWm
tvougdBiYRW7/ovZCTLthvzM88oqtnNECcDtOuh3A3d/8/hISAnit+X+eV1RIPs2
Ovs1FZh/Z35RWWE5zQCUPfZttPrsM8q7Cuxa8QQ0XZVM2i4XXJ0R7iFLlrnyc7mH
yIeGWk999vue8JFyOihbYq5vrQxEVtFVSRxLwdWBE2cZUb4sMk6kLNoXukV5FLhz
6QOIDOX3egwKh83IWcWVFqGefoOoh4/GZUquAdSc4ISwLP8meNZEDurzm2veMG+r
aOuCge+/D7skVuqyjQsZUsu7E/sSoKbJj9GXmYG6RPJq8kzKW7kHgFnqekhBYIr5
n1pQ9NMdnpLO+zK+3LvpeMnsnmv4za+hZ9j5c3FVHayXHBuLJC8l4SFozyOFZOAL
3WxF4hEqgZdkxXRRy6wl6KlV+sTDeGYnuHD58vUHwpn1++Jwmq6lmfdLv+/KLQp3
wJvO5I6PV4ukdGvRQvjl
=NU5V
-----END PGP SIGNATURE-----

--Hvbb4SiP2Eeha1jxXvnetNMCq6VgRAiOA--

--===============1833429154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1833429154==--
