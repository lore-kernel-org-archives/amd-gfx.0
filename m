From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 18.1.0
Date: Fri, 14 Sep 2018 18:10:37 +0200
Message-ID: <6a9d01f6-1c30-ee3b-0ed7-3b812d6d15b1@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1675705096=="
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
--===============1675705096==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PwEe4kws52r10DaGx3VG66XxOOWtvg1ZP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PwEe4kws52r10DaGx3VG66XxOOWtvg1ZP
Content-Type: multipart/mixed; boundary="PVcjtpQQzhHk5qzNBZw4QJy55BPZ9bW6A";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <6a9d01f6-1c30-ee3b-0ed7-3b812d6d15b1-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 18.1.0

--PVcjtpQQzhHk5qzNBZw4QJy55BPZ9bW6A
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 18.1.0 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.13-1.20.

Highlights:

* Fixed random screen corruption and crashes when using GLAMOR with Xorg
  1.20.
* Support for leasing RandR outputs to clients.
* Various robustness fixes for TearFree. In particular, fixed several
  cases in which disabling TearFree at runtime would result in the Xorg
  process freezing or crashing.
* Fixed some m4 related build issues with older versions of autotools.

Plus other improvements and fixes. Thanks to everybody who contributed
to this release in any way!


Emil Velikov (1):
      Do not export the DriverRec RADEON

Jammy Zhou (1):
      Remove throttling from radeon_dri2_copy_region2

Jim Qu (1):
      Wait for pending scanout update before calling drmmode_crtc_scanout=
_free

Keith Packard (3):
      modesetting: Record non-desktop kernel property at PreInit time
      modesetting: Create CONNECTOR_ID properties for outputs [v2]
      Add RandR leases support

Michel D=C3=A4nzer (55):
      Bail from dri2_create_buffer2 if we can't get a pixmap
      glamor: Bail CreatePixmap on unsupported pixmap depth
      Drop unused drmmode_create_bo_pixmap surface parameter
      EXA: Remove old RADEONEXACreatePixmap hook
      Only initialize libdrm_radeon surface manager for >=3D R600
      glamor: Don't store radeon_surfaces in pixmaps
      Factor out radeon_surface_initialize helper
      Move flush from radeon_scanout_do_update to its callers
      Refactor radeon_finish helper
      Add struct radeon_buffer
      glamor: Use GBM for BO allocation when possible
      Swap pixmap privates in radeon_dri2_exchange_buffers
      Ignore RADEON_DRM_QUEUE_ERROR (0) in radeon_drm_abort_entry
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
      Remove #if 0'd code
      Call drmmode_crtc_gamma_do_set from drmmode_setup_colormap
      glamor: Fix glamor_block_handler argument in radeon_glamor_finish
      glamor: Invalidate cached GEM handle in radeon_set_pixmap_bo
      Don't allocate drmmode_output->props twice
      Hardcode "non-desktop" RandR property name
      Remove drmmode_terminate_leases
      Use strcpy for RandR output property names
      Bump version to 18.0.99
      glamor: Use glamor_egl_create_textured_pixmap_from_gbm_bo when poss=
ible
      glamor: Set RADEON_CREATE_PIXMAP_DRI2 for DRI3 pixmaps
      Store FB for each CRTC in drmmode_flipdata_rec
      Use correct FB handle in radeon_do_pageflip
      Move DRM event queue related initialization to radeon_drm_queue_ini=
t
      Add radeon_drm_wait_pending_flip function
      Add radeon_drm_handle_event wrapper for drmHandleEvent
      Defer vblank event handling while waiting for a pending flip
      Remove drmmode_crtc_private_rec::present_vblank_* related code
      Add m4 directory
      Use AC_CONFIG_MACRO_DIR instead of AC_CONFIG_MACRO_DIRS
      EXA: Handle NULL BO pointer in radeon_set_pixmap_bo
      Handle ihandle =3D=3D -1 in radeon_set_shared_pixmap_backing
      EXA: Handle ihandle =3D=3D -1 in RADEONEXASharePixmapBacking
      glamor: Handle ihandle =3D=3D -1 in radeon_glamor_set_shared_pixmap=
_backing
      Always delete entry from list in drm_queue_handler
      Don't use xorg_list_for_each_entry_safe for signalled flips
      Bail early from drm_wait_pending_flip if there's no pending flip
      Fix uninitialized use of local variable pitch in radeon_setup_kerne=
l_mem
      Bump version for 18.1.0 release

git tag: xf86-video-ati-18.1.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-18.=
1.0.tar.bz2
MD5:  7910883fff7f4a462efac0fe059ed7e3  xf86-video-ati-18.1.0.tar.bz2
SHA1: 87beb7d09f5b722570adda9a5a1822cbd19e7059  xf86-video-ati-18.1.0.tar=
=2Ebz2
SHA256: 6c335f423c1dc3d904550d41cb871ca4130ba7037dda67d82e3f1555e1bfb9ac =
 xf86-video-ati-18.1.0.tar.bz2
SHA512: 7a58c9a6cb4876bd2ff37d837372b4e360e81fec7de6a6c7a48d70a5338d62745=
f734f5d4207f30aa368ff2d9ef44f5f1ef36afd73802a618998c16fe395ed53  xf86-vid=
eo-ati-18.1.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-18.1.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-18.=
1.0.tar.gz
MD5:  1c87fc7777e3ebf10a0704a01433bfbf  xf86-video-ati-18.1.0.tar.gz
SHA1: 055c462d858f2f77f015b829c3cdc6d8ae3dda3d  xf86-video-ati-18.1.0.tar=
=2Egz
SHA256: e029878dc3528dc5115ae20387b1d1e3ba8b4fd13012ff998d2ff1ec48d3cf64 =
 xf86-video-ati-18.1.0.tar.gz
SHA512: 8bd5fbe3c716acffea07793d5850faac99d6a5f72ec3c36069e8ec5bcf4c2fd70=
c5f92c682da5e9152149e5fb1e679386f668746e6560ed75098f5a69ae8d875  xf86-vid=
eo-ati-18.1.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-18.1.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--PVcjtpQQzhHk5qzNBZw4QJy55BPZ9bW6A--

--PwEe4kws52r10DaGx3VG66XxOOWtvg1ZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCW5vdfQAKCRBaga+Oatuy
AKRtAKC0Czww8x1qG8OFSIag0ZMt1gUCmgCfSx4RAQFr56//3BPXYqrnxqbc7pw=
=JBrh
-----END PGP SIGNATURE-----

--PwEe4kws52r10DaGx3VG66XxOOWtvg1ZP--

--===============1675705096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1675705096==--
