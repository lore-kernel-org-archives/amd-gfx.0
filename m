From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: add AMDGPU_GEM_CREATE_VRAM_LINEAR flag v2
Date: Mon, 29 Aug 2016 21:02:02 +1000
Message-ID: <754ca3cd-657f-a579-c789-6923e1579778@folklore1984.net>
References: <1472462424-3052-1-git-send-email-deathsimple@vodafone.de>
 <1472462424-3052-2-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1624811061=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472462424-3052-2-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
--===============1624811061==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BIFBvUE4C15vJvxnAiHFLddLTnfRfmc9E"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BIFBvUE4C15vJvxnAiHFLddLTnfRfmc9E
Content-Type: multipart/mixed; boundary="WedQIuUAtLgjVwBRWMD43WckeeQmUC1Ae"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <754ca3cd-657f-a579-c789-6923e1579778-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: add AMDGPU_GEM_CREATE_VRAM_LINEAR flag v2
References: <1472462424-3052-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
 <1472462424-3052-2-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1472462424-3052-2-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--WedQIuUAtLgjVwBRWMD43WckeeQmUC1Ae
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/29/2016 07:20 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Add a flag noting that a BO must be created using linear VRAM
> and set this flag on all in kernel users where appropriate.
>=20
> Hopefully I haven't missed anything.
>=20
> v2: add it in a few more places, fix CPU mapping.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 31 ++++++++++++++++++++++=
++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  9 ++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  6 ++++--
>  include/uapi/drm/amdgpu_drm.h              |  2 ++
>  14 files changed, 85 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 545789f..b2d95a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -2499,6 +2499,7 @@ static inline void amdgpu_acpi_fini(struct amdgpu=
_device *adev) { }
>  struct amdgpu_bo_va_mapping *
>  amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>  		       uint64_t addr, struct amdgpu_bo **bo);
> +int amdgpu_cs_make_bos_linear(struct amdgpu_cs_parser *parser);
> =20
>  #if defined(CONFIG_DRM_AMD_DAL)
>  int amdgpu_dm_display_resume(struct amdgpu_device *adev );
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cgs.c
> index 040993c..c2dfcd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -146,7 +146,8 @@ static int amdgpu_cgs_alloc_gpu_mem(struct cgs_devi=
ce *cgs_device,
>  	switch(type) {
>  	case CGS_GPU_MEM_TYPE__VISIBLE_CONTIG_FB:
>  	case CGS_GPU_MEM_TYPE__VISIBLE_FB:
> -		flags =3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +		flags =3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +			AMDGPU_GEM_CREATE_VRAM_LINEAR;
>  		domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>  		if (max_offset > adev->mc.real_vram_size)
>  			return -EINVAL;
> @@ -157,7 +158,8 @@ static int amdgpu_cgs_alloc_gpu_mem(struct cgs_devi=
ce *cgs_device,
>  		break;
>  	case CGS_GPU_MEM_TYPE__INVISIBLE_CONTIG_FB:
>  	case CGS_GPU_MEM_TYPE__INVISIBLE_FB:
> -		flags =3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> +		flags =3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> +			AMDGPU_GEM_CREATE_VRAM_LINEAR;
>  		domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>  		if (adev->mc.visible_vram_size < adev->mc.real_vram_size) {
>  			place.fpfn =3D
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> index b0e11ca..108408b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1097,3 +1097,34 @@ amdgpu_cs_find_mapping(struct amdgpu_cs_parser *=
parser,
> =20
>  	return NULL;
>  }
> +
> +/**
> + * amdgpu_cs_make_bos_linear - mark all BOs in this CS as linear
> + *
> + * @parser: command submission parser context
> + *
> + * Helper for UVD/VCE VM emulation, mark all BOs in this CS as linear.=

> + */
> +int amdgpu_cs_make_bos_linear(struct amdgpu_cs_parser *parser)
> +{
> +	unsigned i;
> +	int r;
> +
> +	if (!parser->bo_list)
> +		return 0;
> +
> +	for (i =3D 0; i < parser->bo_list->num_entries; i++) {
> +		struct amdgpu_bo *bo =3D parser->bo_list->array[i].robj;
> +
> +		if (bo->flags |=3D AMDGPU_GEM_CREATE_VRAM_LINEAR)

Isn't this always true as its an assignment with just some mutation
along the way?

> +			continue;
> +
> +		bo->flags |=3D AMDGPU_GEM_CREATE_VRAM_LINEAR;
> +		amdgpu_ttm_placement_from_domain(bo, bo->allowed_domains);
> +		r =3D ttm_bo_validate(&bo->tbo, &bo->placement, false, false);
> +		if (unlikely(r))
> +			return r;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 1b31a7c..38f5315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -256,7 +256,8 @@ static int amdgpu_vram_scratch_init(struct amdgpu_d=
evice *adev)
>  	if (adev->vram_scratch.robj =3D=3D NULL) {
>  		r =3D amdgpu_bo_create(adev, AMDGPU_GPU_PAGE_SIZE,
>  				     PAGE_SIZE, true, AMDGPU_GEM_DOMAIN_VRAM,
> -				     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +				     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +				     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  				     NULL, NULL, &adev->vram_scratch.robj);
>  		if (r) {
>  			return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fb.c
> index e694c99..efa9b79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -120,7 +120,8 @@ static int amdgpufb_create_pinned_object(struct amd=
gpu_fbdev *rfbdev,
>  	aligned_size =3D ALIGN(size, PAGE_SIZE);
>  	ret =3D amdgpu_gem_object_create(adev, aligned_size, 0,
>  				       AMDGPU_GEM_DOMAIN_VRAM,
> -				       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +				       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +				       AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  				       true, &gobj);
>  	if (ret) {
>  		printk(KERN_ERR "failed to allocate framebuffer (%d)\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gart.c
> index 0feea34..b5982a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -126,7 +126,8 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_devi=
ce *adev)
>  	if (adev->gart.robj =3D=3D NULL) {
>  		r =3D amdgpu_bo_create(adev, adev->gart.table_size,
>  				     PAGE_SIZE, true, AMDGPU_GEM_DOMAIN_VRAM,
> -				     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +				     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +				     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  				     NULL, NULL, &adev->gart.robj);
>  		if (r) {
>  			return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> index b17734e..6f83909 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -247,7 +247,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *a=
dev,
>  	int r;
> =20
>  	r =3D amdgpu_bo_create(adev, size, align, true, domain,
> -			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +			     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  			     NULL, NULL, bo_ptr);
>  	if (r) {
>  		dev_err(adev->dev, "(%d) failed to allocate kernel bo\n", r);
> @@ -617,6 +618,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, =
u32 domain,
> =20
>  		return 0;
>  	}
> +
> +	bo->flags |=3D AMDGPU_GEM_CREATE_VRAM_LINEAR;
>  	amdgpu_ttm_placement_from_domain(bo, domain);
>  	for (i =3D 0; i < bo->placement.num_placement; i++) {
>  		/* force to pin into visible video ram */
> @@ -854,7 +857,9 @@ int amdgpu_bo_fault_reserve_notify(struct ttm_buffe=
r_object *bo)
> =20
>  	size =3D bo->mem.num_pages << PAGE_SHIFT;
>  	offset =3D bo->mem.start << PAGE_SHIFT;
> -	if ((offset + size) <=3D adev->mc.visible_vram_size)
> +	/* TODO: figure out how to map scattered VRAM to the CPU */
> +	if ((offset + size) <=3D adev->mc.visible_vram_size &&
> +	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_LINEAR))
>  		return 0;
> =20
>  	/* Can't move a pinned BO to visible VRAM */
> @@ -862,6 +867,7 @@ int amdgpu_bo_fault_reserve_notify(struct ttm_buffe=
r_object *bo)
>  		return -EINVAL;
> =20
>  	/* hurrah the memory is not visible ! */
> +	abo->flags |=3D AMDGPU_GEM_CREATE_VRAM_LINEAR;
>  	amdgpu_ttm_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_VRAM);
>  	lpfn =3D	adev->mc.visible_vram_size >> PAGE_SHIFT;
>  	for (i =3D 0; i < abo->placement.num_placement; i++) {
> @@ -920,6 +926,8 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	WARN_ON_ONCE(bo->tbo.mem.mem_type =3D=3D TTM_PL_SYSTEM);
>  	WARN_ON_ONCE(!ww_mutex_is_locked(&bo->tbo.resv->lock) &&
>  		     !bo->pin_count);
> +	WARN_ON_ONCE(bo->tbo.mem.mem_type =3D=3D TTM_PL_VRAM &&
> +		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_LINEAR));
> =20
>  	return bo->tbo.offset;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> index e2f6a46..ea480bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1024,7 +1024,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> =20
>  	r =3D amdgpu_bo_create(adev, 256 * 1024, PAGE_SIZE, true,
>  			     AMDGPU_GEM_DOMAIN_VRAM,
> -			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +			     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  			     NULL, NULL, &adev->stollen_vga_memory);
>  	if (r) {
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_uvd.c
> index 5888e8a..5f5380c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -891,6 +891,10 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_pars=
er *parser, uint32_t ib_idx)
>  		return -EINVAL;
>  	}
> =20
> +	r =3D amdgpu_cs_make_bos_linear(parser);
> +	if (r)
> +		return r;
> +
>  	ctx.parser =3D parser;
>  	ctx.buf_sizes =3D buf_sizes;
>  	ctx.ib_idx =3D ib_idx;
> @@ -1007,7 +1011,8 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring =
*ring, uint32_t handle,
> =20
>  	r =3D amdgpu_bo_create(adev, 1024, PAGE_SIZE, true,
>  			     AMDGPU_GEM_DOMAIN_VRAM,
> -			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +			     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  			     NULL, NULL, &bo);
>  	if (r)
>  		return r;
> @@ -1056,7 +1061,8 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring=
 *ring, uint32_t handle,
> =20
>  	r =3D amdgpu_bo_create(adev, 1024, PAGE_SIZE, true,
>  			     AMDGPU_GEM_DOMAIN_VRAM,
> -			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +			     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  			     NULL, NULL, &bo);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vce.c
> index 9b71d6c..bb97a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -157,7 +157,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, =
unsigned long size)
> =20
>  	r =3D amdgpu_bo_create(adev, size, PAGE_SIZE, true,
>  			     AMDGPU_GEM_DOMAIN_VRAM,
> -			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +			     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  			     NULL, NULL, &adev->vce.vcpu_bo);
>  	if (r) {
>  		dev_err(adev->dev, "(%d) failed to allocate VCE bo\n", r);
> @@ -634,7 +635,11 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_pars=
er *p, uint32_t ib_idx)
>  	uint32_t allocated =3D 0;
>  	uint32_t tmp, handle =3D 0;
>  	uint32_t *size =3D &tmp;
> -	int i, r =3D 0, idx =3D 0;
> +	int i, r, idx =3D 0;
> +
> +	r =3D amdgpu_cs_make_bos_linear(p);
> +	if (r)
> +		return r;
> =20
>  	while (idx < ib->length_dw) {
>  		uint32_t len =3D amdgpu_get_ib_value(p, ib_idx, idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index 7660f82..ea1bd67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1398,7 +1398,8 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>  				     AMDGPU_GPU_PAGE_SIZE, true,
>  				     AMDGPU_GEM_DOMAIN_VRAM,
>  				     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> -				     AMDGPU_GEM_CREATE_SHADOW,
> +				     AMDGPU_GEM_CREATE_SHADOW |
> +				     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  				     NULL, resv, &pt);
>  		if (r)
>  			goto error_free;
> @@ -1598,7 +1599,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
>  	r =3D amdgpu_bo_create(adev, pd_size, align, true,
>  			     AMDGPU_GEM_DOMAIN_VRAM,
>  			     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> -			     AMDGPU_GEM_CREATE_SHADOW,
> +			     AMDGPU_GEM_CREATE_SHADOW |
> +			     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  			     NULL, NULL, &vm->page_directory);
>  	if (r)
>  		goto error_free_sched_entity;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> index f055d49..1517a8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3213,7 +3213,8 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device=
 *adev)
>  		if (adev->gfx.rlc.save_restore_obj =3D=3D NULL) {
>  			r =3D amdgpu_bo_create(adev, dws * 4, PAGE_SIZE, true,
>  					     AMDGPU_GEM_DOMAIN_VRAM,
> -					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +					     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  					     NULL, NULL,
>  					     &adev->gfx.rlc.save_restore_obj);
>  			if (r) {
> @@ -3257,7 +3258,8 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device=
 *adev)
>  		if (adev->gfx.rlc.clear_state_obj =3D=3D NULL) {
>  			r =3D amdgpu_bo_create(adev, dws * 4, PAGE_SIZE, true,
>  					     AMDGPU_GEM_DOMAIN_VRAM,
> -					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +					     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  					     NULL, NULL,
>  					     &adev->gfx.rlc.clear_state_obj);
>  			if (r) {
> @@ -3297,7 +3299,8 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device=
 *adev)
>  		if (adev->gfx.rlc.cp_table_obj =3D=3D NULL) {
>  			r =3D amdgpu_bo_create(adev, adev->gfx.rlc.cp_table_size, PAGE_SIZE=
, true,
>  					     AMDGPU_GEM_DOMAIN_VRAM,
> -					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +					     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  					     NULL, NULL,
>  					     &adev->gfx.rlc.cp_table_obj);
>  			if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> index 6e01392..26e614e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1273,7 +1273,8 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device=
 *adev)
>  		if (adev->gfx.rlc.clear_state_obj =3D=3D NULL) {
>  			r =3D amdgpu_bo_create(adev, dws * 4, PAGE_SIZE, true,
>  					     AMDGPU_GEM_DOMAIN_VRAM,
> -					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +					     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  					     NULL, NULL,
>  					     &adev->gfx.rlc.clear_state_obj);
>  			if (r) {
> @@ -1315,7 +1316,8 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device=
 *adev)
>  		if (adev->gfx.rlc.cp_table_obj =3D=3D NULL) {
>  			r =3D amdgpu_bo_create(adev, adev->gfx.rlc.cp_table_size, PAGE_SIZE=
, true,
>  					     AMDGPU_GEM_DOMAIN_VRAM,
> -					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> +					     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +					     AMDGPU_GEM_CREATE_VRAM_LINEAR,
>  					     NULL, NULL,
>  					     &adev->gfx.rlc.cp_table_obj);
>  			if (r) {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> index 403b676..2aede6a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -79,6 +79,8 @@
>  #define AMDGPU_GEM_CREATE_VRAM_CLEARED		(1 << 3)
>  /* Flag that create shadow bo(GTT) while allocating vram bo */
>  #define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
> +/* Flag that allocating the BO should use linear VRAM */
> +#define AMDGPU_GEM_CREATE_VRAM_LINEAR		(1 << 5)
> =20
>  struct drm_amdgpu_gem_create_in  {
>  	/** the requested memory size */
>=20


--WedQIuUAtLgjVwBRWMD43WckeeQmUC1Ae--

--BIFBvUE4C15vJvxnAiHFLddLTnfRfmc9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxBYqAAoJEP4bvbfZuWjbQ/kP/isGSJX+jbw5C5aDdtyoW5SF
QC55m9hw2OTIYzhVhlwZFD1olngYrU4ijyRjQ/fQBEGqQV2LEIi9x9G5OC5iI40Q
N4ZWSCBXrvValO75T7J4Fhhlt9TEzv6X5BotFmLKLV4bgqBWGNnRp6+v0E72both
/yQtifgrdhMzoCCH4ZwvPIBLZdWi0XNUtrBDpFsmRl26Amj1bnNs78RCTK/Hqros
scauEobkNgOyPLzZQ0O8LZy42X+frFjQbvjsvV4k7SdktgOoW7dOSaaQ4C0bJN6k
Hfh9vc6NVSsAJP7OGE7Oa6ynN3688E4oYZKaeMzI3v+zFXXcmTaGjUW/TaYgIjmR
3GwP1fZifhuW1eqEUOICdQRBljz9NHAgitCZqBFhe93Tr/ujqQmChcHAKUHYi5Jk
raLC+UAM2FAZ0Grq85dMfIuH9HPoPwa3ynZw4SHoWkRVvI8byH9DzAgI6QfeUe0V
qCp/msoUnP13vD/GQDFcwv1lf01/IJ8eWuZ6aQa1X2J7IoOcBZmIE2Lkk247KzG/
DJsBOn78qGc1/qYeSCT4+0MRz4I0RdlO91a3TtMj8LUpO27/mxWxnZ7km4uStYNN
9p9afC9fwlKiYeji1oKFCXVsAKKa4kpxGpyjehXh4F9sSFdn9Qy7dLRv4QHieNu9
CRj2nhrtXiBIH7ygA4DC
=Abwt
-----END PGP SIGNATURE-----

--BIFBvUE4C15vJvxnAiHFLddLTnfRfmc9E--

--===============1624811061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1624811061==--
