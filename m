From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 19.0.1
Date: Tue, 19 Mar 2019 18:25:13 +0100
Message-ID: <d4bb92c4-54be-2dc2-d124-a6c58a707d9a@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0866802841=="
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
--===============0866802841==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pP8HdxEHZQRM6zawDjxq7mmW2pLa7g57j"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pP8HdxEHZQRM6zawDjxq7mmW2pLa7g57j
Content-Type: multipart/mixed; boundary="CK1H7iLN0SppNqoq8hJ4kKjNLTwNjb3z1";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <d4bb92c4-54be-2dc2-d124-a6c58a707d9a-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 19.0.1

--CK1H7iLN0SppNqoq8hJ4kKjNLTwNjb3z1
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 19.0.1 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.13-1.20.

This is a bug-fix release, with only three changes:

* Fixes for two regressions which crept into the 19.0.0 release.
* Add support for RandR output tile properties, allowing monitors using
  DisplayPort Multi Stream Transport tiling to work better out of the
  box. (Note that DP MST support in the radeon kernel driver is still
  experimental and disabled by default)

Thanks to everybody who contributed to this release in any way!


Dave Airlie (1):
      modesetting: add tile property support

Michel D=C3=A4nzer (3):
      Revert "glamor: Avoid glamor_create_pixmap for pixmaps backing wind=
ows"
      Use radeon_finish in drmmode_crtc_scanout_update
      Bump version for 19.0.1 release

git tag: xf86-video-ati-19.0.1

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-19.=
0.1.tar.bz2
MD5:  47eccf71823206ade9629cba69de7ef6  xf86-video-ati-19.0.1.tar.bz2
SHA1: e8899c2d237381d9278429a1427e02fcba1d5174  xf86-video-ati-19.0.1.tar=
=2Ebz2
SHA256: 5cb6015d8664546ad1311bc9c363d7bc41ebf60e7046ceb44dd38e5b707961b0 =
 xf86-video-ati-19.0.1.tar.bz2
SHA512: e04c5395e3a49d81b8f7a4b0e11fe8c9ebd17af056a4eab4541873796dce05b10=
3c93fb185f3a00873010df0655cd7311e6d27e177aeb7345c4c8017bbd1eb17  xf86-vid=
eo-ati-19.0.1.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-19.0.1.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-19.=
0.1.tar.gz
MD5:  2135e3681e177d5f62efb04633702b43  xf86-video-ati-19.0.1.tar.gz
SHA1: ad024e197c681cbfc927835e6d41b49bc5de9d2f  xf86-video-ati-19.0.1.tar=
=2Egz
SHA256: b32172e8a70e08af46d1c67395bf55022b4c98c4097462e75efedf2deff874a9 =
 xf86-video-ati-19.0.1.tar.gz
SHA512: ec7e0114a4e781da29aaf2085f21cfe3abac6ac253016494c483a5cb70ecf6b09=
f225b990e26126772ef367c90468a74dc621be86172b39c6d5b8a83d84fea3f  xf86-vid=
eo-ati-19.0.1.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-19.0.1.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer




--CK1H7iLN0SppNqoq8hJ4kKjNLTwNjb3z1--

--pP8HdxEHZQRM6zawDjxq7mmW2pLa7g57j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXJEmAAAKCRBaga+Oatuy
AGQCAKC1dGQZuUGTMIPafdcnZizAU4vIDgCgm+8yBrfKJTlv/zx4KJJCr54NHqQ=
=OGNM
-----END PGP SIGNATURE-----

--pP8HdxEHZQRM6zawDjxq7mmW2pLa7g57j--

--===============0866802841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0866802841==--
