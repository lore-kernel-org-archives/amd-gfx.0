From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 06/18] drm: use ARRAY_SIZE
Date: Mon, 2 Oct 2017 10:27:03 +0200
Message-ID: <20171002082703.GA24250@ulmo>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <20171001193101.8898-7-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0347847038=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171001193101.8898-7-jeremy.lefaure@lse.epita.fr>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Lefaure <jeremy.lefaure@lse.epita.fr>
Cc: amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Zhi Wang <zhi.a.wang@intel.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org


--===============0347847038==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2017 at 03:30:44PM -0400, J=C3=A9r=C3=A9my Lefaure wrote:
> Using the ARRAY_SIZE macro improves the readability of the code. Also,
> it is not always useful to use a variable to store this constant
> calculated at compile time nor to re-invent the ARRAY_SIZE macro.
>=20
> Found with Coccinelle with the following semantic patch:
> @r depends on (org || report)@
> type T;
> T[] E;
> position p;
> @@
> (
>  (sizeof(E)@p /sizeof(*E))
> |
>  (sizeof(E)@p /sizeof(E[...]))
> |
>  (sizeof(E)@p /sizeof(T))
> )
>=20
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@lse.epita.fr>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           |  9 +++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |  9 +++++----
>  drivers/gpu/drm/gma500/psb_intel_sdvo.c         |  9 ++++-----
>  drivers/gpu/drm/i915/gvt/vgpu.c                 |  3 ++-
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c |  7 ++++---
>  drivers/gpu/drm/via/via_verifier.c              | 10 ++++------
>  6 files changed, 24 insertions(+), 23 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnR+FAACgkQ3SOs138+
s6FqlA/+Ie73Rwh5+pod1oJoeYslPHTaGbLeIMLwB2ScPKaR65zvVrdQGCCKxd0M
2Agwzz4IDNSZszbiM9LSUAf85kGJOyOfSM/J5pII1vYknuxqprtvCDHbXyuYJSKt
9cwkAHokumHeC2iS1De026SkEUasTQod5JzTug0DGTWsQUt2Cg+Z/eEcxr/EJpQQ
SsisGhNFGAz1hgQ/r2Q9U3c48tzE8ejgvwPI32nSK0Mt1wJGQfmhhAJCRhc9Sb2h
0HSYnRpSNIUB9qF9VI9hzU5cuquS6fPnq09DMxU0c45NefbfRLx/bjJuhrciLPDI
TaNmy2qpwmhs5iPTGNqHPLjRTlSkmFZ+nciJQJG+pqeQa/nz/KKPNAy3ocvRCurs
ZxeajR12fI5+oA+sBk0ugOo9lyURaaX2kY9Ur//98BaDlsb2f0BMfIoheY+aISuD
1gZLm1Igc8U9jjWbzIOklxFTh9iXJNriqGPy3STh62g2nYNIxmmcPENxneVMAuNg
YQ2fJz8WYI6cqpyz44RI/uylwOMOF3qeLg9+we+YNnCrKhaUyy7WMMrXMPs+wm+T
KPBMb3hnrVOeANHFTWBMIfbgZX9cduCq17NLcf4kYXGVirUgwLYZCot8uufCxFJK
+kE3hQisTg4lbFZaBOCeAlICymlsRjQ1x5k+2gDFlcoiKAMPX4A=
=k6eh
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--===============0347847038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0347847038==--
