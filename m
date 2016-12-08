From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: use pr_debug to print function not
 implemented message
Date: Thu, 8 Dec 2016 11:36:57 +1100
Message-ID: <e7d99fd0-09c8-06d5-46db-24352f19bdd4@folklore1984.net>
References: <1481138889-10312-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1838913244=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481138889-10312-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1838913244==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cjg6tDhjbinwkT9ek6WM7jfakxGGRUmOu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cjg6tDhjbinwkT9ek6WM7jfakxGGRUmOu
Content-Type: multipart/mixed; boundary="NVdJHu9eQQRu0hINdpWbuJtwDjHB7XKxf";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <e7d99fd0-09c8-06d5-46db-24352f19bdd4-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: use pr_debug to print function not
 implemented message
References: <1481138889-10312-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1481138889-10312-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--NVdJHu9eQQRu0hINdpWbuJtwDjHB7XKxf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 12/08/2016 06:28 AM, Alex Deucher wrote:
> From: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>=20
> For CZ, some function pointers like display_configuration_changed
> are not set. So when HW manager tries to configure display, we
> end up with messages like
>=20
> "[ powerplay ] this function not implement!"
>=20
> in the logs. This message is informational, but lacks details
> on which function is not implemented and why.
>=20
> Rather than using KERN_INFO to print the message everytime the
> system boots, we rather use pr_debug so that it is only printed
> when debug prints are enabled at runtime.
>=20
> Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/functiontables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/functiontables.c b/dri=
vers/gpu/drm/amd/powerplay/hwmgr/functiontables.c
> index a6abe81..71822ae 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/functiontables.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/functiontables.c
> @@ -35,7 +35,7 @@ static int phm_run_table(struct pp_hwmgr *hwmgr,
>  	phm_table_function *function;
> =20
>  	if (rt_table->function_list =3D=3D NULL) {
> -		printk(KERN_INFO "[ powerplay ] this function not implement!\n");
> +		pr_debug("[ powerplay ] this function not implement!\n");
>  		return 0;
>  	}
> =20
>=20


--NVdJHu9eQQRu0hINdpWbuJtwDjHB7XKxf--

--Cjg6tDhjbinwkT9ek6WM7jfakxGGRUmOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSKspAAoJEP4bvbfZuWjbY+8QAL32lNmjAhek7ID3uvRisNT1
xaSEEJfIQGcgcl3a7qmIyaDSBFRjp2xxZtUcc/Jj2Of3jLmyIdNBSGT8oDxzIRy2
C/Kfbla4glb0TBnbxEG8DRXNHeUVt+fIo24e1VCKI1reFaTmZHxF3q3ier7szYf0
c4z4vs1Ol6VZq3QdawYygFmnixYEc9HAgKNBQKDI+QiFGniDRJRBIqO2GI5G+sUu
Ftky8jhYA13dnBVqwaOMSZyngZ6YAFXWPKFR0vxAASYScRzaF9IwsubOSkaT6fgG
7PNGsBnZASOtfnr4Hap3AvZ/tzlGgP8/avhQFGdxpnz0IDneUxuFGgMyIACm+XZ3
8V53+dh+GAQNk7LtYRu7n25H5JcFQpruMQ3YSV0dWemxgGlkWAaqWibCtLriWkzA
Pb+lDaBlKgCeFjE37837ZAnRFSEbiB8+OKUm/+dMiujGnNxM2JMWvu1Phoqql3lD
zs1d0PoTKuhnH6VDtKZK4PPxuJiaOMwPAYLNyvntI4i/Nidmt8MoaP0jgy94SKsR
CRPdeUj+JV4fMDD07cdqJ4Z/PRFtUuLnNKn2WBSiTH8fXD7mvYwzc+vQisLs/L+X
NYB6fNab1knLLLdcm1pNb8Khg70nCnuLtC3UErEqdGFru6l1i1E7bXco2Au1L31S
P0lJb/enBac1h36afn3z
=3/0n
-----END PGP SIGNATURE-----

--Cjg6tDhjbinwkT9ek6WM7jfakxGGRUmOu--

--===============1838913244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1838913244==--
