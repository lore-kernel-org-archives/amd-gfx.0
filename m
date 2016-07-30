From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 04/11] drm/amdgpu: fix vm init error path
Date: Sat, 30 Jul 2016 13:41:28 +1000
Message-ID: <7115f9e7-3afd-a693-3e23-1ad4acb3c700@folklore1984.net>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
 <1469700828-25650-5-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1817561848=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469700828-25650-5-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1817561848==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tN4bhQ7T7M7pWdssAGpSV05UNDGpOv3iH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tN4bhQ7T7M7pWdssAGpSV05UNDGpOv3iH
Content-Type: multipart/mixed; boundary="k2JchvrN5iAJ1fnbdhF1eVJqfSreeKkre"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <7115f9e7-3afd-a693-3e23-1ad4acb3c700-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 04/11] drm/amdgpu: fix vm init error path
References: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1469700828-25650-5-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469700828-25650-5-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--k2JchvrN5iAJ1fnbdhF1eVJqfSreeKkre
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/28/2016 08:13 PM, Chunming Zhou wrote:
> Change-Id: Ie3d5440dc0d2d3a61d8e785ab08b8b91eda223db
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index 11c1263..1d58577 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1682,7 +1682,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
>  	r =3D amd_sched_entity_init(&ring->sched, &vm->entity,
>  				  rq, amdgpu_sched_jobs);
>  	if (r)

Hmm while we are here I think we should be explicit that non-zero,
negative return values indicate an error path, so:

-  	if (r)
+  	if (r < 0)

This then follows precisely the semantics documented for
'amdgpu_vm_init()' invocations.

Kind Regards,
Edward.

> -		return r;
> +		goto err;
> =20
>  	vm->page_directory_fence =3D NULL;
> =20
> @@ -1725,6 +1725,9 @@ error_free_page_directory:
>  error_free_sched_entity:
>  	amd_sched_entity_fini(&ring->sched, &vm->entity);
> =20
> +err:
> +	drm_free_large(vm->page_tables);
> +
>  	return r;
>  }
> =20
>=20


--k2JchvrN5iAJ1fnbdhF1eVJqfSreeKkre--

--tN4bhQ7T7M7pWdssAGpSV05UNDGpOv3iH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnCHoAAoJEP4bvbfZuWjbkj4P/Rg2QIqfOHMAC1kl8qEkuWIk
jq6BpCCPCcrn+vrtOCeQTu9CwQabYiytPZ5N5EC7Ew/KYyPI0eAkDBOMV9gvVQgK
Bp+lJX2d7uR/HthGo6oLLvwUJvXc16NntUXGKDX0wsinMa5m0fwP1bZbJ2Q6Axvm
Hh8zitL5fFQsMXhMX1zYK9EGEu5cCFemDzkQ4NN04EBpsymNsGczfv9aqRoIrmYg
aJ9xgmUPR4b9gPUWCPiuuS2F07Fwgbwacx0hLV2AlK+9Gp2gwW6iaodjCfR2vOb/
5zpcOkNIoO5FePJdXnDxDwgNczWgdyGCcn5gmzC7wGwbv2hY0HFMrtfepIHUMbtH
tJzjp+mMoJaUWv6jeQwhhKtVzZwSU942Vtk/vUstBT1NfKGF09rBzVTlr9LBZVQM
cyCMVBjBnRybVGLRF9lNh1jvXqczw3F4rzjk/nb+7Xn9AnCp2D+sdAc89SeDTRRd
U+ZA3gtqTBeXoqpIbVy4xevDwifW2I1uIX36yoQaWtc7PiYTiEK/iLQVVTK2CyFT
opgrLrRNu1z6zAdP7iNeCTR2n4fa9dneEZXo4mNXO0kqElFhGxK2dxiv+2LUSsqQ
Uvk+GPN2GlGWSlkZJRUA+TRRVD+6IXdJ1rRXzibcIpLyOK1G4GBUJf4T0tabzuBM
2hkLP/m6fbNb+L4MRY3j
=0xWQ
-----END PGP SIGNATURE-----

--tN4bhQ7T7M7pWdssAGpSV05UNDGpOv3iH--

--===============1817561848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1817561848==--
