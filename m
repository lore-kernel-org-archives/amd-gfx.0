From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: start using linux hdmi header
Date: Tue, 10 Jan 2017 12:35:47 +1100
Message-ID: <357cc7ab-1c2e-4a08-791f-e0c0e3507e2b@folklore1984.net>
References: <20170109233332.9102-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0333368078=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170109233332.9102-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0333368078==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cbffiwRSSS5Wfk0FWkwrvvE2cnUD9Md2R"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cbffiwRSSS5Wfk0FWkwrvvE2cnUD9Md2R
Content-Type: multipart/mixed; boundary="xrmfrotRHNfVhDRtohHA4t6eDjSSIVrKJ";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <357cc7ab-1c2e-4a08-791f-e0c0e3507e2b-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: start using linux hdmi header
References: <20170109233332.9102-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20170109233332.9102-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--xrmfrotRHNfVhDRtohHA4t6eDjSSIVrKJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 01/10/2017 10:33 AM, Dave Airlie wrote:
> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> DAL has defines for things, and it doesn't even use them itself.
>=20
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 18 ++++++++------=
----
>  .../gpu/drm/amd/display/include/set_mode_types.h   | 22 +-------------=
--------
>  2 files changed, 9 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_resource.c
> index 2b08f5a..0f8bb6e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1333,13 +1333,12 @@ static void set_avi_info_frame(
> =20
>  	/* Initialize header */
>  	info_frame.avi_info_packet.info_packet_hdmi.bits.header.
> -			info_frame_type =3D INFO_FRAME_AVI;
> +			info_frame_type =3D HDMI_INFOFRAME_TYPE_AVI;
>  	/* InfoFrameVersion_3 is defined by CEA861F (Section 6.4), but shall
>  	* not be used in HDMI 2.0 (Section 10.1) */
> -	info_frame.avi_info_packet.info_packet_hdmi.bits.header.version =3D
> -			INFO_FRAME_VERSION_2;
> +	info_frame.avi_info_packet.info_packet_hdmi.bits.header.version =3D 2=
;
>  	info_frame.avi_info_packet.info_packet_hdmi.bits.header.length =3D
> -			INFO_FRAME_SIZE_AVI;
> +			HDMI_AVI_INFOFRAME_SIZE;
> =20
>  	/*
>  	 * IDO-defined (Y2,Y1,Y0 =3D 1,1,1) shall not be used by devices buil=
t
> @@ -1472,10 +1471,9 @@ static void set_avi_info_frame(
>  	check_sum =3D
>  		&info_frame.
>  		avi_info_packet.info_packet_hdmi.packet_raw_data.sb[0];
> -	*check_sum =3D INFO_FRAME_AVI + INFO_FRAME_SIZE_AVI
> -			+ INFO_FRAME_VERSION_2;
> +	*check_sum =3D HDMI_INFOFRAME_TYPE_AVI + HDMI_AVI_INFOFRAME_SIZE + 2;=

> =20
> -	for (byte_index =3D 1; byte_index <=3D INFO_FRAME_SIZE_AVI; byte_inde=
x++)
> +	for (byte_index =3D 1; byte_index <=3D HDMI_AVI_INFOFRAME_SIZE; byte_=
index++)
>  		*check_sum +=3D info_frame.avi_info_packet.info_packet_hdmi.
>  				packet_raw_data.sb[byte_index];
> =20
> @@ -1586,7 +1584,7 @@ static void set_vendor_info_packet(struct core_st=
ream *stream,
>  		info_packet->sb[5] =3D stream->public.timing.hdmi_vic;
> =20
>  	/* Header */
> -	info_packet->hb0 =3D 0x81; /* VSIF packet type. */
> +	info_packet->hb0 =3D HDMI_INFOFRAME_TYPE_VENDOR; /* VSIF packet type.=
 */
>  	info_packet->hb1 =3D 0x01; /* Version */
> =20
>  	/* 4 lower bits =3D Length, 4 higher bits =3D 0 (reserved) */
> @@ -1627,7 +1625,7 @@ static void set_spd_info_packet(struct core_strea=
m *stream,
>  		/* HB0  =3D Packet Type =3D 0x83 (Source Product
>  		 *	  Descriptor InfoFrame)
>  		 */
> -		info_packet->hb0 =3D 0x83;
> +		info_packet->hb0 =3D HDMI_INFOFRAME_TYPE_SPD;
> =20
>  		/* HB1  =3D Version =3D 0x01 */
>  		info_packet->hb1 =3D 0x01;
> @@ -1649,7 +1647,7 @@ static void set_spd_info_packet(struct core_strea=
m *stream,
>  		/* HB1  =3D Packet Type =3D 0x83 (Source Product
>  		 *	  Descriptor InfoFrame)
>  		 */
> -		info_packet->hb1 =3D 0x83;
> +		info_packet->hb1 =3D HDMI_INFOFRAME_TYPE_SPD;
> =20
>  		/* HB2  =3D [Bits 7:0 =3D Least significant eight bits -
>  		 *	  For INFOFRAME, the value must be 1Bh]
> diff --git a/drivers/gpu/drm/amd/display/include/set_mode_types.h b/dri=
vers/gpu/drm/amd/display/include/set_mode_types.h
> index d18210f..fee2b6f 100644
> --- a/drivers/gpu/drm/amd/display/include/set_mode_types.h
> +++ b/drivers/gpu/drm/amd/display/include/set_mode_types.h
> @@ -27,6 +27,7 @@
>  #define __DAL_SET_MODE_TYPES_H__
> =20
>  #include "dc_types.h"
> +#include <linux/hdmi.h>
> =20
>  /* Info frame packet status */
>  enum info_frame_flag {
> @@ -36,27 +37,6 @@ enum info_frame_flag {
>  	INFO_PACKET_PACKET_UPDATE_SCAN_TYPE =3D 8
>  };
> =20
> -/* Info frame types */
> -enum info_frame_type {
> -	INFO_FRAME_GAMUT =3D 0x0A,
> -	INFO_FRAME_VENDOR_INFO =3D 0x81,
> -	INFO_FRAME_AVI =3D 0x82
> -};
> -
> -/* Info frame versions */
> -enum info_frame_version {
> -	INFO_FRAME_VERSION_1 =3D 1,
> -	INFO_FRAME_VERSION_2 =3D 2,
> -	INFO_FRAME_VERSION_3 =3D 3
> -};
> -
> -/* Info frame size */
> -enum info_frame_size {
> -	INFO_FRAME_SIZE_AVI =3D 13,
> -	INFO_FRAME_SIZE_VENDOR =3D 25,
> -	INFO_FRAME_SIZE_AUDIO =3D 10
> -};
> -
>  struct hdmi_info_frame_header {
>  	uint8_t info_frame_type;
>  	uint8_t version;
>=20


--xrmfrotRHNfVhDRtohHA4t6eDjSSIVrKJ--

--cbffiwRSSS5Wfk0FWkwrvvE2cnUD9Md2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdDp0AAoJEP4bvbfZuWjbMHcP+QE1i47WbBadlqMuEhmqERO8
j/y0B2oF7D0eXcODs9pi7WCNMd3biINgXhUO61a7urKTTE7ZOU/ZkfiGqcXZBW1f
MGeuqP6mtgb1WGSKXf3RzJQpEdXX19JIWd24a3x89YHGbSfa7YLIZ808coTq9nGo
KkSA21aIl5m0n1xsR5/Q5Iw/Gyv8VYCsbQWATG1/TGcKvAjtimpkPQgspu50wNIs
o2G4pDX363h1HdUeVlK1Seo59TtM7P0NWNay/CauiyXWC8NC6ZMxSmtYxA4WL/86
qgG+1GE9iShxtApTZT/eNOqaSiu7I6lICLGFUeXsZPyhxgCuRW0LKz0L/Ic8RjEQ
Z8dY3RjRP0hQM7VIbPQuMHLxpAgFx+tjg9eOyNCZ4I+wxJclcAdrvd3acsXpwdzC
5IUHzCSY2gj8ebeOQAaJ6bsmaaODzCZe4yngVGwU/FOQx7kHer0I9g/jXbsSXNEM
B2+HSoNfBKfpZ3t12vz57ksSt+w4//lZ8fu6d3rR5P/Q+zPcAC0tH/qKPB3h1wxg
2vrc7UGgG/0Yl1XB66Slaqh+8uNGuxDM+mk4s7Ujin5oZ61PbaKxreTSfuel4ses
YM46DIl1eLi/iYW/6TNHPuaGHYRGJtxTfDLVCHlalXS/0sezIoceOs7q5Se5aRQq
8aavEQl/X8Emv5A/6aIr
=t/R9
-----END PGP SIGNATURE-----

--cbffiwRSSS5Wfk0FWkwrvvE2cnUD9Md2R--

--===============0333368078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0333368078==--
