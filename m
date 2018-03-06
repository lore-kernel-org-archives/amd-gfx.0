From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 18.0.0
Date: Tue, 6 Mar 2018 18:37:13 +0100
Message-ID: <ac4835ba-fe46-098d-766e-f6f65973681c@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0688613439=="
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
--===============0688613439==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KMDznjZKffaCrQOX2Ido1EcJuo3tpcI9e"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KMDznjZKffaCrQOX2Ido1EcJuo3tpcI9e
Content-Type: multipart/mixed; boundary="sF2RmoyGCvK5lVxYex1LrZ8kJ0OUcSd59";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <ac4835ba-fe46-098d-766e-f6f65973681c-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-ati 18.0.0

--sF2RmoyGCvK5lVxYex1LrZ8kJ0OUcSd59
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 18.0.0 release of xf86-video-ati, the Xorg
driver for ATI/AMD Radeon GPUs supported by the radeon kernel driver.
This release supports xserver versions 1.13-1.19. It also works with
xserver 1.20 RC1, so unless something unexpected happens, it should work
with xserver 1.20 as well.

Highlights:

* New year-based versioning scheme
* Page flipping can now be used even when the HW cursor can't be used in
  some cases
* Support for 30-bit RGB colour output. Note that gamma correction is
  currently not available with 30-bit colour. Also, GLAMOR hardware
  acceleration is not available with 30-bit colour with xserver versions
  before 1.20.

Plus other improvements and fixes. Thanks to everybody who contributed
to this release in any way!


Christoph Haag (1):
      fix include order for present.h configure test

Daniel Martin (3):
      modesetting: Check crtc before searching link-status property
      modesetting: Use helper to fetch drmModeProperty(Blob)s
      modesetting: Reset output_id if drmModeGetConnector failed

Darren Salt (1):
      Clarify when TearFree is automatically enabled.

Fredrik H=C3=B6glund (1):
      exa: Accelerate ARGB2101010 pictures

Joakim Tjernlund (1):
      Fix non GLAMOR build

Keith Packard (2):
      modesetting: Skip no-longer-present connectors when resetting BAD l=
inks
      modesetting: Update property values at detect and uevent time

Mario Kleiner (5):
      Define per x-screen individual drmmode_crtc_funcs
      Skip xf86HandleColormaps() at color depth 30. (v2)
      Support exa screen color depth 30 on Linux 3.16 and later. (v2)
      Add missing depth 30 -> cpp=3D4 handling for DRI2.
      Make XvMC extension initialize at depth 30.

Michel D=C3=A4nzer (23):
      Fix VT switching with ShadowFB
      Post-release version bump
      Bail if there's a problem with ShadowFB
      Unreference pixmap's FB with EXA as well in radeon_set_pixmap_bo
      Free pRADEONEnt memory in RADEONFreeRec
      Free memory returned by xf86GetEntityInfo
      Call TimerFree for timer created in LeaveVT
      Always call drmModeFreeProperty after drmModeGetProperty
      Use correct ScrnInfoPtr in redisplay_dirty
      Add radeon_dirty_src_drawable helper
      Move cursor related ScreenInit calls into RADEONCursorInit_KMS
      Keep track of how many SW cursors are visible on each screen
      Always use screen depth/bpp for KMS framebuffers
      glamor: Allow depth 30 with Xorg >=3D 1.19.99.1
      Don't use RADEONEntPriv in RADEONFreeRec
      Don't call RADEONFreeRec from RADEONPreInit_KMS
      Call RADEONFreeRec from RADEONFreeScreen_KMS even if info =3D=3D NU=
LL
      If glamor is too old for depth 30, fall back to EXA or ShadowFB
      Simplify depth 30 "kernel too old" error message
      Don't bail from drmmode_set_desired_modes immediately
      Disable all unused CRTCs before setting desired modes
      Only change Set/MoveCursor hooks from what we expect
      Bump version for 18.0.0 release

git tag: xf86-video-ati-18.0.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-18.=
0.0.tar.bz2
MD5:  4d41bfe860dc719654cad3f82d00f6f3  xf86-video-ati-18.0.0.tar.bz2
SHA1: da1b89a747264d976d824ddc7b5b4f803d3cf765  xf86-video-ati-18.0.0.tar=
=2Ebz2
SHA256: 2c0368fb620d1fdfa2b435e672d65444c2fb9df21bbaf979298484b89ef83981 =
 xf86-video-ati-18.0.0.tar.bz2
SHA512: a9a634091f208099885039d42433cee061e03968417c0d535691833abcc9162d8=
d0a46f99bac902f0885beb14dcc9a011d104b535ffe492562fd5bb740ad4721  xf86-vid=
eo-ati-18.0.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-18.0.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-ati-18.=
0.0.tar.gz
MD5:  a7beafba592be85a16dd8e94e60fc1a7  xf86-video-ati-18.0.0.tar.gz
SHA1: 02bcbc78d8c9552dce400e84190b68e54384eb31  xf86-video-ati-18.0.0.tar=
=2Egz
SHA256: a755ea4e0afbdd38a4bd13d42c1a684fbdcf0ae84474433b1cde7e1a91e8159d =
 xf86-video-ati-18.0.0.tar.gz
SHA512: 0b627012966d52d8060e621bdf6793fb35f9dc28f31534410f94a12da9ab854ca=
e69bc4937a837edf5d96300b9d906d377940227d7ee8513a9872bed9238c2b1  xf86-vid=
eo-ati-18.0.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
ti-18.0.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--sF2RmoyGCvK5lVxYex1LrZ8kJ0OUcSd59--

--KMDznjZKffaCrQOX2Ido1EcJuo3tpcI9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWp7RyRMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAMH8AoIm/Y8hQNwRXlPEZXjSuf5IfnKTPAJ4u
AiTvcJj4YoBIPPg4gBXLpkbXFw==
=Mnds
-----END PGP SIGNATURE-----

--KMDznjZKffaCrQOX2Ido1EcJuo3tpcI9e--

--===============0688613439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0688613439==--
