From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: [ANNOUNCE] xf86-video-ati 7.10.0
Date: Fri, 8 Sep 2017 17:19:12 +0900
Message-ID: <0672583e-7cb7-2b17-f4ee-20f8175eb9e0@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1031540186=="
Return-path: <xorg-bounces@lists.x.org>
List-Unsubscribe: <https://lists.x.org/mailman/options/xorg>,
 <mailto:xorg-request@lists.x.org?subject=unsubscribe>
List-Archive: <https://lists.x.org/archives/xorg>
List-Post: <mailto:xorg@lists.x.org>
List-Help: <mailto:xorg-request@lists.x.org?subject=help>
List-Subscribe: <https://lists.x.org/mailman/listinfo/xorg>,
 <mailto:xorg-request@lists.x.org?subject=subscribe>
Errors-To: xorg-bounces@lists.x.org
Sender: "xorg" <xorg-bounces@lists.x.org>
To: "xorg-announce@lists.x.org" <xorg-announce@lists.x.org>
Cc: "xorg@lists.x.org" <xorg@lists.x.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1031540186==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QbiKfqGlGQestSXCT6nGnJnULU59gkDIr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbiKfqGlGQestSXCT6nGnJnULU59gkDIr
Content-Type: multipart/mixed; boundary="3J6G0o2nxB0dVKd4dcsmxd4oD1AOng3T0";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: "xorg-announce@lists.x.org" <xorg-announce@lists.x.org>
Cc: "xorg@lists.x.org" <xorg@lists.x.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <0672583e-7cb7-2b17-f4ee-20f8175eb9e0@daenzer.net>
Subject: [ANNOUNCE] xf86-video-ati 7.10.0

--3J6G0o2nxB0dVKd4dcsmxd4oD1AOng3T0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 7.10.0 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.13-1.19.

Highlights:

* Clients can now use DRI page flipping even while TearFree is enabled
  for any CRTC. This should improve performance of such clients
  (including compositing managers) while TearFree is enabled, and avoid
  other issues such as tearing on other CRTCs where TearFree isn't
  enabled.
* The driver now takes measures to prevent other DRM master processes
  (potentially from other local users) from accessing buffers created by
  this driver while switched away to a different VT. Other DRM master
  processes should only be able to access a single buffer anymore, which
  contains only all-black pixels.
* The gamma ramp is now applied to the HW cursor as well, so the HW
  cursor doesn't look odd when e.g. using Redshift or similar tools.

Plus other improvements and fixes. Thanks to everybody who
contributed to this release in any way!


Adam Jackson (1):
      modesetting: Validate the atom for enum properties

Daniel Stone (1):
      Set correct DRM event context version

Eric Anholt (1):
      Use plain glamor_egl_create_textured_screen().

Martin Peres (1):
      modesetting: re-set the crtc's mode when link-status goes BAD

Michel D=C3=A4nzer (46):
      Post-release version bump
      manpage: Don't put "'" at the beginning of a line
      Don't set modes before RADEONWindowExposures_oneshot is called
      Apply gamma correction to HW cursor
      Pass pixmap instead of handle to radeon_do_pageflip
      Use reference counting for tracking KMS framebuffer lifetimes
      Simplify tracking of PRIME scanout pixmap
      Remove unused struct members from drmmode_display.h
      Update URLs
      Include xf86Pci.h for DRICreatePCIBusID with xserver Git master
      Only call drmmode_scanout_free for non-GPU screens in LeaveVT
      Increase reference count of FB assigned to drmmode_crtc->flip_pendi=
ng
      Improve drmmode_fb_reference debugging code
      Use pRADEONEnt->fd exclusively for the DRM file descriptor
      Use drmmode_crtc->scanout_id instead of 0 to check for scanout buff=
er
      If a TearFree flip fails, fall back to non-TearFree operation
      Only handle reflection in the driver with Xorg < 1.16
      Add AC_CONFIG_MACRO_DIRS([m4]) to configure.ac
      Makefile.am: Set ACLOCAL_AMFLAGS =3D -I m4
      autogen.sh: Pass -f to autoreconf
      Use root window (pixmap) instead of screen pixmap for scanout updat=
es
      Add drmmode_crtc_can_flip helper
      Allow DRI page flipping when some CRTCs use separate scanout buffer=
s
      Adapt to PixmapDirtyUpdateRec::src being a DrawablePtr
      Remove drmmode_crtc->scanout_destroy[] array
      Pass reference CRTC to radeon_do_pageflip directly
      Create drmmode_wait_vblank helper
      Create drmmode_crtc_wait_pending_event helper macro
      Wait for pending flips synchronously before turning off a CRTC
      Handle multiple "pending" Present flips
      Add source drawable parameter to radeon_scanout_do_update
      Pass extents to radeon_scanout_do_update
      Always allow Present page flipping with TearFree
      Always allow DRI2 page flipping with TearFree
      Consolidate radeon_scanout_flip_abort/handler helpers
      Use xorg_list_append for the DRM event list
      Make radeon_scanout_do_update take a PixmapPtr instead of a Drawabl=
ePtr
      Create radeon_pixmap_clear helper
      Create drmmode_set_mode helper
      Create radeon_pixmap_get_fb_ptr helper
      Create radeon_master_screen helper
      Make all active CRTCs scan out an all-black framebuffer in LeaveVT
      Remove drmmode_scanout_free
      Use a timer for unreferencing the all-black FB
      Require xserver >=3D 1.13
      Bump version for 7.10.0 release

git tag: xf86-video-ati-7.10.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-7.1=
0.0.tar.bz2
MD5:  0ff538f78ae82ccce384dadf7a705863  xf86-video-ati-7.10.0.tar.bz2
SHA1: 38e535ecc8445c1b9464ac34db959337929887f7  xf86-video-ati-7.10.0.tar=
=2Ebz2
SHA256: ee51d642e3105cb5424f02622dc2966b87b42d498bb34104a70fcf6d4a8f4e79 =
 xf86-video-ati-7.10.0.tar.bz2
SHA512: 1f2f4af1d299af62644693e6fbc47a5078c9bc5e7887a1ac217121ef2fd29d8c9=
f50a8d9be9ddb0887d0b49141bb33484f82c1313a472ad6867266b53b4a11ad  xf86-vid=
eo-ati-7.10.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-7.10.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-7.1=
0.0.tar.gz
MD5:  daff3026be1dd006d036946888d25174  xf86-video-ati-7.10.0.tar.gz
SHA1: 347093581ed1d3c168308ab9590498f6876157be  xf86-video-ati-7.10.0.tar=
=2Egz
SHA256: 4592bf0a7cdc3c6f40b52cffea15e32e2ef832ac18835c1875e5143cd91db68d =
 xf86-video-ati-7.10.0.tar.gz
SHA512: 24d2c3beb411045ef7aba367310202bc1c621d4066bac12b0f507d2de8f575e60=
37846a8fab6217c24514b356e0a3c7a725fa58d1e5a5fb4e8803a5b829a82b9  xf86-vid=
eo-ati-7.10.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-7.10.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--3J6G0o2nxB0dVKd4dcsmxd4oD1AOng3T0--

--QbiKfqGlGQestSXCT6nGnJnULU59gkDIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWbJShBMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IA/AAAnjDf+vxBgX2zpOXAd3vLMrkvDFI+AJ0S
7qUvN/TwesUNuoIYb0Pud5TSzg==
=9mC6
-----END PGP SIGNATURE-----

--QbiKfqGlGQestSXCT6nGnJnULU59gkDIr--

--===============1031540186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KeG9yZ0BsaXN0
cy54Lm9yZzogWC5Pcmcgc3VwcG9ydApBcmNoaXZlczogaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9hcmNoaXZlcy94b3JnCkluZm86IGh0dHBzOi8vbGlzdHMueC5vcmcvbWFpbG1hbi9saXN0
aW5mby94b3JnCllvdXIgc3Vic2NyaXB0aW9uIGFkZHJlc3M6ICUodXNlcl9hZGRyZXNzKXM=

--===============1031540186==--
