From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed
 with error -2
Date: Fri, 21 Jul 2017 19:44:43 +1000
Message-ID: <886e7938-af54-c9e0-f0a7-2a7f5f73a5ef@longlandclan.id.au>
References: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0411859662=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
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
--===============0411859662==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SKJIgqLV030aBJvArD0R0dAjoGRjVPCDl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SKJIgqLV030aBJvArD0R0dAjoGRjVPCDl
Content-Type: multipart/mixed; boundary="05EaHPCk6nvRi76ojcEmhqh9ofnGqxMru";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <886e7938-af54-c9e0-f0a7-2a7f5f73a5ef-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed
 with error -2
References: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
In-Reply-To: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>

--05EaHPCk6nvRi76ojcEmhqh9ofnGqxMru
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21/07/17 19:20, Stuart Longland wrote:
> I have also tried the drm-next branch of the kernel, commit
> a26307ced13c6f1ad82593964e303b053586b064, with the same effect.
>=20
> I can confirm that /lib/firmware/amdgpu/polaris12_mc.bin exists.  So I
> have no idea why I am getting -ENOENT (aka error -2).  If the file isn'=
t
> to go in /lib/firmware, then where do I put it?

The following .config options in the kernel have worked around the issue
I think:

> CONFIG_FW_LOADER=3Dy
> # CONFIG_FIRMWARE_IN_KERNEL is not set
> CONFIG_EXTRA_FIRMWARE=3D"amdgpu/polaris12_ce.bin amdgpu/polaris12_mc.bi=
n amdgpu/polaris12_me.bin amdgpu/polaris12_mec2.bin amdgpu/polaris12_mec.=
bin amdgpu/polaris12_pfp.bin amdgpu/polaris12_rlc.bin amdgpu/polaris12_sd=
ma1.bin amdgpu/polaris12_sdma.bin amdgpu/polaris12_smc.bin amdgpu/polaris=
12_uvd.bin amdgpu/polaris12_vce.bin"
> CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"

Testing with some of the OpenGL screensavers in xscreensaver seems to
show reasonable performance (well, good enough for my needs: this is a
work PC).

I'm not sure that's the proper solution though.  It at least confirms my
firmware binaries are good though, otherwise I'm certain it wouldn't be
working there either.
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--05EaHPCk6nvRi76ojcEmhqh9ofnGqxMru--

--SKJIgqLV030aBJvArD0R0dAjoGRjVPCDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAllxzQ8ACgkQ+VS7u3lI
1UbSmhAAhpCwEy8CdSrLGemXaDy2Dj/hgBqV/GshP4SImjS8nuz2R+Cz7hiBm6FH
2hTKp0TikSIA8yP7Y7w5UUztOeUrjq/Z3/BAQBnpDjD1hFNI8bJC1YYlWqkIy7u5
Ooj/PzJ62O///G1SVNScriJRxGep5yjSxyxjX4oEMUDS23yTQceiXuXR6iczKYCp
Cd0i/COC9H5HLNA/B+1Vq0OvSqt2BuPfNrDOL8eM9I6lzJVqsMiBD5M9DDddOjEB
/MaBcEHVUwka4jzrpYHXCZi8aR7GnZ27GBXZJE+LjLchb011DABf/+0LHNd/Hpsr
H/z3We78b4G70D7ze1rYG81xcos1PuyhKVtSIwq7BjSayugz4d0m677dcVM8TN1j
Uo1EbyTyhHO5uRrGUR/yLed84lDUP7adriGJUbS+m/fp+wuyWbZuit3DwAvvUAUO
ZhFVBnPi+zo/t9g1HUruu0oUnYaHKZjNS8Vm9H3BjxYxwVMlQQHHBIAI0lb/8Nv7
JMsiVVDFYwyBpFrOMnkbuLoTWROGHL4NSFrEnz2zcJvSk2YlXPKLnKsn8bDKZxok
tcNKK30ybEjDjkVL6Y4FyyASxmCs6Rzu+RGD4MWxtFn/8LRphX8snOLOmD+5LIXQ
5pMDu1KBvPjSWMkz3HxA1i8ZSkgyHItAYe4RP0d7EkhGnZmUpME=
=E2tX
-----END PGP SIGNATURE-----

--SKJIgqLV030aBJvArD0R0dAjoGRjVPCDl--

--===============0411859662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0411859662==--
