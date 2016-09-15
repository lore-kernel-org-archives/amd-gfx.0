From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 7.7.1
Date: Thu, 15 Sep 2016 18:13:16 +0900
Message-ID: <01bc1a8d-f892-0a69-741c-2835508dcaae@daenzer.net>
Reply-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1017147424=="
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
To: xorg-announce-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xorg-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1017147424==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7RIoiRiSaC04QxggIFjmCdeEprTQSuON8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7RIoiRiSaC04QxggIFjmCdeEprTQSuON8
Content-Type: multipart/mixed; boundary="FcJaCw5sJt28s7S5AuhOkUdgBTfPtab0d";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Reply-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
To: xorg-announce-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xorg-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <01bc1a8d-f892-0a69-741c-2835508dcaae-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 7.7.1

--FcJaCw5sJt28s7S5AuhOkUdgBTfPtab0d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 7.7.1 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.9-1.18.

This is a stable point release containing only fixes for
crash/hang/corruption bugs and other minor changes.

Thanks to Qiang Yu for his contributions to this release!


Michel D=C3=A4nzer (15):
      Handle Zaphod mode correctly in radeon_mode_hotplug
      Explicitly set the fbcon pixmap pitch again
      Only use RandR APIs if RandR is enabled
      Don't enable micro-tiling for scanout buffers on pre-R600
      Wait for pending flips to complete before turning off an output or =
CRTC
      Also call drmmode_clear_pending_flip from radeon_scanout_flip_abort=

      Don't override crtc parameter value in drmmode_flip_handler/abort
      Also handle disabled CRTCs in drmmode_clear_pending_flip
      glamor: Fix radeon_glamor_share_pixmap_backing for priv->bo =3D=3D =
NULL
      Consolidate get_drawable_pixmap helper
      Move DRI2's local fixup_glamor helper to radeon_glamor_set_pixmap_b=
o
      glamor: Reallocate linear pixmap BO if necessary for DRI2 PRIME
      Destroy all dedicated scanout buffers during CloseScreen
      DRI2: Add interpolated_vblanks in radeon_dri2_get_crtc_msc
      Bump version for 7.7.1 release

Qiang Yu (3):
      Remove RR_Capability_SinkOutput for GPU without CRTC
      Fix radeon_mode_hotplug crash on multi GPU platform.
      DRI2: Fix radeon_dri2_exchange_buffers width/height copy'n'paste er=
ror

git tag: xf86-video-ati-7.7.1

http://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-7.7.=
1.tar.bz2
MD5:  e46f30e24d9d6acdb256d8a63e0ec07c  xf86-video-ati-7.7.1.tar.bz2
SHA1: 146be259bd725a0252e2909e1320e42e0a11d582  xf86-video-ati-7.7.1.tar.=
bz2
SHA256: 00a58588db62ee309095c5c5920bbd248d965e8627f88affe68a73b18865078d =
 xf86-video-ati-7.7.1.tar.bz2
PGP:  http://xorg.freedesktop.org/archive/individual/driver/xf86-video-at=
i-7.7.1.tar.bz2.sig

http://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-7.7.=
1.tar.gz
MD5:  c01f4204fc2bd1890010d7c50a4a01e3  xf86-video-ati-7.7.1.tar.gz
SHA1: 1369b2c48af1cf06673be0e87285b5ab61b7a282  xf86-video-ati-7.7.1.tar.=
gz
SHA256: 890906208cfa41d3ab720e0cfa2ec3ff390fc40e3cdd4f21873db4c5c94abd85 =
 xf86-video-ati-7.7.1.tar.gz
PGP:  http://xorg.freedesktop.org/archive/individual/driver/xf86-video-at=
i-7.7.1.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--FcJaCw5sJt28s7S5AuhOkUdgBTfPtab0d--

--7RIoiRiSaC04QxggIFjmCdeEprTQSuON8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlfaZiwACgkQWoGvjmrbsgB2yACdHDvconlMafi8U7A0dRCYw9tZ
NNcAmwQvOpkgXu5N07cqHbww1IiMas6R
=CGK6
-----END PGP SIGNATURE-----

--7RIoiRiSaC04QxggIFjmCdeEprTQSuON8--

--===============1017147424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1017147424==--
