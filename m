From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/6] drm/amd/powerplay: refine pr_* prints for powerplay
Date: Mon, 26 Dec 2016 19:02:59 +1100
Message-ID: <58324c05-4960-00b9-020c-88c64179eafb@folklore1984.net>
References: <1482738991-25373-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0741878827=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482738991-25373-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0741878827==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OJVDRFkePs2imqslhosDwqgeoUBgXs6Kw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OJVDRFkePs2imqslhosDwqgeoUBgXs6Kw
Content-Type: multipart/mixed; boundary="qP8vIUhFxfeuhbD0jARqlaB5m8KvbtnGC";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <58324c05-4960-00b9-020c-88c64179eafb-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/6] drm/amd/powerplay: refine pr_* prints for
 powerplay
References: <1482738991-25373-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1482738991-25373-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--qP8vIUhFxfeuhbD0jARqlaB5m8KvbtnGC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Merry Christmas Huang Rui,

This set looks way better and a much more complete solution, good job
working though it all!

Patches 1-6 are,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Kindest Regards,
Edward.

On 12/26/2016 06:56 PM, Huang Rui wrote:
> From: Huang Rui <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
>=20
> Hi all,
>=20
> Merry Christmas! No one generate patches at this time except us :-).
>=20
> The following patch set doesn't have any function change, just refine
> prints of powerplay. Powerplay will used pr_* instead of raw printk,
> and we can dynamic change the debug level with it.
>=20
> The prefix is like below:
>=20
> [  xxx.xxxxxx] amdgpu: [powerplay] ...
>=20
> Best Wishes,
> Rui
>=20
> Huang Rui (6):
>   drm/amd/powerplay: add prefix for all powerplay pr_* prints
>   drm/amd/powerplay: reshuffle headers to make pr_fmt macro before
>     <linux/xxx.h>
>   drm/amd/powerplay: refine print message for amd_powerplay
>   drm/amd/powerplay: update all printk to pr_* on eventmgr
>   drm/amd/powerplay: update all printk to pr_* on hwmgr
>   drm/amd/powerplay: update all printk to pr_* on smumgr
>=20
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 50 +++++++++++---=
--------
>  drivers/gpu/drm/amd/powerplay/eventmgr/eventinit.c |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 29 ++++++-------
>  .../gpu/drm/amd/powerplay/hwmgr/functiontables.c   | 14 +++---
>  .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 11 ++---
>  drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c   |  8 ++--
>  .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |  6 +--
>  .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |  2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 28 ++++++------
>  .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |  4 +-
>  drivers/gpu/drm/amd/powerplay/inc/pp_debug.h       | 10 ++++-
>  drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c   | 28 ++++++------
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smc.c    |  6 +--
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 10 ++---
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smc.c | 10 ++---
>  .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |  4 +-
>  .../gpu/drm/amd/powerplay/smumgr/polaris10_smc.c   |  6 +--
>  .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    | 10 ++---
>  drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 14 +++---
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smc.c   | 16 +++----
>  .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |  4 +-
>  22 files changed, 140 insertions(+), 134 deletions(-)
>=20


--qP8vIUhFxfeuhbD0jARqlaB5m8KvbtnGC--

--OJVDRFkePs2imqslhosDwqgeoUBgXs6Kw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYYM63AAoJEP4bvbfZuWjbKtQQANqZccHf+ogcElfVfV7FHIfj
DmHvDtOdUIxesuHXOAGeymv6vG2tiGgDyyuuu3v38rWYQT6+IYLnDJfgYgckDwua
/C1C2cd1VTESuMw8WixZarI+JXz0hM610RKx7ZGQb+AulGPJVr6iVhc1hBfoN0JY
RnWbHUsT8f4EesBtStkNb58YXm2k/dmYOjCv7Rg/Pr/U+K0gKtIzwT6ZSEhC0xFd
6dlPAVSdsGo9LanpIGifzarCArcOm/Yf4lU8b3UJyFInob8EK6WSKyMJy14hNj/d
NEhRMkPGMwP4QW8VrLd3jrjrRaOjJdQRr2mgSb5XPUrTCCaU9PpL8XnU5FbJjP8J
NIK3zI29V1I1D7azcQFyv561z7emb6zlSNLrmROiMG2rNGkWe2FlL6veuUMQEm++
oREXGdLdQkboBvI7h0lUW8HhyK6wdeKvEYQmh2KBaCtDpPb4DOOEJvaegFNoyqXk
mV0HvvJkiVxkIIEEc8BEr4AQdnUaLQAq5UK7dujwnov3Q3mikdR8OHiA4GXXmlXp
DbF0LDQysn/f35aNNQsKsQ7EnocwxbRrP+PG5lUj8zFX0zGT6wlRmnfgw7sWW6CW
0lKz5h7d1j6aV0I0G2WMHAA0IwR1Luw1GulZaNWRNhWZhn8lXfoI1npUVyIG+LuI
5zHhjBelUYky2p95CjGd
=Z2k4
-----END PGP SIGNATURE-----

--OJVDRFkePs2imqslhosDwqgeoUBgXs6Kw--

--===============0741878827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0741878827==--
