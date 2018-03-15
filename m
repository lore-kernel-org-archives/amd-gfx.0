From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 18.0.1
Date: Thu, 15 Mar 2018 17:27:12 +0100
Message-ID: <7b5942e5-7459-039f-8687-c1e3def4b4d0@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0258002884=="
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
--===============0258002884==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bFH2d19qAG4JnW4890sItcC5WANzL7GLL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bFH2d19qAG4JnW4890sItcC5WANzL7GLL
Content-Type: multipart/mixed; boundary="bBXHnG38jBdTr15u4eOpMh4AHE5esiURa";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <7b5942e5-7459-039f-8687-c1e3def4b4d0-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 18.0.1

--bBXHnG38jBdTr15u4eOpMh4AHE5esiURa
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 18.0.1 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.13-1.19. It also works with
xserver 1.20 RC1, so unless something unexpected happens, it should work
with xserver 1.20 as well.

This is a bug-fix release addressing issues in 18.0.0. While those
issues shouldn't affect most users, I recommend that all users of 18.0.0
update to 18.0.1.

* The Xorg process could crash when multiple primary screens are
  configured in xorg.conf.
* TearFree could trigger debugging messages in the pixman library


Michel D=C3=A4nzer (3):
      Wrap the whole miPointerScreenFuncRec, instead of only Set/MoveCurs=
or
      Pass extents to radeon_scanout_do_update by value
      Bump version for 18.0.1 release

git tag: xf86-video-ati-18.0.1

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-18.=
0.1.tar.bz2
MD5:  40e7c0a5a69aba3d84e0958f58705ea7  xf86-video-ati-18.0.1.tar.bz2
SHA1: b5a0b6a2fa839d668a3fb90280fede95f0bc130d  xf86-video-ati-18.0.1.tar=
=2Ebz2
SHA256: 72ea3b8127d4550b64f797457f5a7851a541fa4ee2cc3f345b6c1886b81714a0 =
 xf86-video-ati-18.0.1.tar.bz2
SHA512: b468a78503a596bbf71a1b91b231ce1fa32908f619ff2dfe249352d046696a364=
1f2a9ff065e32545fff77100134b4b237591215e78ef885b6509d6b16112d14  xf86-vid=
eo-ati-18.0.1.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-18.0.1.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-18.=
0.1.tar.gz
MD5:  c31422ce05a21aedf7db9d53b80b3589  xf86-video-ati-18.0.1.tar.gz
SHA1: a810079f3c6e37b298661af5936d8d8f6886d03c  xf86-video-ati-18.0.1.tar=
=2Egz
SHA256: 41fc2ed7a36f02e89dd6765afd92700021f8126e77afe936317d47456c21d506 =
 xf86-video-ati-18.0.1.tar.gz
SHA512: 2532f4be9dc62eab4bf2f55f64fffbf587ea96902ffda6f7ee54707a91986759f=
c385aef04991c5f6a857a611dc2686ff5e0a66f050dada68447f2657b5d28aa  xf86-vid=
eo-ati-18.0.1.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-18.0.1.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--bBXHnG38jBdTr15u4eOpMh4AHE5esiURa--

--bFH2d19qAG4JnW4890sItcC5WANzL7GLL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWqqe4BMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAWDgAniKcG6u8II8cSgrqQZyQQDtZyJoTAJ9/
4sRHYAIhkSB1ZF6kHk1puMGhpw==
=SMBX
-----END PGP SIGNATURE-----

--bFH2d19qAG4JnW4890sItcC5WANzL7GLL--

--===============0258002884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0258002884==--
