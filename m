From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: cleanup VM shadow BO unreferencing
Date: Fri, 16 Sep 2016 22:43:02 +1000
Message-ID: <b6ff8554-78f3-d5ce-edbd-3c332d10a3b1@folklore1984.net>
References: <1474027940-2333-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0636202281=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474027940-2333-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0636202281==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="21HwFLeGrQC7jmUxpG0shKkcnumX8v6CG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--21HwFLeGrQC7jmUxpG0shKkcnumX8v6CG
Content-Type: multipart/mixed; boundary="ASkL5WBL96145xucDj9VT80DCt1SqIeFl";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <b6ff8554-78f3-d5ce-edbd-3c332d10a3b1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: cleanup VM shadow BO unreferencing
References: <1474027940-2333-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1474027940-2333-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--ASkL5WBL96145xucDj9VT80DCt1SqIeFl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Series is,
Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/16/2016 10:12 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Unreference the shadow BOs in the error path as well and drop the NULL =
checks.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index 8928a2a..19c7bf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1429,6 +1429,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
> =20
>  		r =3D amdgpu_vm_clear_bo(adev, vm, pt);
>  		if (r) {
> +			amdgpu_bo_unref(&pt->shadow);
>  			amdgpu_bo_unref(&pt);
>  			goto error_free;
>  		}
> @@ -1635,6 +1636,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
>  	return 0;
> =20
>  error_free_page_directory:
> +	amdgpu_bo_unref(&vm->page_directory->shadow);
>  	amdgpu_bo_unref(&vm->page_directory);
>  	vm->page_directory =3D NULL;
> =20
> @@ -1677,15 +1679,17 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm)
>  	}
> =20
>  	for (i =3D 0; i < amdgpu_vm_num_pdes(adev); i++) {
> -		if (vm->page_tables[i].entry.robj &&
> -		    vm->page_tables[i].entry.robj->shadow)
> -			amdgpu_bo_unref(&vm->page_tables[i].entry.robj->shadow);
> -		amdgpu_bo_unref(&vm->page_tables[i].entry.robj);
> +		struct amdgpu_bo *pt =3D vm->page_tables[i].entry.robj;
> +
> +		if (!pt)
> +			continue;
> +
> +		amdgpu_bo_unref(&pt->shadow);
> +		amdgpu_bo_unref(&pt);
>  	}
>  	drm_free_large(vm->page_tables);
> =20
> -	if (vm->page_directory->shadow)
> -		amdgpu_bo_unref(&vm->page_directory->shadow);
> +	amdgpu_bo_unref(&vm->page_directory->shadow);
>  	amdgpu_bo_unref(&vm->page_directory);
>  	fence_put(vm->page_directory_fence);
>  }
>=20


--ASkL5WBL96145xucDj9VT80DCt1SqIeFl--

--21HwFLeGrQC7jmUxpG0shKkcnumX8v6CG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX2+jbAAoJEP4bvbfZuWjbkJkP/1JW8+LRAGtMzvRcWZUJ9eh2
Cg/4R75UDDwjmihwbeNNILosM6hKEDY26xXZBCoJO5duOb942Gv6217GkLWEX3iP
fRBYyPcHXdKgpfpJ0L0tG06NVQOABIti/Wsl/t8ap3eZw0c9k6UU3YLlopffqjWe
09r6+h6efCN09mLZWv+UPN2wzidBe3tes4lMcF/gdahp5akj55nMVB1i0hjrgObP
eBwGg/JxjXiBu9HrkULyWoc+AlfFBmWu/YW8h4+/un+kU5yqu06jU9DXqMKpzu4X
WBjdSD93TZHLr07IIvYhMrYc44Xy1Yfm9HWSe2kozCL7jQyLNymInjqm36wgFXJr
uArsBxEq4YOAAUPYb1PgldCpgcJzHUXGgXXN7yo8yJaaXW2c7CMemMnCgdbcXjAC
Esefr5IIJWIZv8houY51mAaW1RRygwuaKAsc5wGsqZOuIDRL7oBAxxNC49Lgd5cV
IjvTWtyYeZEAzIS+mAeQXTboLR3Vza92N0gYp57eTPkfCNbB5wKK2mMk+krBn7Gw
4r+h/xRNzHMtHLEREjiJniKctj7pXwBMDfr6y91FQXz3porEW+FsxFu3fxZwDdcf
twKoxnNSn1kv4k6EijwySBgsVYOxI1Q0PD84s06eLU8OEiw09jY/mCkEDNa0KuUS
v3LduqvdJnj3BK34+meP
=7uiK
-----END PGP SIGNATURE-----

--21HwFLeGrQC7jmUxpG0shKkcnumX8v6CG--

--===============0636202281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0636202281==--
