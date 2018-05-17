From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 24/24] drm/amdgpu: Move GEM BO to drm_framebuffer
Date: Thu, 17 May 2018 17:08:44 +0200
Message-ID: <20180517150844.GQ26515@ulmo>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
 <20180330141138.28987-1-daniels@collabora.com>
 <20180330141138.28987-24-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0460308782=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180330141138.28987-24-daniels@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Stone <daniels@collabora.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org


--===============0460308782==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:11:38PM +0100, Daniel Stone wrote:
> Since drm_framebuffer can now store GEM objects directly, place them
> there rather than in our own subclass. As this makes the framebuffer
> create_handle and destroy functions the same as the GEM framebuffer
> helper, we can reuse those.
>=20
> Signed-off-by: Daniel Stone <daniels@collabora.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 36 +++++------------=
------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            | 10 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h          |  1 -
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 17 ++++-------
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 17 ++++-------
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 17 ++++-------
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 17 ++++-------
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c          |  4 +--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++----
>  10 files changed, 40 insertions(+), 96 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr9mvwACgkQ3SOs138+
s6GxvhAAlX/Wy0QDT0dh01DRaj4dKEYLQbOb26djROwAvY3lFAmd4eeMcnQHPQQZ
q1kERP+IJSon0FLSibx2NRXJujWfdyfn77EYziglb23jRz57W0rEA0+bRH/BAJes
XvJTQjlvPs9T/bLhusv7L5l9lncblVhuA0M4VCGns6RHB++3c+NuJtScGJULdCs5
qwvdK12WnJOcT20QCW0GVeiCOOoSD92NNafGzbO9pFHAluPI6h6EwR3QreaHmIvn
Rg/gvnJ7kSkz8i9F+jDsFZozsiMpbknS6dUh3kL+vfbrSv5FevQFF4R/mNSsPiQ8
mxr5pywL8FPprzWUMjH5h9Ae45CAlDzBFkDzg4ndXtg+7PU7RaFtHrvV1RrzTQ1L
l1EIn5Q3KQDzCnt86L1fAjn5xP7YLOay1dvn+6ZOt+aqJBiOBC2pCVZuWSNRJwMG
2sV09P939tURoyrlkm6O1yVLbCNTUUkmUCTQHiPTU5i+1ii//S4HR15fiCxyhCnL
YAGSF4JKb52UtY/nzwvP9v+LxA4aD+h+7KD1sBP/ILibIfU00CGB5J+r89qoKnqy
ZBRvkXKkMORuUibwWRHx78KVaioNJe7TTilfH0HOMpwWWo0T6ZCq0ZezKJt8/5ZB
IY/JIc03VcJkiS1ojFuzx6UzEgFegSdsIIEV4GxNKsA/9OhY7p0=
=Y8Cm
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--

--===============0460308782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0460308782==--
