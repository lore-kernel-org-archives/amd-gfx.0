From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 18.0.0
Date: Fri, 2 Mar 2018 18:44:49 +0100
Message-ID: <4be14bba-2ac7-52fd-b0e5-53e2f48d9114@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0580603196=="
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
--===============0580603196==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="milMPvPAxFk2JgL72jF1O3IcXNtAbPHI6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--milMPvPAxFk2JgL72jF1O3IcXNtAbPHI6
Content-Type: multipart/mixed; boundary="56rSk9JDYFwpkbEZHAwCo8BQ9HOoK56hV";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: "xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-announce-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-go0+a7rfsptAfugRpC6u6w@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <4be14bba-2ac7-52fd-b0e5-53e2f48d9114-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [ANNOUNCE] xf86-video-amdgpu 18.0.0

--56rSk9JDYFwpkbEZHAwCo8BQ9HOoK56hV
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable


I'm pleased to announce the 18.0.0 release of xf86-video-amdgpu, the
Xorg driver for AMD Radeon GPUs supported by the amdgpu kernel driver.
This release supports xserver versions 1.13-1.19. It also works with
xserver 1.20 RC1, so unless something unexpected happens, it should work
with xserver 1.20 as well.

Highlights:

* New year-based versioning scheme
* Page flipping can now be used even when the HW cursor can't be used in
  some cases
* Support for 30-bit RGB colour output. Note that gamma correction is
  currently not available with 30-bit colour. Also, hardware
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

Hawking Zhang (1):
      Add 30bit RGB color format support

Keith Packard (2):
      modesetting: Skip no-longer-present connectors when resetting BAD l=
inks
      modesetting: Update property values at detect and uevent time

Mario Kleiner (1):
      Define per x-screen individual drmmode_crtc_funcs

Michel D=C3=A4nzer (20):
      Post-release version bump
      Fix VT switching with ShadowFB
      Bail if there's a problem with ShadowFB
      Free pAMDGPUEnt memory in AMDGPUFreeRec
      Free memory returned by xf86GetEntityInfo
      Call TimerFree for timer created in LeaveVT
      Always call drmModeFreeProperty after drmModeGetProperty
      Use correct ScrnInfoPtr in redisplay_dirty
      Add amdgpu_dirty_src_drawable helper
      Move cursor related ScreenInit calls into AMDGPUCursorInit_KMS
      Keep track of how many SW cursors are visible on each screen
      Fix linear check in amdgpu_glamor_share_pixmap_backing
      Always use screen depth/bpp for KMS framebuffers
      Guard against pAMDGPUEnt =3D=3D NULL in AMDGPUFreeRec
      Don't call AMDGPUFreeRec from AMDGPUPreInit_KMS
      Revert "Guard against pAMDGPUEnt =3D=3D NULL in AMDGPUFreeRec"
      If glamor is too old for depth 30, fall back to ShadowFB
      Don't bail from drmmode_set_desired_modes immediately
      Disable all unused CRTCs before setting desired modes
      Bump version for 18.0.0 release

Qiang Yu (1):
      Disable gamma set when deep color

git tag: xf86-video-amdgpu-18.0.0

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
18.0.0.tar.bz2
MD5:  24b2c9dc27a6083289bc86023eb3b1fe  xf86-video-amdgpu-18.0.0.tar.bz2
SHA1: 360d619de1629913d356c60f1e155553e0e55dbb  xf86-video-amdgpu-18.0.0.=
tar.bz2
SHA256: e909b9707d2562dfc36d8075a8cbddbc93901aaa8f2522d9a429c3fc5ad66d94 =
 xf86-video-amdgpu-18.0.0.tar.bz2
SHA512: 5f9fa173c1b2f90878a9cc961e49abb0ad56db16fd80ec9fe6788fcc90eaa1906=
f3bff74437cb9afa95b9212ff946e1558736739f27e959a3848e77e4dabbd17  xf86-vid=
eo-amdgpu-18.0.0.tar.bz2
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-18.0.0.tar.bz2.sig

https://xorg.freedesktop.org/archive/individual/driver/xf86-video-amdgpu-=
18.0.0.tar.gz
MD5:  042955c587ad786eaa7727a1bb216d93  xf86-video-amdgpu-18.0.0.tar.gz
SHA1: 78d8a3a7fb86efd30a9da53cf055d96f9c03fdf1  xf86-video-amdgpu-18.0.0.=
tar.gz
SHA256: 359c065d91a5866d56c0ffbc802441880a8244b64fc98e2d965aefac0c993e7d =
 xf86-video-amdgpu-18.0.0.tar.gz
SHA512: 45c314012685446985303ec9f87b18fa58d2accd3aad2799dbf49e87f2d374df0=
f6151502fc1e6b5d875f6746b879caba08216f3c2c0086022ad16e56c78ee1e  xf86-vid=
eo-amdgpu-18.0.0.tar.gz
PGP:  https://xorg.freedesktop.org/archive/individual/driver/xf86-video-a=
mdgpu-18.0.0.tar.gz.sig


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--56rSk9JDYFwpkbEZHAwCo8BQ9HOoK56hV--

--milMPvPAxFk2JgL72jF1O3IcXNtAbPHI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWpmNlRMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAANgAoK3hhAWW58F8Uf0uqy7HoR32Nc71AKC2
cLyaxBZTh/XT41lI8n8XlBn2cQ==
=BPm4
-----END PGP SIGNATURE-----

--milMPvPAxFk2JgL72jF1O3IcXNtAbPHI6--

--===============0580603196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0580603196==--
