From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/6] drm/amdgpu: add get clockgating functions for new asic
Date: Fri, 24 Mar 2017 23:57:31 +1100
Message-ID: <2a2b481e-9e78-9161-15bf-bb67f15426b6@folklore1984.net>
References: <1490334466-17596-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2062924450=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490334466-17596-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alvin Huan <alvin.huan-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2062924450==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X6mccTXteDHOC3MecDRNrRVhcwtpiKFds"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X6mccTXteDHOC3MecDRNrRVhcwtpiKFds
Content-Type: multipart/mixed; boundary="PvBL5v4GdQSEFTe4ukTg0Bes9Wsqq0TqG";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Alvin Huan <alvin.huan-5C7GfCeVMHo@public.gmane.org>
Message-ID: <2a2b481e-9e78-9161-15bf-bb67f15426b6-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/6] drm/amdgpu: add get clockgating functions for new
 asic
References: <1490334466-17596-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1490334466-17596-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--PvBL5v4GdQSEFTe4ukTg0Bes9Wsqq0TqG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/24/2017 04:47 PM, Huang Rui wrote:
> Hi all,
>=20
> This patch set adds get_clockgating functions, after that, we can use
> debugfs pm to check the dynamic clockgating status.
>=20
> Thanks,
> Rui
>=20
> Huang Rui (6):
>   drm/amdgpu: add get_clockgating callback for gfx v9
>   drm/amdgpu: add get_clockgating callback for nbio v6.1
>   drm/amdgpu: add get_clockgating callback for soc15
>   drm/amdgpu: add get_clockgating for sdma v4
>   drm/amdgpu: add get_clockgating callback for mmhub v1
>   drm/amdgpu: fix to remove HDP MGCG on soc15
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 43 +++++++++++++++++++++++++=
++++++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 17 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c  | 15 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v6_1.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c  | 17 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 35 +++++++++++++++++++++++++=
+-
>  7 files changed, 133 insertions(+), 1 deletion(-)
>=20


--PvBL5v4GdQSEFTe4ukTg0Bes9Wsqq0TqG--

--X6mccTXteDHOC3MecDRNrRVhcwtpiKFds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1Re7AAoJEP4bvbfZuWjbrrgP+wR6JMhle4jNyU96nMledvXY
NWX+4UxNaR9XHOxEbNGTV27MYGGexT79BQpMjAJxzjjTElfdrxkb7t+WVkLlXYCI
oLwX50MUKp0mv+2Ni96XONln7wRDUDPdmBW+00Tf3sgh0nN+DMY9u/5bRPRlGKc+
FlKcM6KkT06z2AFVtGrhPvkpvTrvDkIObvR7Bcun6Vwef7mse/V1J9xtc8tHu0Ww
BFXP2aZn1ZOko9LmzITdbb+f/tuL3Qw2tTOnWNUq+PGroJia1kNkO9P3Zxi7GHln
zjzJLdfyIgHe3XnynfnzuDKjcAvHUMtk60E6zpwL41/I/me4Lgrb/tmyjGjCj5Jp
DLORxOMeTf+pNf0y0x1cOl6wv/0k0EQN/XJtqcjcth4uOOdt7OgIox3nk8ahCKqE
It2PrKYbebULBQcbOlGWMNAT7TnSovRLrp2APMy9SNKsfGZqiMJrKNutkXNh76zT
SzP0XQ1UZ+TpgdvEFLVqAYQz/f7F50mIzLO4kKQnqjseRITqaO89wlnFU+3naMJa
g6Q3wRkhWPdrsnbyBI7rYHzDf4onn34QgBojSaaPvRjAKtAM4qc0br2Dz3F5UsDG
AecujdfL1Yz31Bzcx3HV4CLtVXNbkq+xEL+pN/dtgtJHEnUPlDJNxoxGF48IkKnu
ewkUgPRSFKuyJLwG1kKq
=XJhN
-----END PGP SIGNATURE-----

--X6mccTXteDHOC3MecDRNrRVhcwtpiKFds--

--===============2062924450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2062924450==--
