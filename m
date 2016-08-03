From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: update golden setting of VI
Date: Wed, 3 Aug 2016 22:06:49 +1000
Message-ID: <57d13336-f5ae-99f5-5b2d-0c65b8acacd1@folklore1984.net>
References: <1470115414-23733-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1219338199=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470115414-23733-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1219338199==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Oh78kWInC4KGFuQd4BXwDh3d9AL8M1or8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oh78kWInC4KGFuQd4BXwDh3d9AL8M1or8
Content-Type: multipart/mixed; boundary="OXocD9ERT3AGtvV6QXQD1ct7XrM0NgET4"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>
Message-ID: <57d13336-f5ae-99f5-5b2d-0c65b8acacd1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: update golden setting of VI
References: <1470115414-23733-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470115414-23733-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--OXocD9ERT3AGtvV6QXQD1ct7XrM0NgET4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I think it would be helpful for at least one liner explaining actually
what is even getting "fixed" here? Obviously we assume, given that you
work for AMD, these magics are correct however it does help in case of
issue.

Just for a motivating example, suppose a magic is technically correct as
per hw documentation but there is a bug in the ASIC itself that this
changed caused a regression with then we would know where/how it occurs.

Kind Regards,
Edward.

On 08/02/2016 03:23 PM, Huang Rui wrote:
> Hi all,
>=20
> This patch set are all changes of golden setting, mgcg_cgcg setting,
> tiling mode array and rev id of VI series of cards.
>=20
> Changes from V1 -> V2:
> - Polaris10 changes are in tonga and polaris11 patches. And fix it.
>=20
> Thanks,
> Rui
>=20
> Huang Rui (3):
>   drm/amdgpu: update golden setting of tonga
>   drm/amdgpu: update golden setting of polaris11
>   drm/amdgpu: update golden setting of polaris10
>=20
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20


--OXocD9ERT3AGtvV6QXQD1ct7XrM0NgET4--

--Oh78kWInC4KGFuQd4BXwDh3d9AL8M1or8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXod5ZAAoJEP4bvbfZuWjbdfcQAIZBJkmYvCQDAaPbL6U5N8cU
ly/gyH/AasI4v58EDbqenvKPGZd+ExsukPI7vpJS7Br2AF722aWPXNg9jlmjRqp8
ZtaF23p6E9qsK9oEq0rcRVlwRLOOxDiCblrDSW0OUDPTgArzewmfPSRbU6jLTqNU
YxEw4Vn8oGXpUwuJabVt1sk9COgttZY03YPAsLVzgxbT/SFtCSh+Z2/uyCbXO5hK
EBKNS+vDnZWjPaAeoeB7r/CzHikXmycpUOfeO0d1mwqtsgHIWaxteykblP3IKXDE
xlzw+5m+hRaxTBZNJaZpnvE9tCsCNGh6AJCJDiU91/ryWnk0uJEnUBOISVHl0NvU
/8N+G3d6A+PUSDAhgmkeuPdl7T6cbsCUCqYEvdhJUc9nv0Xifa6PRybwXyeJvNKW
dRF5Pq4X5fRm8ID+9yX22TlenLRYtb6lmTXjmMn+9BgUYWp5lFuFPGm7St6j0b8P
cXpN8CVzL6aNSjJ1zqPiPw70Nz5I2FCS8QQYJ9gZtHVawckhzjOGgwpo0g9oqLLt
Ix1Aj1QZB/MkZZN5TG5Yvf0vPKXo0uXwfDHFglfrQJPEVWAnWucEDoz2uOYgmzbf
1VX+DdOBsZxnrRn2yLK3/bzl7I68Gpury15XKHQAVtpIQeGd2SCYqu3WOvAu7OUp
J2g4sx2kEWVego0mNyx1
=42ae
-----END PGP SIGNATURE-----

--Oh78kWInC4KGFuQd4BXwDh3d9AL8M1or8--

--===============1219338199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1219338199==--
