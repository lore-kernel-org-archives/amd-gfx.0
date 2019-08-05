From: Mark Brown <broonie@kernel.org>
Subject: Re: next/master build: 230 builds: 5 failed, 225 passed, 6 errors,
 1344 warnings (next-20190805)
Date: Mon, 5 Aug 2019 12:12:05 +0100
Message-ID: <20190805111205.GB6432@sirena.org.uk>
References: <5d47f990.1c69fb81.a5d88.ee1f@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1329295621=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5d47f990.1c69fb81.a5d88.ee1f@mx.google.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Tao Zhou <tao.zhou1@amd.com>, Dennis Li <dennis.li@amd.com>
Cc: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
List-Id: amd-gfx.lists.freedesktop.org


--===============1329295621==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 02:40:32AM -0700, kernelci.org bot wrote:

Today's -next fails to build an arm allmodconfig due to:

> allmodconfig (arm, gcc-8) =E2=80=94 FAIL, 2 errors, 16 warnings, 0 sectio=
n mismatches
>=20
> Errors:
>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:279:9: error: implicit dec=
laration of function 'readq'; did you mean 'readb'? [-Werror=3Dimplicit-fun=
ction-declaration]
>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:298:3: error: implicit dec=
laration of function 'writeq'; did you mean 'writeb'? [-Werror=3Dimplicit-f=
unction-declaration]

due to 4fa1c6a679bb0 (drm/amdgpu: add RREG64/WREG64(_PCIE) operations)
which introduces use of readq() and writeq().

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1IDwQACgkQJNaLcl1U
h9ARMQf8CpKTcEPj9AoJAXRS0EO8wCrctRVwqRqJ4Vb13LXHkmNV9a15IgiKoEM7
OHHTwl/t/mBlajYsyoghxsgB0aIXckM5rJ77d+GEFQln4rkjx3ZmxFwZKhUNNbcE
3Jn5jYj3B37pbnzB7aYJK1ESO9lKOHY45ZcywGG+cvgqWuRHu8jdCuQXE3xFbNBM
CdDJh3JK5ihmP97JCGSUvGZCJS8StLHsLzJ0G2/K7wCYM86N3NxIYKeDuwYtXgna
tWl6ZwwsnV70LLjGueAHIUC3kk/2vi9UHpjLpUr8PZI9f3WKJZfibW+7JqqYgp/5
S6J7mggMrr4WljGwRgLwbuKFDmPKkw==
=mwnn
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

--===============1329295621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1329295621==--
