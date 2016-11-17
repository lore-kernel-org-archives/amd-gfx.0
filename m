From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 1.2.0
Date: Thu, 17 Nov 2016 15:38:59 +0900
Message-ID: <e5ef0058-2ade-c398-14e5-460db2ebb23c@daenzer.net>
Reply-To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0796000162=="
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
--===============0796000162==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VoFCaU8TIuBrCM4BxIefR342MQ4MhGkD2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VoFCaU8TIuBrCM4BxIefR342MQ4MhGkD2
Content-Type: multipart/mixed; boundary="lWa3U5CSHCSfdRPSWjMg1nGirHDlHquRq";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Reply-To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Message-ID: <e5ef0058-2ade-c398-14e5-460db2ebb23c-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 1.2.0

--lWa3U5CSHCSfdRPSWjMg1nGirHDlHquRq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 1.2.0 release of xf86-video-amdgpu, the Xorg
driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.10-1.19.

Highlights:

* Significant 2D compositing performance increase.
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
* The list of supported GPUs in the Xorg log file has been tidied up.
* RandR 1.4 provider capabilities are now advertised more accurately.
* Support for SI family GPUs.

Plus many other improvements and fixes. Thanks to everybody who
contributed to this release in any way!


Adam Jackson (1):
      Adapt Block/WakeupHandler signature for ABI 23

Alex Deucher (1):
      add missing bonaire pci id

Flora Cui (3):
      add strato pci id
      Add more Polaris 10 PCI IDs
      Add more Polaris 11 PCI IDs

Hans de Goede (3):
      Remove unnecessary fb addition from drmmode_xf86crtc_resize
      Only add main fb if necessary
      PRIME: Fix swapping of provider sink / source capabilities

Keith Packard (1):
      Use NotifyFd for drm fd

Marek Ol=C5=A1=C3=A1k (1):
      Fix cursor size for SI

Michel D=C3=A4nzer (65):
      Post 1.1.0 release version bump
      Add support for async flips to radeon_do_pageflip
      present: Support async flips
      Enable DRI3 by default when building for Xorg >=3D 1.18.3
      Handle Zaphod mode correctly in amdgpu_mode_hotplug
      glamor: Fix amdgpu_glamor_share_pixmap_backing for priv->bo =3D=3D =
NULL
      Remove amdgpu_share_pixmap_backing
      Add amdgpu_pixmap_get_tiling_info
      Consolidate get_drawable_pixmap helper
      Move DRI2's local fixup_glamor helper to amdgpu_glamor_set_pixmap_b=
o v2
      glamor: Reallocate linear pixmap BO if necessary for DRI2 PRIME
      glamor: Make amdgpu_glamor_create_textured_pixmap take amdgpu_buffe=
r*
      Propagate failure from amdgpu_set_pixmap_bo
      Use amdgpu_set_pixmap_bo in amdgpu_set_shared_pixmap_backing
      glamor: Fix leak of pixmap private when replacing BO
      Free priv in amdgpu_set_pixmap_bo also if priv->bo =3D=3D NULL
      Adapt to XF86_CRTC_VERSION 7
      Call amdgpu_glamor_create_screen_resources after ModifyPixmapHeader=

      Simplify drmmode_set_mode_major error handling
      Make sure drmmode_crtc->scanout[] are destroyed when not needed
      present: Don't allow flipping when using a dedicated scanout buffer=

      dri2: Don't allow flipping when using a dedicated scanout buffer
      present: Separate checks for flips vs unflips v2
      Remove drmmode_load_palette
      Destroy all dedicated scanout buffers during CloseScreen
      Make the dedicated scanout mechanism work with arbitrary transforms=
 v2
      Remove w/h parameters from amdgpu_scanout_extents_intersect
      Clear damage in amdgpu_scanout_update if it doesn't intersect the C=
RTC
      Add .editorconfig file
      Only use RandR APIs if RandR is enabled
      DRI2: Add interpolated_vblanks in amdgpu_dri2_get_crtc_msc
      Remove unused lut_r/g/b arrays from drmmode_crtc_private_rec
      Add Mullins PCI IDs
      Add missing Kaveri PCI ID (1318)
      Only list each unique chipset family once in the log file
      Add explicit AMDGPU_DRM_QUEUE_ERROR define
      Use EventCallback to avoid flushing every time in the FlushCallback=

      Keep track of damage event related flushes per-client
      Wait for pending flips to complete before turning off an output or =
CRTC
      Use drmmode_crtc_scanout_* helpers for RandR 1.4 scanout pixmaps
      Handle RandR 1.4 slave dirty updates via amdgpu_drm_queue
      Track damage accurately for RandR 1.4 slave scanout
      Only copy from screen pixmap to shared pixmap on demand for slave s=
canout
      Factor out transform_region helper
      Move up amdgpu_scanout_extents_intersect
      Synchronize scanout pixmaps for TearFree
      Make TearFree effective with PRIME slave scanout
      Use --with-xorg-conf-dir=3D$prefix/share/X11/xorg.conf.d by default=

      Fix handling of configure option --with-xorg-conf-dir
      Untangle HAS_XORG_CONF_DIR / --with-xorg-conf-dir lines in configur=
e.ac
      Add support for ScreenPtr::SyncSharedPixmap
      Rotate and reflect cursor hotspot position for drmModeSetCursor2
      Enable HW cursor support with PRIME slave output & Xorg > 1.18.99.9=
01
      Order unique chipsets according to first appearance in ati_pciids.c=
sv
      Say=C5=8Dnara, AM_MAINTAINER_MODE!
      Don't rely on randr_crtc->scanout_pixmap in drmmode_set_scanout_pix=
map
      Always call PixmapStopDirtyTracking in drmmode_set_scanout_pixmap
      Consume all available udev events at once
      present: Check tiling info for flips
      Require xserver 1.10 or newer
      Check Xorg version at runtime instead of build time in two places
      Refactor amdgpu_mode_hotplug
      Use pAMDGPUEnt to find both screens of a GPU in amdgpu_mode_hotplug=

      manpage updates for the 1.2.0 release
      Bump version for 1.2.0 release

Qiang Yu (3):
      Remove RR_Capability_SinkOutput for GPU without CRTC.
      Fix amdgpu_mode_hotplug crash on multi GPU platform.
      DRI2: Fix amdgpu_dri2_exchange_buffers width/height copy'n'paste er=
ror

Ronie Salgado (1):
      Add SI PCI IDs

Tom St Denis (1):
      dri3: Return NULL from amdgpu_dri3_pixmap_from_fd if calloc fails.

git tag: xf86-video-amdgpu-1.2.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
1.2.0.tar.bz2
MD5:  f4e335b580336e03eeef10b08b68d757  xf86-video-amdgpu-1.2.0.tar.bz2
SHA1: 434ab94fcda4070c333c208ffdc19c31341c01c1  xf86-video-amdgpu-1.2.0.t=
ar.bz2
SHA256: 275b1aac5f127f55ba3d7480a1df89eace1d02650e24e46908067fc875e76c8f =
 xf86-video-amdgpu-1.2.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-1.2.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
1.2.0.tar.gz
MD5:  70e0986074c510778f1a644dc63ecca7  xf86-video-amdgpu-1.2.0.tar.gz
SHA1: b918e7c6b670ce104292146b0774a6a67ad76761  xf86-video-amdgpu-1.2.0.t=
ar.gz
SHA256: 99c572cda61007e6da7740a2eb5eb46ea882cc9a51db2c14bb07ba92660deb7a =
 xf86-video-amdgpu-1.2.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-1.2.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--lWa3U5CSHCSfdRPSWjMg1nGirHDlHquRq--

--VoFCaU8TIuBrCM4BxIefR342MQ4MhGkD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFoEARECABoFAlgtUIMTHG1pY2hlbEBkYWVuemVyLm5ldAAKCRBaga+OatuyAESX
AKCR1cZNXr7ud7QgpPYIqx6hNGU3pACglI5A7DXO7IQsHPJYm0C97OfD4N4=
=WA+B
-----END PGP SIGNATURE-----

--VoFCaU8TIuBrCM4BxIefR342MQ4MhGkD2--

--===============0796000162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0796000162==--
