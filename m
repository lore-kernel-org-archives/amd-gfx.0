From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/ci: add mullins to default case for smc ucode
Date: Sat, 30 Jul 2016 13:21:03 +1000
Message-ID: <088f7ffd-48cc-6b2e-b187-ad67371f0f76@folklore1984.net>
References: <1469830593-24613-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1640505747=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469830593-24613-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1640505747==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="57dkapKbJkmFPhVFA0p6Gvxv5Lbf7H1I7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--57dkapKbJkmFPhVFA0p6Gvxv5Lbf7H1I7
Content-Type: multipart/mixed; boundary="lXLLdjr47ix8KG03d0ou0MX6wGnn7ewWw"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <088f7ffd-48cc-6b2e-b187-ad67371f0f76-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/ci: add mullins to default case for smc ucode
References: <1469830593-24613-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469830593-24613-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--lXLLdjr47ix8KG03d0ou0MX6wGnn7ewWw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 07/30/2016 08:16 AM, Alex Deucher wrote:
> It's already covered by the default case, but add it for
> consistency.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/=
amdgpu/ci_dpm.c
> index 7bd6174..a0d63a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> @@ -5779,6 +5779,7 @@ static int ci_dpm_init_microcode(struct amdgpu_de=
vice *adev)
>  		break;
>  	case CHIP_KAVERI:
>  	case CHIP_KABINI:
> +	case CHIP_MULLINS:
>  	default: BUG();
>  	}
> =20
>=20


--lXLLdjr47ix8KG03d0ou0MX6wGnn7ewWw--

--57dkapKbJkmFPhVFA0p6Gvxv5Lbf7H1I7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnB0fAAoJEP4bvbfZuWjbJUEQAJDd4O/r9BbkOO+XQ7sdrCuU
CxRTjkRh2aerf260xsZSoUCoNzKyly9WAdXaueFfaR8bF0fCWiPzKuZ03CpszPPM
ubW+/IkLVqXIENLl1eeZNtfywlpCzbbNitlUYfd/AAlNptzhTrXBVooB2AwAqXsu
ZnN6XYIU+Iq4RXjVgU+B0oFLvAPS1yT5J3spsa7R90e45FoUXfs4S/MRxOOcuF4S
oO9XAxyMhgkhDPjXBNVJR1MdaMpy+8lemsOn9wk2gx6tVvMhnIpcM/IIntMqp7yM
ad007nQtutZ6ZQkx+pekT1RlR/JhUcuGE2X7ESTYvMDhpYHVGXJQp4ke10qmcU3u
ooKofNpA4d2JGhBH+IXbKeYPZlNRbZ71ivjzoM9vBzy2AsYtIHylMT9m+nO5Fo38
WC7IIalfw0eowdHVpy5VB5471MhKdUFCxxluVIVfQWpIf10b0TZUogVH97qlff6p
0PZr/WmwZ7Xx/6bI/zkAsstBIDpQ4TH/990zKXMBF5RtLGQZhsIHbXKrKfOZ6Dl5
srO9nds9mxOZ6aJIHLRPB1IvsfzRoA/SnYAN+RYrqZ8PkKv5bpBQJ1vlrXp0/nix
RjNosqZTPOMgCLQFY1+21VoHl/UP1sqFmiVozf943hSlUR/uSFUXrgbHduMvqmEt
kwsnXs/vxApxTeA3L4ht
=/DMa
-----END PGP SIGNATURE-----

--57dkapKbJkmFPhVFA0p6Gvxv5Lbf7H1I7--

--===============1640505747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1640505747==--
