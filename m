From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 23/24] drm/radeon: radeon_framebuffer -> drm_framebuffer
Date: Thu, 17 May 2018 17:07:30 +0200
Message-ID: <20180517150730.GP26515@ulmo>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
 <20180330141138.28987-1-daniels@collabora.com>
 <20180330141138.28987-23-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0979215991=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180330141138.28987-23-daniels@collabora.com>
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


--===============0979215991==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Content-Disposition: inline


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:11:37PM +0100, Daniel Stone wrote:
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
>  drivers/gpu/drm/radeon/atombios_crtc.c      | 32 ++++++++---------------=
------
>  drivers/gpu/drm/radeon/radeon_device.c      |  6 +++---
>  drivers/gpu/drm/radeon/radeon_display.c     | 30 ++++++++++++-----------=
----
>  drivers/gpu/drm/radeon/radeon_fb.c          | 20 +++++++++---------
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c | 11 +++-------
>  drivers/gpu/drm/radeon/radeon_mode.h        |  7 +------
>  6 files changed, 39 insertions(+), 67 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr9mrEACgkQ3SOs138+
s6F5jRAAjHtizzV8Lz6SR1JLfJ6UZAqmeFYGqK4AuHRTddL4GBbfdKleIkpqQVVQ
4oOLftVpOiJYIqj98+J71JiL/VpY2i9jNC3k8MWUK2AHCbaRHCP555qf6Squzcng
b6CcBJ2LkpPVQearz9o3uJ8CF1q4tnHuDnB3sU7HjeddKbMcGlEHzbRYd48XSzpR
be95YhOtFD4FVMqPtlGhOh2Gv+lI8fGe5ypgE3e0kpPOJB7bmLaS4rcAbX3j8pDh
NKSBFnmXk7oUI/dJqsbotLPuYhgaL7Q9mWoxuURFHDscSxFgPPat2NFtoWDnePAG
/5fgqEML8qgI9JsQeW/Ci0/s+RL5BuQg5naYI0zUxleh4jhgYqmWsLsZtUcJMcLb
wFCsYymcJxkpM3n2YUjhN0FRWmlJ2Otuy55evvr0AohaXYOGHn1G98LsGOnuX7ww
+tahkosddfShkBXYCXReHk4uI6UrkzO69fvkl6JAaULV09rrW4G/omPkza52Tq1o
hLpdHy6gGmt3nIHfCSS59Fl4UdSBozUnRj1PwHVBcyon3EFl/bhl9tON2dYd9vmx
u5GuWXiiaO/8hpmK2ufBJZ+N0KJ4G0VJpITx9KYxYlptJ8wAPJO5kmAcvm0DADXa
ikC86F1vxcWI+F7TplsThvDZTs3JV897JwWqdRbp5jebJUwXw1A=
=XhYe
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--

--===============0979215991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0979215991==--
