From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 7.8.0
Date: Thu, 17 Nov 2016 12:53:46 +0900
Message-ID: <b10fadba-3681-2666-482c-dde662889b43@daenzer.net>
Reply-To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1427034648=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1427034648==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qUcVlGmQ5aHUxghuRx7mNdRDMtD6DFUu4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qUcVlGmQ5aHUxghuRx7mNdRDMtD6DFUu4
Content-Type: multipart/mixed; boundary="jN8Eaqg2qS2XIQXeK21UR1fBIuwCe9A2l";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Reply-To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Message-ID: <b10fadba-3681-2666-482c-dde662889b43-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 7.8.0

--jN8Eaqg2qS2XIQXeK21UR1fBIuwCe9A2l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 7.8.0 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.10-1.19.

Highlights:

* Significant 2D compositing performance increase, in particular with
  glamor enabled.
* Option "TearFree" can now prevent tearing in all possible display
  configurations (with current versions of Xorg). Specifically, it's
  now also effective with arbitrary RandR transforms and with RandR 1.4
  slave output.
* DRI3 is now enabled by default if the Xorg version is >=3D 1.18.3 and
  glamor is enabled.
* DRI3/Present asynchronous page flips are now supported (requires
  corresponding kernel driver support, available in current versions of
  the Linux kernel). This can increase performance of fullscreen
  applications with sync-to-vblank disabled.
* The HW cursor can now be used with RandR 1.4 slave output or with
  TearFree & rotation.
* Performance improvements with RandR 1.4 slave output.
* The list of supported GPUs in the Xorg log file has been slightly
  tidied up.
* RandR 1.4 provider capabilities are now advertised more accurately.

Plus many other improvements and fixes. Thanks to everybody who
contributed to this release in any way!


Adam Jackson (1):
      Adapt Block/WakeupHandler signature for ABI 23

Hans de Goede (3):
      Remove unnecessary fb addition from drmmode_xf86crtc_resize
      Only add main fb if necessary
      PRIME: Fix swapping of provider sink / source capabilities

Keith Packard (1):
      Adapt to video API 22

Michel D=C3=A4nzer (65):
      Post 7.7.0 release version bump
      Add support for async flips to radeon_do_pageflip
      present: Support async flips
      Handle Zaphod mode correctly in radeon_mode_hotplug
      Enable DRI3 by default when building for Xorg >=3D 1.18.3
      Explicitly set the fbcon pixmap pitch again
      Add .editorconfig file
      Adapt to XF86_CRTC_VERSION 7
      Only use RandR APIs if RandR is enabled
      Add explicit RADEON_DRM_QUEUE_ERROR define
      Don't enable micro-tiling for scanout buffers on pre-R600
      Don't enable DRI3 by default with EXA
      Use EventCallback to avoid flushing every time in the FlushCallback=

      Wait for pending flips to complete before turning off an output or =
CRTC
      Keep track of damage event related flushes per-client v2
      Use drmmode_crtc_scanout_* helpers for RandR 1.4 scanout pixmaps
      Handle RandR 1.4 slave dirty updates via radeon_drm_queue
      Track damage accurately for RandR 1.4 slave scanout
      Also call drmmode_clear_pending_flip from radeon_scanout_flip_abort=

      Don't override crtc parameter value in drmmode_flip_handler/abort
      Also handle disabled CRTCs in drmmode_clear_pending_flip
      Fix build against xserver < 1.13
      Only copy from screen pixmap to shared pixmap on demand for slave s=
canout
      Factor out transform_region helper
      Move up radeon_scanout_extents_intersect
      Synchronize scanout pixmaps for TearFree
      Make TearFree effective with PRIME slave scanout
      glamor: Fix radeon_glamor_share_pixmap_backing for priv->bo =3D=3D =
NULL
      Consolidate get_drawable_pixmap helper
      Move DRI2's local fixup_glamor helper to radeon_glamor_set_pixmap_b=
o
      glamor: Reallocate linear pixmap BO if necessary for DRI2 PRIME
      Destroy all dedicated scanout buffers during CloseScreen
      DRI2: Add interpolated_vblanks in radeon_dri2_get_crtc_msc
      Use local implementation of RegionDuplicate for older xserver
      Only define transform_region function for XF86_CRTC_VERSION >=3D 4
      Add support for ScreenPtr::SyncSharedPixmap
      Propagate failure from radeon_set_pixmap_bo
      glamor: Fix leak of pixmap private when replacing BO
      Free priv in amdgpu_set_pixmap_bo also if priv->bo =3D=3D NULL
      Simplify drmmode_set_mode_major error handling
      Make sure drmmode_crtc->scanout[] are destroyed when not needed
      present: Don't allow flipping when using a dedicated scanout buffer=

      dri2: Don't allow flipping when using a dedicated scanout buffer
      present: Separate checks for flips vs unflips
      Remove drmmode_load_palette
      Make the dedicated scanout mechanism work with arbitrary transforms=

      Remove w/h parameters from radeon_scanout_extents_intersect
      Clear damage in radeon_scanout_update if it doesn't intersect the C=
RTC
      Only list each unique chipset family once in the log file
      Rotate and reflect cursor hotspot position for drmModeSetCursor2
      Restore location of radeon_set_pixmap_bo call in drmmode_create_bo_=
pixmap
      Enable HW cursor support with PRIME slave output & Xorg > 1.18.99.9=
01
      Order unique chipsets according to first appearance in ati_pciids.c=
sv
      Remove PCI IDs and bus type from ati_pciids.csv
      Say=C5=8Dnara, AM_MAINTAINER_MODE!
      Don't rely on randr_crtc->scanout_pixmap in drmmode_set_scanout_pix=
map
      Always call PixmapStopDirtyTracking in drmmode_set_scanout_pixmap
      Consume all available udev events at once
      Require xserver 1.10 or newer
      Check Xorg version at runtime instead of build time in two places
      Reindent code in radeon_dri2_create_buffer2
      Refactor radeon_mode_hotplug
      Use pRADEONEnt to find both screens of a GPU in radeon_mode_hotplug=

      Update manpage entry for Option "TearFree"
      Bump version for 7.8.0 release

Qiang Yu (3):
      Remove RR_Capability_SinkOutput for GPU without CRTC
      Fix radeon_mode_hotplug crash on multi GPU platform.
      DRI2: Fix radeon_dri2_exchange_buffers width/height copy'n'paste er=
ror

Tan Hu (2):
      EXA/6xx/7xx: fast solid pixmap support
      EXA/6xx/7xx: accelerate PictOpOver with component alpha

Tom St Denis (1):
      dri3: Return NULL from radeon_dri3_pixmap_from_fd if calloc fails.

git tag: xf86-video-ati-7.8.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-7.8=
=2E0.tar.bz2
MD5:  f34d04a755e761e03b459155fa3ddcbb  xf86-video-ati-7.8.0.tar.bz2
SHA1: 30c4470d1252eade1d5c5998e42b66b0ac80a638  xf86-video-ati-7.8.0.tar.=
bz2
SHA256: 401f5de772928f3dc4ce43a885adb0a47a2f61aa4a9e45d2ab3d184136a9d6fa =
 xf86-video-ati-7.8.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-7.8.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-7.8=
=2E0.tar.gz
MD5:  e65f576288233a2ef0150666b1db02c1  xf86-video-ati-7.8.0.tar.gz
SHA1: 26f7c220d31b4265ee6680d1f9dd0190619ea03e  xf86-video-ati-7.8.0.tar.=
gz
SHA256: da8c721f04c0cdb0b05b084581d2c1457543351a98de4aa0de3e3852512389b6 =
 xf86-video-ati-7.8.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-7.8.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--jN8Eaqg2qS2XIQXeK21UR1fBIuwCe9A2l--

--qUcVlGmQ5aHUxghuRx7mNdRDMtD6DFUu4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFoEARECABoFAlgtKc8THG1pY2hlbEBkYWVuemVyLm5ldAAKCRBaga+OatuyABBD
AJ93/2FqG3ujwA+XoUvd9AcTFP+LmgCgrVdm78Cb72H6cj+EQ1AkXR+NzOo=
=E8I5
-----END PGP SIGNATURE-----

--qUcVlGmQ5aHUxghuRx7mNdRDMtD6DFUu4--

--===============1427034648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1427034648==--
