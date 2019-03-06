From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 19.0.0
Date: Wed, 6 Mar 2019 12:48:46 +0100
Message-ID: <4d42cb99-d09d-c25c-7fad-822fe90b95ac@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1913458495=="
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
--===============1913458495==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="K1pWJtootNgI5TSjDhRtURs0lMjLLJvdJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K1pWJtootNgI5TSjDhRtURs0lMjLLJvdJ
Content-Type: multipart/mixed; boundary="CaC5kebDh6aUQqMsUwOk46A8CHhEFnsCM";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <4d42cb99-d09d-c25c-7fad-822fe90b95ac-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 19.0.0

--CaC5kebDh6aUQqMsUwOk46A8CHhEFnsCM
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 19.0.0 release of xf86-video-amdgpu, the
Xorg driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.13-1.20.

Highlights:

* Support for FreeSync variable refresh rate (this also requires the
  amdgpu driver from kernel 5.0 or newer, and radeonsi from Mesa 19.0 or
  newer).
* Various TearFree related fixes and robustness improvements.
* Support for scanout buffers using DCC colour compression.
* Up to six independent instances per GPU are now supported in "Zaphod"
  style multi-head configurations.

Plus other improvements and fixes. Thanks to everybody who contributed
to this release in any way!


Mario Kleiner (1):
      Fix crash when page flipping in multi-X-Screen/Zaphod mode

Michel D=C3=A4nzer (53):
      Post-release version bump
      Convert README to markdown
      Handle pending scanout update in drmmode_crtc_scanout_free
      Make wait_pending_flip / handle_deferred symmetric in set_mode_majo=
r
      Cast return value of amdgpu_get_marketing_name to char*
      Fix --disable-glamor build
      Add GitLab CI configuration
      Fix condition for calling set_pixmap_bo in drmmode_xf86crtc_resize
      Allow up to six instances in Zaphod mode
      Detect and fix up non-premultiplied cursor data
      glamor: Can work at depth >=3D 15 with current xserver Git master
      man: This driver supports colour depths 8, 15 and 16
      Add README.md to EXTRA_DIST
      Relax detection of non-premultiplied alpha cursor data
      Use drm_abort_one in drm_queue_handler
      Explicitly keep track of whether a DRM event is for a flip or not
      Move deferred vblank events to separate drm_vblank_deferred list
      Skip gamma correction of cursor data if premultiplied R/G/B > alpha=

      Generate docker image as part of CI pipeline
      Perform scanout buffer update immediately if drmmode_wait_vblank fa=
ils
      Cancel pending scanout update in drmmode_crtc_scanout_update
      Automatically try re-enabling TearFree after a flip failed
      Don't use GBM for allocating HW cursor BOs
      Drop AMDGPUInfoRec::cursor_buffer array
      Use drmIoctl in drmmode_show_cursor
      Update cursor position in drmmode_show_cursor if hotspot changed
      Use two HW cursor buffers per CRTC
      Don't clear info->flip_window in present_unflip
      Remove superfluous vrr_flipping field and clean up related code
      gitlab-ci: Use kaniko instead of docker-in-docker for image generat=
ion
      Only call drmmode_uevent_init if RandR is enabled
      Only call drmmode_validate_leases if RandR is enabled
      dri3: Flush if necessary in dri3_fd_from_pixmap
      dri2: Flush in dri2_create_buffer2 after calling glamor_set_pixmap_=
bo
      glamor: Avoid glamor_create_pixmap for pixmaps backing windows
      Don't allow TearFree scanout flips to complete in the same vblank p=
eriod
      Only update drmmode_crtc->flip_pending after actually submitting a =
flip
      Call drmHandleEvent again if it was interrupted by a signal
      Keep waiting for a pending flip if drm_handle_event returns 0
      gitlab-ci: Only run docker-image stage if relevant source files cha=
nge
      gitlab-ci: Don't rely on $CI_PROJECT_NAME
      Don't register a window private if VRR is disabled
      Don't enable the VRR support code for GPU screens
      Wrap change/delete window property request handlers
      Make use of property request wrappers for VRR property
      Call amdgpu_present_set_screen_vrr from amdgpu_vrr_property_update
      present: Check that flip and screen pixmap pitches match
      dri2: Call drm_queue_handle_deferred in dri2_deferred_event
      Revert "gitlab-ci: Only run docker-image stage if relevant source f=
iles change"
      Revert "Remove set but unused amdgpu_dri2::pKernelDRMVersion"
      Make drmmode_cm_enabled an inline function
      present: Don't check tiling parameters with DC & DRM minor version =
>=3D 31
      Bump version for the 19.0.0 release

Nicholas Kazlauskas (2):
      Check last flip window instead of screen root before flipping
      Support CRTC variable refresh for windows using Present flips

git tag: xf86-video-amdgpu-19.0.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
19.0.0.tar.bz2
MD5:  a9a1bee983e570614a78ae9070223149  xf86-video-amdgpu-19.0.0.tar.bz2
SHA1: 7a9c6f08ec7c0a8cc665079c8f49716febc73729  xf86-video-amdgpu-19.0.0.=
tar.bz2
SHA256: 8836147d4755908ec9e192b7cc485fbc2ce7706de33f7bea515294d3ba4c4f51 =
 xf86-video-amdgpu-19.0.0.tar.bz2
SHA512: 6a30fc03185816307f16693cd6b07f13694ca1b6b1327c58a951bccc8082f112b=
b768ab610229dc1040617eef860fc1ab17a7e6bf635c5a4e454e252f3addca8  xf86-vid=
eo-amdgpu-19.0.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-19.0.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
19.0.0.tar.gz
MD5:  0bac9edb72a3692c878647da7eed3f79  xf86-video-amdgpu-19.0.0.tar.gz
SHA1: bf54ef93c8936f2e830bc3edfa5dd47ae755c461  xf86-video-amdgpu-19.0.0.=
tar.gz
SHA256: 87216d3b234c81f7023f90e151a94253d6cfbbd2958b8e2308c34e5def6e5ac0 =
 xf86-video-amdgpu-19.0.0.tar.gz
SHA512: b6c84937a4d7279372dfa140270fe767be27677c9c3a093952468c60bcca421ed=
1f7577a47b6d8f055f3e2bae55fbcdd9d4c8f98bcb33da2cd5a1c5750f540e8  xf86-vid=
eo-amdgpu-19.0.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-19.0.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--CaC5kebDh6aUQqMsUwOk46A8CHhEFnsCM--

--K1pWJtootNgI5TSjDhRtURs0lMjLLJvdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXH+zpAAKCRBaga+Oatuy
AHLfAJ9/JJJletHmMpB2d3qM3fjFmLCPigCeLypSP2AjZ+yrC9JalTwrzAAl024=
=nRLZ
-----END PGP SIGNATURE-----

--K1pWJtootNgI5TSjDhRtURs0lMjLLJvdJ--

--===============1913458495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1913458495==--
