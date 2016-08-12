From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 08/18] drm/amdgpu: update pd shadow bo
Date: Fri, 12 Aug 2016 19:50:07 +1000
Message-ID: <2b268e2c-0448-993c-c9ae-83374f91aaca@folklore1984.net>
References: <1470983947-32579-1-git-send-email-David1.Zhou@amd.com>
 <1470983947-32579-9-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0965876364=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470983947-32579-9-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
--===============0965876364==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RbVHkIQoaemQH0vgxh6g9GFiSc2EUN7au"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RbVHkIQoaemQH0vgxh6g9GFiSc2EUN7au
Content-Type: multipart/mixed; boundary="DNGcTUTVGtlXV7UhJSSCqJLXnFKvE1lr7"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <2b268e2c-0448-993c-c9ae-83374f91aaca-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 08/18] drm/amdgpu: update pd shadow bo
References: <1470983947-32579-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1470983947-32579-9-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470983947-32579-9-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--DNGcTUTVGtlXV7UhJSSCqJLXnFKvE1lr7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/12/2016 04:38 PM, Chunming Zhou wrote:
> Change-Id: I8d0c625c9f1c9a16b8e2e915831590be5a9a5242
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 73 +++++++++++++++++++++++---=
--------
>  2 files changed, 50 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 7eb854a..73af7ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -884,6 +884,7 @@ struct amdgpu_ring {
>  struct amdgpu_vm_pt {
>  	struct amdgpu_bo_list_entry	entry;
>  	uint64_t			addr;
> +	uint64_t			shadow_addr;
>  };
> =20
>  struct amdgpu_vm {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index f1a1add..bd69cf83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -597,23 +597,13 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pag=
es_addr, uint64_t addr)
>  	return result;
>  }
> =20
> -/**
> - * amdgpu_vm_update_pdes - make sure that page directory is valid
> - *
> - * @adev: amdgpu_device pointer
> - * @vm: requested vm
> - * @start: start of GPU address range
> - * @end: end of GPU address range
> - *
> - * Allocates new page tables if necessary
> - * and updates the page directory.
> - * Returns 0 for success, error for failure.
> - */
> -int amdgpu_vm_update_page_directory(struct amdgpu_device *adev,
> -				    struct amdgpu_vm *vm)
> +int amdgpu_vm_update_page_directory_or_shadow(struct amdgpu_device *ad=
ev,
> +					      struct amdgpu_vm *vm,
> +					      bool shadow)
>  {
>  	struct amdgpu_ring *ring;
> -	struct amdgpu_bo *pd =3D vm->page_directory;
> +	struct amdgpu_bo *pd =3D shadow ? vm->page_directory->shadow :
> +		vm->page_directory;
>  	uint64_t pd_addr =3D amdgpu_bo_gpu_offset(pd);
>  	uint32_t incr =3D AMDGPU_VM_PTE_COUNT * 8;
>  	uint64_t last_pde =3D ~0, last_pt =3D ~0;
> @@ -647,10 +637,17 @@ int amdgpu_vm_update_page_directory(struct amdgpu=
_device *adev,
>  		if (bo =3D=3D NULL)
>  			continue;
> =20
> -		pt =3D amdgpu_bo_gpu_offset(bo);
Hmm, no need to remove this line as it is common to both branches.

> -		if (vm->page_tables[pt_idx].addr =3D=3D pt)
> -			continue;
> -		vm->page_tables[pt_idx].addr =3D pt;
> +		if (!shadow) {
> +			pt =3D amdgpu_bo_gpu_offset(bo);
ditto

> +			if (vm->page_tables[pt_idx].addr =3D=3D pt)
> +				continue;
> +			vm->page_tables[pt_idx].addr =3D pt;
> +		} else {
> +			pt =3D amdgpu_bo_gpu_offset(bo);
ditto

> +			if (vm->page_tables[pt_idx].shadow_addr =3D=3D pt)
> +				continue;
> +			vm->page_tables[pt_idx].shadow_addr =3D pt;
> +		}
> =20
>  		pde =3D pd_addr + pt_idx * 8;
>  		if (((last_pde + 8 * count) !=3D pde) ||
> @@ -678,17 +675,21 @@ int amdgpu_vm_update_page_directory(struct amdgpu=
_device *adev,
> =20
>  	if (vm_update_params.ib->length_dw !=3D 0) {
>  		amdgpu_ring_pad_ib(ring, vm_update_params.ib);
> -		amdgpu_sync_resv(adev, &job->sync, pd->tbo.resv,
> -				 AMDGPU_FENCE_OWNER_VM);
> +		if (!shadow)
> +			amdgpu_sync_resv(adev, &job->sync, pd->tbo.resv,
> +					 AMDGPU_FENCE_OWNER_VM);
>  		WARN_ON(vm_update_params.ib->length_dw > ndw);
> -		r =3D amdgpu_job_submit(job, ring, &vm->entity,
> +		r =3D amdgpu_job_submit(job, ring,
> +				      shadow ? &vm->shadow_entity : &vm->entity,
>  				      AMDGPU_FENCE_OWNER_VM, &fence);
>  		if (r)
>  			goto error_free;
> =20
>  		amdgpu_bo_fence(pd, fence, true);
> -		fence_put(vm->page_directory_fence);
> -		vm->page_directory_fence =3D fence_get(fence);
> +		if (!shadow) {
> +			fence_put(vm->page_directory_fence);
> +			vm->page_directory_fence =3D fence_get(fence);
> +		}
>  		fence_put(fence);
> =20
>  	} else {
> @@ -702,6 +703,29 @@ error_free:
>  	return r;
>  }
> =20
> +/**
> + * amdgpu_vm_update_pdes - make sure that page directory is valid
> + *
> + * @adev: amdgpu_device pointer
> + * @vm: requested vm
> + * @start: start of GPU address range
> + * @end: end of GPU address range
> + *
> + * Allocates new page tables if necessary
> + * and updates the page directory.
> + * Returns 0 for success, error for failure.
> + */
> +int amdgpu_vm_update_page_directory(struct amdgpu_device *adev,
> +				    struct amdgpu_vm *vm)
> +{
> +	int r;
> +
> +	r =3D amdgpu_vm_update_page_directory_or_shadow(adev, vm, true);
> +	if (r)
> +		return r;
> +	return amdgpu_vm_update_page_directory_or_shadow(adev, vm, false);
> +}
> +
>  int amdgpu_vm_recover_page_table_from_shadow(struct amdgpu_device *ade=
v,
>  					     struct amdgpu_vm *vm)
>  {
> @@ -1410,6 +1434,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>  		entry->tv.shared =3D true;
>  		entry->user_pages =3D NULL;
>  		vm->page_tables[pt_idx].addr =3D 0;
> +		vm->page_tables[pt_idx].shadow_addr =3D 0;
>  	}
> =20
>  	return 0;
>=20


--DNGcTUTVGtlXV7UhJSSCqJLXnFKvE1lr7--

--RbVHkIQoaemQH0vgxh6g9GFiSc2EUN7au
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXrZvPAAoJEP4bvbfZuWjbqzIQAKBTZkrRxi3ljHry3fdJ4PIC
F+zhr+3i2JaBL3vHDSkpEcWNb+U/4A7cXCQGv5tWPrUxt6y64DmF7YgMkg/yJktF
s9a8PogAoP2g0G5vU0Fb1Z5JgFErQtQeonvUkflNWgaFlH4u+IyhD3dLaU6E7gwN
gy3V+VPn1EBnp/Z/c70FysNqRdZcBsSo7oVyIcWAcCeWW2KN6VGufRHAZVpAmUE0
XjxYUUzDmMTcqYVB+AvcKPNT3yNraCZELY0fgc5uhlE2FpyZbUORiQfe2bAnbaaN
AkAu5Qtcqz59sqWvmWOzCel6azPEaa6HaF4f6ilLPTvSm0iuuTnW1gKdig9V2jql
Q/z7zvAb6YmzbXBgNKJxF7e8pvUaARRJ+NVeJw21sjISeX/BMVVQzhdoyjzMb6AO
L1/gkkUV5iVmUl6M0d+5WZYxWAMjQM6tpBmPsRTvtIwueYhYs5g0KaARnT5B91Ao
S/A2bq+8MFyw63R7gZR2C5oMn+QjpNj3ox6z4JSj+rRNTK1U+rqM8095KcnnZzWn
qJYMnKEMnDL32zsNq9DFtm+8zRLXZbuRd+uKP8t7dCjziPQNEtaZQJjThMshxl8H
lkfcUCb9VFJOEhZJdU+E2dDl94Q18uVAPsAUp1deGnRnQWF/QMg685Wqe7VclNBM
aAdGI580cLwFG4JVXD04
=443r
-----END PGP SIGNATURE-----

--RbVHkIQoaemQH0vgxh6g9GFiSc2EUN7au--

--===============0965876364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0965876364==--
