From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 1.1.1
Date: Thu, 15 Sep 2016 16:30:17 +0900
Message-ID: <c5c26b1d-88ed-c845-be65-9c4388e54309@daenzer.net>
Reply-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1496796642=="
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
--===============1496796642==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hxv55G616wHiXvTRJePFK06eGRKJtxHfR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hxv55G616wHiXvTRJePFK06eGRKJtxHfR
Content-Type: multipart/mixed; boundary="PlgvlKD8ou7aM1eo9KuxjsWf1NhkkXq9S";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Reply-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
To: xorg-announce-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, xorg-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <c5c26b1d-88ed-c845-be65-9c4388e54309-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 1.1.1

--PlgvlKD8ou7aM1eo9KuxjsWf1NhkkXq9S
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 1.1.1 release of xf86-video-amdgpu, the Xorg
driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.9-1.18.

This is a stable point release containing only fixes and other minor chan=
ges.

Highlights:

* Support for all currently available GPUs supported by the amdgpu
  kernel driver.
* A few fixes for crash/hang bugs.

Thanks to everybody who contributed to this release in any way!


Alex Deucher (1):
      add missing bonaire pci id

Flora Cui (3):
      add strato pci id
      Add more Polaris 10 PCI IDs
      Add more Polaris 11 PCI IDs

Marek Ol=C5=A1=C3=A1k (1):
      Fix cursor size for SI

Michel D=C3=A4nzer (14):
      Handle Zaphod mode correctly in amdgpu_mode_hotplug
      glamor: Fix amdgpu_glamor_share_pixmap_backing for priv->bo =3D=3D =
NULL
      Remove amdgpu_share_pixmap_backing
      Add amdgpu_pixmap_get_tiling_info
      Consolidate get_drawable_pixmap helper
      Move DRI2's local fixup_glamor helper to amdgpu_glamor_set_pixmap_b=
o v2
      glamor: Reallocate linear pixmap BO if necessary for DRI2 PRIME
      Destroy all dedicated scanout buffers during CloseScreen
      Only use RandR APIs if RandR is enabled
      DRI2: Add interpolated_vblanks in amdgpu_dri2_get_crtc_msc
      Add Mullins PCI IDs
      Add missing Kaveri PCI ID (1318)
      Use --with-xorg-conf-dir=3D$prefix/share/X11/xorg.conf.d by default=

      Bump version for the 1.1.1 release

Qiang Yu (3):
      Remove RR_Capability_SinkOutput for GPU without CRTC.
      Fix amdgpu_mode_hotplug crash on multi GPU platform.
      DRI2: Fix amdgpu_dri2_exchange_buffers width/height copy'n'paste er=
ror

Ronie Salgado (1):
      Add SI PCI IDs

git tag: xf86-video-amdgpu-1.1.1

http://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-1=
=2E1.1.tar.bz2
MD5:  8b2e2852299b330da709d0526b2b8134  xf86-video-amdgpu-1.1.1.tar.bz2
SHA1: 402df5fa62631e7e049261bc29cdc0eb5febe119  xf86-video-amdgpu-1.1.1.t=
ar.bz2
SHA256: b6dfe5fb2a9bba5048135c75a507827bc887ac0790214d62b28c47f22fdd238f =
 xf86-video-amdgpu-1.1.1.tar.bz2
PGP:  http://xorg.freedesktop.org/archive/individual/driver/xf86-video-am=
dgpu-1.1.1.tar.bz2.sig

http://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-1=
=2E1.1.tar.gz
MD5:  23e39d8586fb89da3e606ebbc2f8e911  xf86-video-amdgpu-1.1.1.tar.gz
SHA1: 1acf7e7ead43e69b9122e9bb25b95a734cf3ace3  xf86-video-amdgpu-1.1.1.t=
ar.gz
SHA256: 40dec655b7f9385d08fd648c359eff63012bfacc16397590ad2f9682e1e4527c =
 xf86-video-amdgpu-1.1.1.tar.gz
PGP:  http://xorg.freedesktop.org/archive/individual/driver/xf86-video-am=
dgpu-1.1.1.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--PlgvlKD8ou7aM1eo9KuxjsWf1NhkkXq9S--

--hxv55G616wHiXvTRJePFK06eGRKJtxHfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlfaTgkACgkQWoGvjmrbsgCbwQCfeAn+6r0ew1D6peVpdesMMrgU
oAAAoI0v3QM8Flo/xVNqV30RepAHaTDA
=jhTw
-----END PGP SIGNATURE-----

--hxv55G616wHiXvTRJePFK06eGRKJtxHfR--

--===============1496796642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1496796642==--
