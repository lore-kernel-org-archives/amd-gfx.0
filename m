From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 18.0.1
Date: Thu, 15 Mar 2018 16:54:51 +0100
Message-ID: <9a2eeaae-c7c3-98b6-f9c2-f655d0de8efd@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185450954=="
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
--===============0185450954==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tC5zKoJodhemJcLBBiAx7dCcmEs3zImiR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tC5zKoJodhemJcLBBiAx7dCcmEs3zImiR
Content-Type: multipart/mixed; boundary="zQqHczr9AT9pVjtvPu6dTTmOlzjVBGdhA";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <9a2eeaae-c7c3-98b6-f9c2-f655d0de8efd-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 18.0.1

--zQqHczr9AT9pVjtvPu6dTTmOlzjVBGdhA
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 18.0.1 release of xf86-video-amdgpu, the
Xorg driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.13-1.19. It also works with
xserver 1.20 RC1, so unless something unexpected happens, it should work
with xserver 1.20 as well.

This is a bug-fix release addressing issues in 18.0.0. While those
issues shouldn't affect most users, I recommend that all users of 18.0.0
update to 18.0.1.

* The Xorg process could enter an infinite loop after a server reset (in
  configurations where Xorg doesn't terminate when the last client
  disconnects)
* The Xorg process could crash when multiple primary screens are
  configured in xorg.conf.
* TearFree could trigger debugging messages in the pixman library


Michel D=C3=A4nzer (4):
      Only change Set/MoveCursor hooks from what we expect
      Wrap the whole miPointerScreenFuncRec, instead of only Set/MoveCurs=
or
      Pass extents to amdgpu_scanout_do_update by value
      Bump version for 18.0.1 release

git tag: xf86-video-amdgpu-18.0.1

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
18.0.1.tar.bz2
MD5:  d8368d204cb98d4387c8890562db1143  xf86-video-amdgpu-18.0.1.tar.bz2
SHA1: a9c7125eae9870f26afa5167d5683f8d5e1b43c0  xf86-video-amdgpu-18.0.1.=
tar.bz2
SHA256: 7484682ccb403b3ca9e26d1c980572f08cdfa3469e2b2c9a9affc3d51b52691b =
 xf86-video-amdgpu-18.0.1.tar.bz2
SHA512: eb3b76240d4e5084d68b5063b5b19ad5f5bb1f93ea9929301d9e17a48ddc1cb71=
3b76529cb93d133b3547fe78ae8a4455f6b15f6ddf88c29349f82bb1a0db1c4  xf86-vid=
eo-amdgpu-18.0.1.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-18.0.1.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
18.0.1.tar.gz
MD5:  b47ac1d853a5c9327c526b6ad858dfd0  xf86-video-amdgpu-18.0.1.tar.gz
SHA1: 6de47bf590bb3c931da323341c326ab19e159f27  xf86-video-amdgpu-18.0.1.=
tar.gz
SHA256: 5cbbc37aeb6c451e0d446e6e653ae2bf9269727c6394f0751507bb23ad6c16b2 =
 xf86-video-amdgpu-18.0.1.tar.gz
SHA512: 857b9cf817f3cb676abd850b05286037f6c236fbdf7012af5f25424cd2436bc85=
2cd08e3bfdd8f401e827824158344f1243f6f79aeffffd07e28c5ca6769f806  xf86-vid=
eo-amdgpu-18.0.1.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-18.0.1.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--zQqHczr9AT9pVjtvPu6dTTmOlzjVBGdhA--

--tC5zKoJodhemJcLBBiAx7dCcmEs3zImiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWqqXSxMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IACBwAmwcn2nnB6kSDEIcOjnesniaWAAsQAJ4l
4xqa3pafcAGMrSUcZ8nGKPqdjg==
=/Mu7
-----END PGP SIGNATURE-----

--tC5zKoJodhemJcLBBiAx7dCcmEs3zImiR--

--===============0185450954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0185450954==--
