From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 22/24] drm/radeon: Move GEM BO to drm_framebuffer
Date: Thu, 17 May 2018 17:06:12 +0200
Message-ID: <20180517150612.GO26515@ulmo>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
 <20180330141138.28987-1-daniels@collabora.com>
 <20180330141138.28987-22-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1574227925=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180330141138.28987-22-daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
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
To: Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian =?utf-8?B?S8O2bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org


--===============1574227925==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:11:36PM +0100, Daniel Stone wrote:
> Since drm_framebuffer can now store GEM objects directly, place them
> there rather than in our own subclass. As this makes the framebuffer
> create_handle and destroy functions the same as the GEM framebuffer
> helper, we can reuse those.
>=20
> Signed-off-by: Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: David (ChunMing) Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> ---
>  drivers/gpu/drm/radeon/atombios_crtc.c      | 10 +++++-----
>  drivers/gpu/drm/radeon/radeon_device.c      |  4 ++--
>  drivers/gpu/drm/radeon/radeon_display.c     | 31 +++++++----------------=
------
>  drivers/gpu/drm/radeon/radeon_fb.c          |  8 ++++----
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c | 11 ++++------
>  drivers/gpu/drm/radeon/radeon_mode.h        |  1 -
>  6 files changed, 22 insertions(+), 43 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr9mmMACgkQ3SOs138+
s6H8DA//fSe5OT/BbrFF0WPv+GvQq2gG4bk5fljl+yACqThokaNb0nPjPLtQj0zJ
6kH6m0OXondz8o8Uj8sXEFxOY3wySMtglTKK27Xfl99NjMtCJ1cUSeKsHXcipAAL
wvYJzDMe/okeynWYxCAP1izaGr9NVQov/ZFhBUFPcrmQie5zrvqh9oc1hL0rhK1o
4nqk9O1MbN0n4RES3aOhJzT8OgBjlVEzGYFa3ca0qvlKP4w99dgjRxUHdqraiEwo
uBgzM2IZ5IKzrSSU1zFw1FJAWbWnQTLteriYuI6i0CcpltgV84FeDatjUShe1phA
5rmJEJl+OjatA6bNiIWHKonlj3CW0sjw4yTLmmbnPQ4zSpZu7/GoNNMCpgKDF60S
5JlfrrDgwKRbLF5nWA8L9eZL6P+E1qFM9BTZX/qdVxHPALHpiNe64r4IvcpDQBZb
RWDEHzBrZgukkVCtl+NdmqD+I8QZCPXTiqeoeqgSqbsLEco3FuwTekpuJJ0ngf4N
18VZl4jpHnsPHBNBSBmJbik4KiCIqMsOB3HV6CdMoyMZw/osckiDJrB5dCFB5x9B
FVRxgZo/SIbbXIx05DJPelBzxa0VTwe9Tn0jO5G1I0rlh0d71VfOWnEFIHgaCTZN
Qhtd2Q13oOyzP0GMjh5qnBbP9JoZZ5+X14HUceetvuyVVN4mrgY=
=ZJMO
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--

--===============1574227925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1574227925==--
