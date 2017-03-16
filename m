From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 1.3.0
Date: Thu, 16 Mar 2017 17:45:04 +0900
Message-ID: <6f32285d-e12b-341f-4ef7-af1a1559ee37@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0950091459=="
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
--===============0950091459==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="K0cloSe9cT4kO5HtSJbWI9PHjDk7msrGc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K0cloSe9cT4kO5HtSJbWI9PHjDk7msrGc
Content-Type: multipart/mixed; boundary="goew8OPtXEi00kVXgxfB0gr4lkF4xWA4f";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <6f32285d-e12b-341f-4ef7-af1a1559ee37-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 1.3.0

--goew8OPtXEi00kVXgxfB0gr4lkF4xWA4f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 1.3.0 release of xf86-video-amdgpu, the Xorg
driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.10-1.19.

Highlights:

* Allow TearFree to be toggled at runtime via an RandR output property
  "TearFree". The xorg.conf option "TearFree" now controls the default
  value of the output properties.
* Use libdrm_amdgpu functionality to determine the GPU marketing name,
  remove corresponding tables from this driver.
* Use DRM render nodes for DRI3 clients when available.

Plus many other improvements and fixes. Thanks to everybody who
contributed to this release in any way!


Emil Velikov (1):
      autogen.sh: use quoted string variables

Hans De Goede (1):
      amdgpu_probe: Do not close server managed drm fds

Jammy Zhou (1):
      Use render node for DRI3 if available

Michel D=C3=A4nzer (44):
      Post-release version bump
      Move struct amdgpu_gpu_info out of amdgpu_get_tile_config
      Use family information from libdrm_amdgpu / kernel
      Stop using generated amdgpu_device_match
      Remove amdpciids.h
      Stop using AMDGPUPciChipsets
      Stop using AMDGPU(Unique)Chipsets
      Remove generated header files
      Use DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE/RELATIVE flags when availabl=
e
      Make libdrm >=3D 2.4.72 requirement explicit
      Don't install Flush/EventCallback for GPU screens
      Add amdgpu_is_gpu_screen helper
      Take current scanout_id into account everywhere involved with TearF=
ree
      Fix amdgpu_scanout_extents_intersect for GPU screens
      Call ValidateGC after ChangeClip in amdgpu_sync_scanout_pixmaps
      Call amdgpu_drm_abort_entry on failure to flip to a scanout pixmap
      Simplify drmmode_handle_uevents
      Pass pitch from drmmode_crtc_scanout_allocate to drmmode_create_bo_=
pixmap
      Call drmmode_crtc_scanout_create in drmmode_crtc_shadow_allocate as=
 well
      Fold drmmode_crtc_scanout_allocate into drmmode_crtc_scanout_create=

      Handle rotation in the driver also with Xorg 1.12-1.18
      Fix flip event data leak if calloc or drmModeAddFB fails
      Don't destroy current FB if drmModeAddFB fails
      Factor out amdgpu_prime_dirty_to_crtc helper
      Factor out drmmode_crtc_scanout_update helper
      Allow toggling TearFree at runtime via output property
      Use drmmode_crtc_scanout_free in drmmode_fini
      present: Only call drmModeRmFB after setting modes for unflip
      present: Wait for GPU idle before setting modes for unflip
      present: Also flush before using a flip to unflip
      present: Use async flip for unflip if possible
      present: Flush before flipping
      Call drmmode_set_desired_modes from a WindowExposures hook
      Move DPMS check from amdgpu_scanout_do_update to amdgpu_scanout_fli=
p
      Don't call amdgpu_glamor_flush in drmmode_copy_fb
      Don't use pScrn->is_gpu in AMDGPUCreateScreenResources_KMS
      Use local implementation of RegionDuplicate for older xserver
      Only define transform_region for XF86_CRTC_VERSION >=3D 4
      glamor: Don't flush in BlockHandler with Xorg >=3D 1.19
      Refactor amdgpu_kernel_close_fd helper
      glamor: Use glamor_finish when available
      Skip some initialization steps for GPU screens
      Pass TRUE to drmmode_set_desired_modes the first time for GPU scree=
ns
      Bump version for 1.3.0 release

Mihail Konev (1):
      autogen: add default patch prefix

Peter Hutterer (1):
      autogen.sh: use exec instead of waiting for configure to finish

jimqu (1):
      udev_monitor_receive_device() will block when hotplug monitor

git tag: xf86-video-amdgpu-1.3.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
1.3.0.tar.bz2
MD5:  e2ee9e16ffbd45ebda68a7ff638a04f2  xf86-video-amdgpu-1.3.0.tar.bz2
SHA1: 7b89fe6e22e6739257c0f03c9f034c9c579a8bce  xf86-video-amdgpu-1.3.0.t=
ar.bz2
SHA256: c1630f228938be949273f72b29ae70822dde064ad79c3ccb14d55f427e3f4e70 =
 xf86-video-amdgpu-1.3.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-1.3.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
1.3.0.tar.gz
MD5:  c0c3d95fb2865008f1347bf9f38c0f44  xf86-video-amdgpu-1.3.0.tar.gz
SHA1: cc5766dd9a7851ef18f2718987777054f31e9cd2  xf86-video-amdgpu-1.3.0.t=
ar.gz
SHA256: 05f4a1bbd3a0653551cb9871a554ec4b84c35d00a8fb101f772fc154253eb1e0 =
 xf86-video-amdgpu-1.3.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-1.3.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--goew8OPtXEi00kVXgxfB0gr4lkF4xWA4f--

--K0cloSe9cT4kO5HtSJbWI9PHjDk7msrGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWMpQlBMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAzFIAn1u98K0wZsQEPtqYo93YsxmZSk9KAJ9F
cq4UC6jrfywbzw5lWihALK7+NQ==
=xr7H
-----END PGP SIGNATURE-----

--K0cloSe9cT4kO5HtSJbWI9PHjDk7msrGc--

--===============0950091459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0950091459==--
