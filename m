From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed with
 error -2
Date: Fri, 21 Jul 2017 19:20:51 +1000
Message-ID: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1760259394=="
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1760259394==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GPjTtW27jrqhxF0VX6fpRGCgmgAJx226C"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GPjTtW27jrqhxF0VX6fpRGCgmgAJx226C
Content-Type: multipart/mixed; boundary="npdCqhkXwrln2I90648xa2LvBUuuPpsmW";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed with
 error -2

--npdCqhkXwrln2I90648xa2LvBUuuPpsmW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a silly question, hopefully with a very easy answer.  I'm getting
the following error in my kernel `dmesg` at boot:

> [    1.663664] amdgpu 0000:23:00.0: Direct firmware load for amdgpu/pol=
aris12_mc.bin failed with error -2
> [    1.663747] mc: Failed to load firmware "amdgpu/polaris12_mc.bin"
> [    1.663812] [drm:gmc_v8_0_sw_init] *ERROR* Failed to load mc firmwar=
e!
> [    1.663878] [drm:amdgpu_device_init] *ERROR* sw_init of IP block <gm=
c_v8_0> failed -2

This is on kernel 4.12.3, video card is a Asus-branded Radeon RX 550,
and I have tried Gentoo's `sys-kernel/linux-firmware` package, the
firmware installed by `make firmware_install` and downloading firmware
blobs from: https://people.freedesktop.org/~agd5f/radeon_ucode/polaris/

I have also tried the drm-next branch of the kernel, commit
a26307ced13c6f1ad82593964e303b053586b064, with the same effect.

I can confirm that /lib/firmware/amdgpu/polaris12_mc.bin exists.  So I
have no idea why I am getting -ENOENT (aka error -2).  If the file isn't
to go in /lib/firmware, then where do I put it?
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.



--npdCqhkXwrln2I90648xa2LvBUuuPpsmW--

--GPjTtW27jrqhxF0VX6fpRGCgmgAJx226C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAllxx3MACgkQ+VS7u3lI
1UasHQ/+OYeHW2SYrpeAxzI19tvsIV+uQCW0sc+uVEIOsVbVpQYiJY7M7IFIDxf9
+QHUcfGHaitzhdCm5o3K1vhtt1vz3tE0NvpAfY+IEBbBSs4eJMLAYW81Gr5KO5bM
C5UqXIGlKlCTWwq/TcNSAT+IgNfihi8XFyfJ1lPkIYjRIzlZwf4+W++x2BSfhUUl
yrk+UATnzUs2MJX0/JzJyEq5TvOK5NcTKCWnU64Ch+KuJBYGVjpbcvOyLYdmnmj2
wytCjWu4o31JVbWnJ3+rFc0uB1S2uznAF+jANy3HEXb0YbaYAxVqTSBsqf7BpsAm
eWFgMu/gZCTfetYZpniTs4UzDca82/9T5DVyQvyV5iTTyeY1pjGkuKsgVdBMcOgI
2rBLNHf9SW7yoXlL1F6itA0GjmQeG2x+wtmlywj5BWG8Hn8MCpa0W6TceeJfQFEG
LCledsIekVR3d6jVPlV01nNDxV7k4549SpkgV+1N+YhWuTOaUuVss8esGuHfNl+G
LmKnKajveJ1Zsr0gMdHK8QvaPqU3+b5UoU7D/QWE+I3RTE/zTU80VFZuuU/MyGBE
g0SDmxyc9qNYjqUyCKDqu2BRLLDzSv7uJnt7/qjbN6kJzsYO8A363LsCK05ProNP
lWdaaPVVJG05B0Q2AK0AWcd2PazSvXXChzRFc/rtCGOhk1Ytyzg=
=v0hG
-----END PGP SIGNATURE-----

--GPjTtW27jrqhxF0VX6fpRGCgmgAJx226C--

--===============1760259394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1760259394==--
