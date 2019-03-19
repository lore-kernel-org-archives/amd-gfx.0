From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 19.0.1
Date: Tue, 19 Mar 2019 18:52:39 +0100
Message-ID: <bdc28d1a-f776-3c62-d782-88d513fdb582@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1708294777=="
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
--===============1708294777==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r7KjxtxM8rUQdCA1B7d5NmGXEmaX6F9Tt"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r7KjxtxM8rUQdCA1B7d5NmGXEmaX6F9Tt
Content-Type: multipart/mixed; boundary="jiF6X4YwEsLbRf6WCE4yGVmdngB1G75JE";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <bdc28d1a-f776-3c62-d782-88d513fdb582-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 19.0.1

--jiF6X4YwEsLbRf6WCE4yGVmdngB1G75JE
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 19.0.1 release of xf86-video-amdgpu, the
Xorg driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.13-1.20.

This is a minor follow-up release with only one change:

* Add support for RandR output tile properties, allowing monitors using
  DisplayPort Multi Stream Transport tiling to work better out of the
  box.

Thanks to everybody who contributed to this release in any way!


Dave Airlie (1):
      modesetting: add tile property support

Michel D=C3=A4nzer (1):
      Bump version for the 19.0.1 release

git tag: xf86-video-amdgpu-19.0.1

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
19.0.1.tar.bz2
MD5:  f3b33958e99c896084f12cd48f7ba007  xf86-video-amdgpu-19.0.1.tar.bz2
SHA1: 2952d2a4e25a6e27cfbd49c11727400eb80f7fe0  xf86-video-amdgpu-19.0.1.=
tar.bz2
SHA256: aaa197196aadcb12e93e10a2aa03c9aedc9ba7b27c2643a8ef620d41e2d1c6d5 =
 xf86-video-amdgpu-19.0.1.tar.bz2
SHA512: dda04e3ccee140354f59e04895cf50cd7dc06a105c40ce35069613c5b5fbe083c=
ab6833fd293d96334f64dde1a0c4af6154d473594a144f37404188ae7f37dd5  xf86-vid=
eo-amdgpu-19.0.1.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-19.0.1.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
19.0.1.tar.gz
MD5:  4827bddcc4022937b8f581e958ca7a04  xf86-video-amdgpu-19.0.1.tar.gz
SHA1: 48f53d14407a0baf605fbe8ad65774cf1ff37a52  xf86-video-amdgpu-19.0.1.=
tar.gz
SHA256: 1ad8d92a47453360fdaf07c80ac03e7bb8c1548f0cec4c2aa0166aa9ddd26dff =
 xf86-video-amdgpu-19.0.1.tar.gz
SHA512: 34e45c1d64d034053508dde3409591130ef643ebab62d4fbfa63bdfd71c9909d4=
8fddd92941986714196c5280193fbbe54fb705f96ddd0424e86aa43258a90a4  xf86-vid=
eo-amdgpu-19.0.1.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-19.0.1.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer




--jiF6X4YwEsLbRf6WCE4yGVmdngB1G75JE--

--r7KjxtxM8rUQdCA1B7d5NmGXEmaX6F9Tt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXJEsZwAKCRBaga+Oatuy
AKOLAJ9Xljkm3ihtTBjv/cPkPB0MFHQ1WgCeMej7ae/zLZFuDVq6EMfuoH7JJn8=
=BEW0
-----END PGP SIGNATURE-----

--r7KjxtxM8rUQdCA1B7d5NmGXEmaX6F9Tt--

--===============1708294777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1708294777==--
