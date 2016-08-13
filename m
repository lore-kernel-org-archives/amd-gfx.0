From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: write PTEs directly into the IB.
Date: Sat, 13 Aug 2016 14:12:06 +1000
Message-ID: <a4ba18ca-ca7e-a4f6-1406-f4a419b4378e@folklore1984.net>
References: <1471009949-2050-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1752372841=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471009949-2050-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1752372841==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6Gxoa8eHxdSMbwk8to4IXE1lvAHrJqFNi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Gxoa8eHxdSMbwk8to4IXE1lvAHrJqFNi
Content-Type: multipart/mixed; boundary="mmfETmNhwwDUmnR4EJ91jnJf173ts5r4a"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org
Message-ID: <a4ba18ca-ca7e-a4f6-1406-f4a419b4378e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu: write PTEs directly into the IB.
References: <1471009949-2050-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1471009949-2050-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--mmfETmNhwwDUmnR4EJ91jnJf173ts5r4a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

actually quite a nice cleanup!

On 08/12/2016 11:52 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Write the PTEs at the end of the IB instead of directly into the SDMA c=
ommands.
> This can save quite some CPU cycles building the entries.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 26 +++++++++++++++++++++-----=

>  1 file changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index 2843132..7efcbe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -910,15 +910,15 @@ static int amdgpu_vm_bo_update_mapping(struct amd=
gpu_device *adev,
>  	/* padding, etc. */
>  	ndw =3D 64;
> =20
> -	if (params.src) {
> +	if (src) {
>  		/* only copy commands needed */
>  		ndw +=3D ncmds * 7;
> =20
> -	} else if (params.pages_addr) {
> -		/* header for write data commands */
> -		ndw +=3D ncmds * 4;
> +	} else if (pages_addr) {
> +		/* copy commands needed */
> +		ndw +=3D ncmds * 7;
> =20
> -		/* body of write data command */
> +		/* and also PTEs */
>  		ndw +=3D nptes * 2;
> =20
>  	} else {
> @@ -935,6 +935,22 @@ static int amdgpu_vm_bo_update_mapping(struct amdg=
pu_device *adev,
> =20
>  	params.ib =3D &job->ibs[0];
> =20
> +	if (!src && pages_addr) {
> +		uint64_t *pte;
> +		unsigned i;
> +
> +		/* Put the PTEs at the end of the IB. */
> +		i =3D ndw - nptes * 2;
> +		pte=3D (uint64_t *)&(job->ibs->ptr[i]);
> +		params.src =3D job->ibs->gpu_addr + i * 4;
> +
> +		for (i =3D 0; i < nptes; ++i) {
> +			pte[i] =3D amdgpu_vm_map_gart(pages_addr, addr + i *
> +						    AMDGPU_GPU_PAGE_SIZE);
> +			pte[i] |=3D flags;
> +		}
> +	}
> +
>  	r =3D amdgpu_sync_fence(adev, &job->sync, exclusive);
>  	if (r)
>  		goto error_free;
>=20


--mmfETmNhwwDUmnR4EJ91jnJf173ts5r4a--

--6Gxoa8eHxdSMbwk8to4IXE1lvAHrJqFNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXrp4WAAoJEP4bvbfZuWjbEw0P/3ojNN7icqxWxKW9fJfnz7B7
ibRq/UQaEvVIK5pXgapV33XXBVrAsNFHsrXj6X0nrPcMscwb3NO7iLA6kpFyTOZ2
SuUoce13CSquHsgWlymAvAt2T2y+EDtSyAfELcFo1NDzVP734CB+jJ4TSg/gvdqQ
syl5qxsKyeEMpEbM3oVPObhiHIFXDLjkCFnVajSqNX+givVscrX3i/RmIZIGcc3r
kWyKIOFrfrQFTWWzMJSgQnCECAxrDDz2omwPoLsCZlVG0ZyYFFsBKqczLHdu19HR
kfrBj4T3RV/B7StqaaDzcGVrDunoS0FkocC8bGg5wP43SjzDlRu9K7daKf++tXLs
e4PckmYu3a4/jGsJn5nykGQ++dc30RDZlvMjyCTJOhZqs+m61o2slR8jF5T2Zl/Y
cJIdjjEkLcuPW5RrMs7tGhfmnjkRmk11rVVEko8ZZLj9HuluC84A7FKDa+d5VbFr
Sn2iwL5rZRnlZXAM8E17bBqnZfUa7tNiBZ3ANNw23U8nWjbkTb9Wqp+0CEV9eCoV
tuk1lLvNWNwdjLPb/CrwZZ1ECgocjeGdSFec78w+HgC4aFmmM9xajVFg9L2zVXAB
ToQYjMar8OJchpQnrzonUkJqlh6cO1es9tjwPM6//n0tzgvOCjvuPTR26LHcy4PM
AzSGl9G5I7C1IZP6kJpy
=WhKt
-----END PGP SIGNATURE-----

--6Gxoa8eHxdSMbwk8to4IXE1lvAHrJqFNi--

--===============1752372841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1752372841==--
