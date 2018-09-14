From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 18.1.0
Date: Fri, 14 Sep 2018 17:41:37 +0200
Message-ID: <42e8057a-51e1-b600-d2fa-9b991d72e1ec@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1023991012=="
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
--===============1023991012==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cRTjYTPj0tdbabMqpHhevie8Y7qa3raW8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cRTjYTPj0tdbabMqpHhevie8Y7qa3raW8
Content-Type: multipart/mixed; boundary="9MB1WFANQvC9FIs5JCf1wPDmPEsHHDKWZ";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <42e8057a-51e1-b600-d2fa-9b991d72e1ec-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 18.1.0

--9MB1WFANQvC9FIs5JCf1wPDmPEsHHDKWZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 18.1.0 release of xf86-video-amdgpu, the
Xorg driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.13-1.20.

Highlights:

* When using DC as of Linux 4.17:
  - Support advanced colour management functionality.
  - Support gamma correction and X11 colormaps when Xorg runs at depth
    30 as well.
* Support for leasing RandR outputs to clients.
* Various robustness fixes for TearFree. In particular, fixed several
  cases in which disabling TearFree at runtime would result in the Xorg
  process freezing or crashing.
* Fixed some m4 related build issues with older versions of autotools.

Plus other improvements and fixes. Thanks to everybody who contributed
to this release in any way!


Emil Velikov (3):
      Move amdgpu_bus_id/amgpu_kernel_mode within amdgpu_kernel_open_fd
      Do not export the DriverRec AMDGPU
      Remove set but unused amdgpu_dri2::pKernelDRMVersion

Jim Qu (1):
      Wait for pending scanout update before calling drmmode_crtc_scanout=
_free

Keith Packard (3):
      modesetting: Record non-desktop kernel property at PreInit time
      modesetting: Create CONNECTOR_ID properties for outputs [v2]
      Add RandR leases support

Leo Li (Sunpeng) (7):
      Cache color property IDs and LUT sizes during pre-init
      Initialize color properties on CRTC during CRTC init
      Configure color properties when creating output resources
      Update color properties on output_get_property
      Enable setting of color properties via RandR
      Compose non-legacy with legacy regamma LUT
      Also compose LUT when setting legacy gamma

Michel D=C3=A4nzer (48):
      Post-release version bump
      Ignore AMDGPU_DRM_QUEUE_ERROR (0) in amdgpu_drm_abort_entry
      Track DRM event queue sequence number in scanout_update_pending
      Abort scanout_update_pending event when possible
      Update RandR CRTC state if set_mode_major fails in set_desired_mode=
s
      Simplify drmmode_crtc_scanout_update
      Don't call scanout_flip/update with a legacy RandR scanout buffer
      Simplify drmmode_handle_transform
      Set drmmode_crtc->scanout_id =3D 0 when TearFree is disabled
      Refactor drmmode_output_set_tear_free helper
      Wait for pending flips in drmmode_output_set_tear_free
      Replace 'foo =3D=3D NULL' with '!foo'
      Call drmmode_do_crtc_dpms from drmmode_crtc_dpms as well
      Use drmmode_crtc_dpms in drmmode_set_desired_modes
      Check dimensions passed to drmmode_xf86crtc_resize
      Don't apply gamma to HW cursor data if colour management is enabled=

      Remove #if 0'd code
      Call drmmode_crtc_gamma_do_set from drmmode_setup_colormap
      Bail from dri2_create_buffer2 if we can't get a pixmap
      glamor: Bail CreatePixmap on unsupported pixmap depth
      Move flush from radeon_scanout_do_update to its callers
      Support gamma correction & colormaps at depth 30 as well
      Hardcode "non-desktop" RandR property name
      Free previous xf86CrtcRec gamma LUT memory
      Don't use DRM_IOCTL_GEM_FLINK in create_pixmap_for_fbcon
      Remove AMDGPUInfoRec::fbcon_pixmap
      Remove drmmode_terminate_leases
      Use strcpy for RandR output property names
      glamor: Set AMDGPU_CREATE_PIXMAP_DRI2 for DRI3 pixmaps
      Store FB for each CRTC in drmmode_flipdata_rec
      glamor: Use glamor_egl_create_textured_pixmap_from_gbm_bo when poss=
ible
      glamor: Check glamor module version for depth 30 support
      Move DRM event queue related initialization to amdgpu_drm_queue_ini=
t
      Add amdgpu_drm_wait_pending_flip function
      Add amdgpu_drm_handle_event wrapper for drmHandleEvent
      Defer vblank event handling while waiting for a pending flip
      Remove drmmode_crtc_private_rec::present_vblank_* related code
      Use correct FB handle in amdgpu_do_pageflip
      Add m4 directory
      Use AC_CONFIG_MACRO_DIR instead of AC_CONFIG_MACRO_DIRS
      Handle ihandle =3D=3D -1 in amdgpu_set_shared_pixmap_backing
      glamor: Handle ihandle =3D=3D -1 in amdgpu_glamor_set_shared_pixmap=
_backing
      Always delete entry from list in drm_queue_handler
      Don't use xorg_list_for_each_entry_safe for signalled flips
      Do not push the CM_GAMMA_LUT property values in drmmode_crtc_cm_ini=
t
      Bail early from drm_wait_pending_flip if there's no pending flip
      Bail from drmmode_cm_init if there's no CRTC
      Bump version for the 18.1.0 release

Slava Grigorev (1):
      Include xf86platformBus.h unconditionally

git tag: xf86-video-amdgpu-18.1.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
18.1.0.tar.bz2
MD5:  5d75f5993cda5e013cd851c5947ec450  xf86-video-amdgpu-18.1.0.tar.bz2
SHA1: d3097af7da3b56396721e214f348e7ceb5f3a358  xf86-video-amdgpu-18.1.0.=
tar.bz2
SHA256: e11f25bb51d718b8ea938ad2b8095323c0ab16f4ddffd92091d80f9a445a9672 =
 xf86-video-amdgpu-18.1.0.tar.bz2
SHA512: 371f1a9f6cd2ce3b7117361222d196950c5efa01d957783c79a37c19a2273ce33=
d133fa51bb68432b8535aad61cb14fbb61d173a167d318b2533eb2507b7a903  xf86-vid=
eo-amdgpu-18.1.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-18.1.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
18.1.0.tar.gz
MD5:  bf0f043a352279febe6117a1ebcfc7ec  xf86-video-amdgpu-18.1.0.tar.gz
SHA1: b66107a6ff61adc9f4956bec2752d7869270e76f  xf86-video-amdgpu-18.1.0.=
tar.gz
SHA256: 36850948a3faf2934e72454ce813620df80220347fe3bffab1522aec82b4810f =
 xf86-video-amdgpu-18.1.0.tar.gz
SHA512: 698396f5df149a63573181f818bba7f5071df1e14650da551bc355d9c5d5da9a8=
e432cb3ae13043438e5dabe8b8790f9a75f8b961977b833858f768e96a81cbd  xf86-vid=
eo-amdgpu-18.1.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-18.1.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--9MB1WFANQvC9FIs5JCf1wPDmPEsHHDKWZ--

--cRTjYTPj0tdbabMqpHhevie8Y7qa3raW8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCW5vWsQAKCRBaga+Oatuy
APcBAJ9jBVfZ/86UOaHANNdG/8y/WGATywCggnQE7aevGOVpgh8JcDwiv00Vxfw=
=J/qN
-----END PGP SIGNATURE-----

--cRTjYTPj0tdbabMqpHhevie8Y7qa3raW8--

--===============1023991012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1023991012==--
