From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 05/11] drm/amdgpu: add vm recover entity
Date: Sat, 30 Jul 2016 13:51:57 +1000
Message-ID: <dfe0d2d4-5d6c-7dfb-6e43-1f12f1883dce@folklore1984.net>
References: <1469700828-25650-1-git-send-email-David1.Zhou@amd.com>
 <1469700828-25650-6-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0434168023=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469700828-25650-6-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
--===============0434168023==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5O9lHi5J2UB0ul4If6nWkm7KolKu1WXCc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5O9lHi5J2UB0ul4If6nWkm7KolKu1WXCc
Content-Type: multipart/mixed; boundary="ceCD6DTrXaiaqX45CSqCCM7dQvH3igBfW"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <dfe0d2d4-5d6c-7dfb-6e43-1f12f1883dce-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 05/11] drm/amdgpu: add vm recover entity
References: <1469700828-25650-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
 <1469700828-25650-6-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469700828-25650-6-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--ceCD6DTrXaiaqX45CSqCCM7dQvH3igBfW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/28/2016 08:13 PM, Chunming Zhou wrote:
> every vm uses itself recover entity to recovery page table from shadow.=

>=20
> Change-Id: I93e37666cb3fb511311c96ff172b6e9ebd337547
> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 21 ++++++++++++++-------
>  2 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 9f7fae0..98f631a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -911,7 +911,8 @@ struct amdgpu_vm {
> =20
>  	/* Scheduler entity for page table updates */
>  	struct amd_sched_entity	entity;
> -
> +	struct amd_sched_entity	recover_entity;
> +	struct amdgpu_ring      *ring;
>  	/* client id */
>  	u64                     client_id;
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index 1d58577..6d2a28a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -714,13 +714,13 @@ error_free:
>  }
> =20
>  static int amdgpu_vm_recover_bo_from_shadow(struct amdgpu_device *adev=
,
> +					    struct amdgpu_vm *vm,
>  					    struct amdgpu_bo *bo,
>  					    struct amdgpu_bo *bo_shadow,
>  					    struct reservation_object *resv,
>  					    struct fence **fence)
> =20
>  {
> -	struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
>  	int r;
>  	uint64_t vram_addr, gtt_addr;
> =20
> @@ -739,8 +739,8 @@ static int amdgpu_vm_recover_bo_from_shadow(struct =
amdgpu_device *adev,
>  	if (r)
>  		goto err3;
> =20
> -	r =3D amdgpu_copy_buffer(ring, &adev->mman.entity, gtt_addr, vram_add=
r,
> -			       amdgpu_bo_size(bo), resv, fence);
> +	r =3D amdgpu_copy_buffer(vm->ring, &vm->recover_entity, gtt_addr,
> +			       vram_addr, amdgpu_bo_size(bo), resv, fence);
>  	if (!r)
>  		amdgpu_bo_fence(bo, *fence, true);
> =20
> @@ -767,7 +767,7 @@ int amdgpu_vm_recover_page_table_from_shadow(struct=
 amdgpu_device *adev,
>  	if (unlikely(r !=3D 0))
>  		return r;
> =20
> -	r =3D amdgpu_vm_recover_bo_from_shadow(adev, vm->page_directory,
> +	r =3D amdgpu_vm_recover_bo_from_shadow(adev, vm, vm->page_directory,
>  					     vm->page_directory->shadow,
>  					     NULL, &fence);

This is slightly out of scope from your patchsets intention however:

If we are passing 'vm' in now to 'amdgpu_vm_recover_bo_from_shadow()'
could we then perhaps do the dereferences to 'vm->page_directory' and
'vm->page_directory->shadow' in there?

>  	if (r) {
> @@ -784,7 +784,7 @@ int amdgpu_vm_recover_page_table_from_shadow(struct=
 amdgpu_device *adev,
> =20
>  		if (!bo || !bo_shadow)
>  			continue;
> -		r =3D amdgpu_vm_recover_bo_from_shadow(adev, bo, bo_shadow,
> +		r =3D amdgpu_vm_recover_bo_from_shadow(adev, vm, bo, bo_shadow,
>  						     NULL, &fence);
>  		if (r) {
>  			DRM_ERROR("recover page table failed!\n");
> @@ -1678,12 +1678,17 @@ int amdgpu_vm_init(struct amdgpu_device *adev, =
struct amdgpu_vm *vm)
>  	ring_instance =3D atomic_inc_return(&adev->vm_manager.vm_pte_next_rin=
g);
>  	ring_instance %=3D adev->vm_manager.vm_pte_num_rings;
>  	ring =3D adev->vm_manager.vm_pte_rings[ring_instance];
> +	rq =3D &ring->sched.sched_rq[AMD_SCHED_PRIORITY_RECOVER];
> +	r =3D amd_sched_entity_init(&ring->sched, &vm->recover_entity,
> +				  rq, amdgpu_sched_jobs);
> +	if (r)
> +		goto err;
>  	rq =3D &ring->sched.sched_rq[AMD_SCHED_PRIORITY_KERNEL];
>  	r =3D amd_sched_entity_init(&ring->sched, &vm->entity,
>  				  rq, amdgpu_sched_jobs);
>  	if (r)
> -		goto err;
> -
> +		goto err1;
> +	vm->ring =3D ring;
>  	vm->page_directory_fence =3D NULL;
> =20
>  	r =3D amdgpu_bo_create(adev, pd_size, align, true,
> @@ -1725,6 +1730,8 @@ error_free_page_directory:
>  error_free_sched_entity:
>  	amd_sched_entity_fini(&ring->sched, &vm->entity);
> =20
> +err1:
> +	amd_sched_entity_fini(&ring->sched, &vm->recover_entity);
>  err:
>  	drm_free_large(vm->page_tables);
> =20
>=20


--ceCD6DTrXaiaqX45CSqCCM7dQvH3igBfW--

--5O9lHi5J2UB0ul4If6nWkm7KolKu1WXCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnCRdAAoJEP4bvbfZuWjbjS8P/RAVHcc7Wg1QHVwEycPqcg+R
3fEtZ05iCIS3hC4zfwq0sJl0D1Z73qiT7tg8elXtqICn26GRQFIF/nDlpW0q7qvk
YYIBiXzMoOp3KlT7LzlgUOqvccAQQVomyDg96rAJKerwGlHdJKNSm/kDSQdfkrMV
YCvByjUhZuAuKN+AkuaRSgLMpDWzqmTb6T4fEwPMFeP6m1lwsZGmKRD7hh5HTAmm
uMWC2x0PHtmxv3qzMFXUBQrGj1dVHxWdJv4u5n5xH4M5sYcDAGvO/UzMh5c1Y2Zb
PmFrU/ZODLlSXU5r3AY0C5EYUBQ9YxHHIElbazC/2oR8pyu8zqzX7t1IwAovUhsp
f7Kl8LRYJjYaE2b64/4s/zxhMHvnpJLWvJjSZTcnzsPz1X89l76Lm5DRh/X/EPuq
A57UH5SxaY4eHjpN0xrPhWD/5uZRA56ERiOUbKjmHULMrKzJp92wg2XIocjzU/Zp
xgVVm+IcOzvQIdH9XfsSWLYdfOfjZHJMsbyvYSL6e3fr6PhJtuwt6qjLzY00cS40
OuzDaxIPl2vw9A58y+lZHy5O3BDR/pfuVbmB5WiOTFYIF1GH28QCg5K4W3OJYylS
ot+ifH5MZW4OrOZNJdLLeY1wrydXseGPLc8D0R8t6NtDTQIaqQKmDvV7FqeToTjD
fg04qU9IfFe/scw1FaxS
=OnaL
-----END PGP SIGNATURE-----

--5O9lHi5J2UB0ul4If6nWkm7KolKu1WXCc--

--===============0434168023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0434168023==--
