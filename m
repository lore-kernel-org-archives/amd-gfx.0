From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 19.0.0
Date: Wed, 6 Mar 2019 18:14:09 +0100
Message-ID: <dec347ed-340d-7000-a605-19ec16620aa2@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008035298=="
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
--===============2008035298==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wHMnRa7pSqOotq4U0upkHpU1AHyJFTT8c"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wHMnRa7pSqOotq4U0upkHpU1AHyJFTT8c
Content-Type: multipart/mixed; boundary="Vt5Zh1lPJozfk0V7yIpF7wPi2fx7fndJ0";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <dec347ed-340d-7000-a605-19ec16620aa2-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 19.0.0

--Vt5Zh1lPJozfk0V7yIpF7wPi2fx7fndJ0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 19.0.0 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.13-1.20.

Highlights:

* Various TearFree related fixes and robustness improvements.
* Up to six independent instances per GPU are now supported in "Zaphod"
  style multi-head configurations.

Plus other improvements and fixes. Thanks to everybody who contributed
to this release in any way!


Alan Coopersmith (1):
      Update README for gitlab migration

Mario Kleiner (1):
      Fix crash when page flipping in multi-X-Screen/Zaphod mode

Michel D=C3=A4nzer (30):
      dri3: Handle radeon_get_pixmap_bo returning NULL
      Handle pending scanout update in drmmode_crtc_scanout_free
      Make wait_pending_flip / handle_deferred symmetric in set_mode_majo=
r
      Allow up to six instances in Zaphod mode
      Post-release version bump
      Detect and fix up non-premultiplied cursor data
      Skip gamma correction of cursor data if premultiplied R/G/B > alpha=

      glamor: Can work at depth >=3D 15 with current xserver Git master
      Use drm_abort_one in drm_queue_handler
      Explicitly keep track of whether a DRM event is for a flip or not
      Move deferred vblank events to separate drm_vblank_deferred list
      Perform scanout buffer update immediately if drmmode_wait_vblank fa=
ils
      Cancel pending scanout update in drmmode_crtc_scanout_update
      Automatically try re-enabling TearFree after a flip failed
      Drop RADEONInfoRec::cursor_bo array
      Use drmIoctl in drmmode_show_cursor
      Update cursor position in drmmode_show_cursor if hotspot changed
      Use two HW cursor buffers per CRTC
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
      present: Check that flip and screen pixmap pitches match
      dri2: Call drm_queue_handle_deferred in dri2_deferred_event
      Bump version for 19.0.0 release

git tag: xf86-video-ati-19.0.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-19.=
0.0.tar.bz2
MD5:  0a95c1c8158d658bd0b3ac38a1b31382  xf86-video-ati-19.0.0.tar.bz2
SHA1: c7bb5d25ca725b8fa625a5f1a6948433e51b98a5  xf86-video-ati-19.0.0.tar=
=2Ebz2
SHA256: dd907d318884bb6e81e7e62da7bb34af26aeeed3a81c21e0b46a4f3cae3ff457 =
 xf86-video-ati-19.0.0.tar.bz2
SHA512: 0674c8befa926fd3b431ce80d90f2cd0de17314efe7fd3a5ed0d78018d6cd3262=
5b514bf68436a47eb15e5ad4b50317f3c09fd687b77e69a067d1210ee459827  xf86-vid=
eo-ati-19.0.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-19.0.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-19.=
0.0.tar.gz
MD5:  b00599fcb50647d0ead2e47b020bcd3d  xf86-video-ati-19.0.0.tar.gz
SHA1: 530769c5497f24438e1061a5f10cd17eb5b9b7b2  xf86-video-ati-19.0.0.tar=
=2Egz
SHA256: cf3e10db23c6fd1e6be7662662073f580705652ef2f450ac7948c2ee6b021163 =
 xf86-video-ati-19.0.0.tar.gz
SHA512: 189786e996200a0561ab1ce62c85a4d1be8c679c371a43e547a2c8617ffe53081=
2b17ee70729d71fec4e876c55f66deea3468edfeba669e4aeaa958f7529180c  xf86-vid=
eo-ati-19.0.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-19.0.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--Vt5Zh1lPJozfk0V7yIpF7wPi2fx7fndJ0--

--wHMnRa7pSqOotq4U0upkHpU1AHyJFTT8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXH//4QAKCRBaga+Oatuy
AEIgAKCjR7Nk6DF9U3f+twzf4zLBeWf61wCeKib0daFSKKjApZz/ZiKcYSWvhA8=
=rir4
-----END PGP SIGNATURE-----

--wHMnRa7pSqOotq4U0upkHpU1AHyJFTT8c--

--===============2008035298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2008035298==--
