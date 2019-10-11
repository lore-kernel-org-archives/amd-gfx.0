From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 19.1.0
Date: Fri, 11 Oct 2019 18:46:13 +0200
Message-ID: <d42184a578b143e2205f55dcf370834f0b0cfbab.camel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0621236716=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Resent-To: xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Resent-Message-ID: <4923f143-34dd-6507-ed29-979ae5a382eb@daenzer.net>
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
To: xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Cc: xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============0621236716==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-nhXDBgXD2LgU3Q/kw0nZ"


--=-nhXDBgXD2LgU3Q/kw0nZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 19.1.0 release of xf86-video-amdgpu, the
Xorg driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.13-1.20.

There are no big changes in this release, just fixes and other minor
improvements.

Thanks to everybody who contributed to this release in any way!


NOTE:

As of September, I'm no longer working for AMD but for Red Hat's
graphics infrastructure team. I'm hoping that someone from my former
team at AMD will step up to maintain this driver.


Flora Cui (1):
      dri2: reply to client for WaitMSC request in any case

Michel D=C3=A4nzer (13):
      Retry get_fb_ptr in get_fb
      dri3: Always flush glamor before sharing pixmap storage with clients
      dri2: Re-use previous CRTC when possible if pick_best_crtc returns NU=
LL
      Remove dri2_drawable_crtc parameter consider_disabled
      present: Check that we can get a KMS FB for flipping
      Don't disable page flipping completely with SW cursor
      gitlab-ci: Use templates from wayland/ci-templates
      present: Also check pixmap pitch in check_flip with current xserver
      present: Don't check pixmap pitch in check_flip with current DC
      present: Don't check pixmap pitch in check_flip with non-DC >=3D 3.34
      Don't set up black scanout buffer if LeaveVT is called from CloseScre=
en
      Don't unreference FBs of pixmaps from different screens in LeaveVT
      Bump version for the 19.1.0 release

git tag: xf86-video-amdgpu-19.1.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-19=
.1.0.tar.bz2
MD5:  55ad19b858e186a2cf4e91ed832c05e7  xf86-video-amdgpu-19.1.0.tar.bz2
SHA1: 044a97ea2f36dd3d2d4844bb503dd4e2b2854d56  xf86-video-amdgpu-19.1.0.ta=
r.bz2
SHA256: 4f0ea4e0ae61995ac2b7c72433d31deab63b60c78763020aaa1b28696124fe5d  x=
f86-video-amdgpu-19.1.0.tar.bz2
SHA512: ccdaa2378492da1a2f3d18fedacd1318c4708da534a8a959276a82730d5420619d8=
3ad1ec8d7835c55655fe56123cd9bffb44e6223c5a97033c01f598af4a173  xf86-video-a=
mdgpu-19.1.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amd=
gpu-19.1.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-19=
.1.0.tar.gz
MD5:  5aec06fed52d09838d0511c59dd2d861  xf86-video-amdgpu-19.1.0.tar.gz
SHA1: 453ef4c403c1966bb0555057248629a1514ab18e  xf86-video-amdgpu-19.1.0.ta=
r.gz
SHA256: 9967435ca5686395375adea503ee774ddb95181505247d164ee3a1a2995a081f  x=
f86-video-amdgpu-19.1.0.tar.gz
SHA512: 660bea3ff6c8123ebc7df82b8e90308759c1575a3b28fddc95f0e46b575250991ed=
a36f0e85d9db9777d712c247dadc8ce1f45541146ac513ec8874b774a440d  xf86-video-a=
mdgpu-19.1.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amd=
gpu-19.1.0.tar.gz.sig

--=20
Earthling Michel D=C3=A4nzer               |               https://redhat.c=
om
Libre software enthusiast             |             Mesa and X developer

--=-nhXDBgXD2LgU3Q/kw0nZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHEEABECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCXaCx1RMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAYgQAn3PGCJ9pv9d3kdWSSM4pw0fQIRExAKCB
XiWaFB7Mwnn9mf6CiVHzc58lcQ==
=mc73
-----END PGP SIGNATURE-----

--=-nhXDBgXD2LgU3Q/kw0nZ--

--===============0621236716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0621236716==--
