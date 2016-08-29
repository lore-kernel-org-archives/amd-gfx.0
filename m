From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: add VRAM manager
Date: Mon, 29 Aug 2016 20:27:56 +1000
Message-ID: <60a43518-8dd1-5e93-a997-1269c44e324d@folklore1984.net>
References: <1472462424-3052-1-git-send-email-deathsimple@vodafone.de>
 <1472462424-3052-6-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0575923716=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472462424-3052-6-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
--===============0575923716==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aJKHoVe9P60Kvjok9Wa6QdDm7fHjHtIhf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aJKHoVe9P60Kvjok9Wa6QdDm7fHjHtIhf
Content-Type: multipart/mixed; boundary="kIp8w4lKf8aXN4jHufQLcB0x7kVgO62wC"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <60a43518-8dd1-5e93-a997-1269c44e324d-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: add VRAM manager
References: <1472462424-3052-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
 <1472462424-3052-6-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1472462424-3052-6-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--kIp8w4lKf8aXN4jHufQLcB0x7kVgO62wC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I hope the following nitpicks are helpful.

Kind Regards,
Edward.

On 08/29/2016 07:20 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Split VRAM allocations into 4MB blocks.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 220 +++++++++++++++++++=
++++++++
>  9 files changed, 239 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> index c8d4d7c..ba12d3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -29,7 +29,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_pm.o atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>  	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>  	amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
> -	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o
> +	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> +	amdgpu_vram_mgr.o
> =20
>  # add asic specific block
>  amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+=3D cik.o cik_ih.o kv_smc.o kv_dpm.o \=

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index b2d95a9..7e3d341 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -96,6 +96,7 @@ extern unsigned amdgpu_cg_mask;
>  extern unsigned amdgpu_pg_mask;
>  extern int amdgpu_sclk_deep_sleep_en;
>  extern char *amdgpu_virtual_display;
> +extern int amdgpu_vram_page_split;
> =20
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
>  #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 38f5315..b2dcc11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1004,6 +1004,12 @@ static void amdgpu_check_arguments(struct amdgpu=
_device *adev)
>  			 amdgpu_vm_block_size);
>  		amdgpu_vm_block_size =3D 9;
>  	}
> +
> +	if (amdgpu_vram_page_split !=3D -1 && amdgpu_vram_page_split < 16) {
> +		dev_warn(adev->dev, "invalid VRAM page split (%d)\n",
> +			 amdgpu_vram_page_split);
> +		amdgpu_vram_page_split =3D 1024;
> +	}
>  }
> =20
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index 56c85e6..dcef0b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -82,6 +82,7 @@ int amdgpu_vm_size =3D 64;
>  int amdgpu_vm_block_size =3D -1;
>  int amdgpu_vm_fault_stop =3D 0;
>  int amdgpu_vm_debug =3D 0;
> +int amdgpu_vram_page_split =3D 1024;
>  int amdgpu_exp_hw_support =3D 0;
>  int amdgpu_dal =3D -1;
>  int amdgpu_sched_jobs =3D 32;
> @@ -161,6 +162,9 @@ module_param_named(vm_fault_stop, amdgpu_vm_fault_s=
top, int, 0444);
>  MODULE_PARM_DESC(vm_debug, "Debug VM handling (0 =3D disabled (default=
), 1 =3D enabled)");
>  module_param_named(vm_debug, amdgpu_vm_debug, int, 0644);
> =20
> +MODULE_PARM_DESC(vram_page_split, "Number of pages after we split VRAM=
 allocations (default 1024)");
> +module_param_named(vram_page_split, amdgpu_vram_page_split, int, 0444)=
;
> +
>  MODULE_PARM_DESC(exp_hw_support, "experimental hw support (1 =3D enabl=
e, 0 =3D disable (default))");
>  module_param_named(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> index 79f6413..d2dab28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -933,6 +933,7 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  		     !bo->pin_count);
>  	WARN_ON_ONCE(bo->tbo.mem.mem_type =3D=3D TTM_PL_VRAM &&
>  		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_LINEAR));
> +	WARN_ON_ONCE(bo->tbo.mem.start =3D=3D AMDGPU_BO_INVALID_OFFSET);
> =20
>  	return bo->tbo.offset;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.h
> index b6a2739..e498465 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -31,6 +31,8 @@
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu.h"
> =20
> +#define AMDGPU_BO_INVALID_OFFSET	LONG_MAX
> +
>  /**
>   * amdgpu_mem_type_to_domain - return domain corresponding to mem_type=

>   * @mem_type:	ttm memory type
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> index db8638b..9990957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -164,7 +164,7 @@ static int amdgpu_init_mem_type(struct ttm_bo_devic=
e *bdev, uint32_t type,
>  		break;
>  	case TTM_PL_VRAM:
>  		/* "On-card" video ram */
> -		man->func =3D &ttm_bo_manager_func;
> +		man->func =3D &amdgpu_vram_mgr_func;
>  		man->gpu_offset =3D adev->mc.vram_start;
>  		man->flags =3D TTM_MEMTYPE_FLAG_FIXED |
>  			     TTM_MEMTYPE_FLAG_MAPPABLE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.h
> index 72f6bfc..365ce9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -65,6 +65,8 @@ struct amdgpu_mman {
>  	struct amdgpu_mman_lru			guard;
>  };
> =20
> +extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
> +
>  int amdgpu_copy_buffer(struct amdgpu_ring *ring,
>  		       uint64_t src_offset,
>  		       uint64_t dst_offset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vram_mgr.c
> new file mode 100644
> index 0000000..6c5f3ba
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -0,0 +1,220 @@
> +/*
> + * Copyright 2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: Christian K=C3=B6nig
> + */
> +
> +#include <drm/drmP.h>
> +#include "amdgpu.h"
> +
> +struct amdgpu_vram_mgr {
> +	struct drm_mm mm;
> +	spinlock_t lock;
> +};
> +
> +/**
> + * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
> + *
> + * @man: TTM memory type manager
> + * @p_size: maximum size of VRAM
> + *
> + * Allocate and initialize the VRAM manager.
> + */
> +static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
> +				unsigned long p_size)
> +{
> +	struct amdgpu_vram_mgr *mgr;
> +
> +	mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
> +	if (!mgr)
> +		return -ENOMEM;
> +
> +	drm_mm_init(&mgr->mm, 0, p_size);
> +	spin_lock_init(&mgr->lock);
> +	man->priv =3D mgr;
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_vram_mgr_fini - free and destroy VRAM manager
> + *
> + * @man: TTM memory type manager
> + *
> + * Destory and free the VRAM manager, returns -EBUSY if ranges are sti=
ll
> + * allocated inside it.
> + */
> +static int amdgpu_vram_mgr_fini(struct ttm_mem_type_manager *man)
> +{
> +	struct amdgpu_vram_mgr *mgr =3D man->priv;
> +
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_clean(&mgr->mm)) {
> +		drm_mm_takedown(&mgr->mm);
> +		spin_unlock(&mgr->lock);
> +		kfree(mgr);
> +		man->priv =3D NULL;
> +		return 0;
> +	}
> +	spin_unlock(&mgr->lock);
> +	return -EBUSY;

What about taking the bulk of this out the true branch into the body of
the function as in the following:

if (!drm_mm_clean(&mgr->mm)) {
		spin_unlock(&mgr->lock);
		return -EBUSY;
}

drm_mm_takedown(&mgr->mm);
spin_unlock(&mgr->lock);
kfree(mgr);
man->priv =3D NULL;

return 0;


> +}
> +
> +/**
> + * amdgpu_vram_mgr_new - allocate new ranges
> + *
> + * @man: TTM memory type manager
> + * @tbo: TTM BO we need this range for
> + * @place: placement flags and restrictions
> + * @mem: the resulting mem object
> + *
> + * Allocate VRAM for the given BO.
> + */
> +static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
> +			       struct ttm_buffer_object *tbo,
> +			       const struct ttm_place *place,
> +			       struct ttm_mem_reg *mem)
> +{
> +	struct amdgpu_bo *bo =3D container_of(tbo, struct amdgpu_bo, tbo);
> +	struct amdgpu_vram_mgr *mgr =3D man->priv;
> +	struct drm_mm *mm =3D &mgr->mm;
> +	struct drm_mm_node *nodes;
> +	enum drm_mm_search_flags sflags =3D DRM_MM_SEARCH_DEFAULT;
> +	enum drm_mm_allocator_flags aflags =3D DRM_MM_CREATE_DEFAULT;
> +	unsigned long lpfn, num_nodes, pages_per_node, pages_left;
> +	unsigned i;
> +	int r;
> +
> +	lpfn =3D place->lpfn;
> +	if (!lpfn)
> +		lpfn =3D man->size;
> +
> +	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_LINEAR ||
> +	    amdgpu_vram_page_split =3D=3D -1) {
> +		pages_per_node =3D ~0ul;
> +		num_nodes =3D 1;
> +	} else {
> +		pages_per_node =3D max((uint32_t)amdgpu_vram_page_split,
> +				     mem->page_alignment);
> +		num_nodes =3D DIV_ROUND_UP(mem->num_pages, pages_per_node);
> +	}
> +
> +	nodes =3D kcalloc(num_nodes, sizeof(*nodes), GFP_KERNEL);
> +	if (!nodes)
> +		return -ENOMEM;
> +
> +	if (place->flags & TTM_PL_FLAG_TOPDOWN) {
> +		sflags =3D DRM_MM_SEARCH_BELOW;
> +		aflags =3D DRM_MM_CREATE_TOP;
> +	}
> +
> +	pages_left =3D mem->num_pages;
> +
> +	spin_lock(&mgr->lock);
> +	for (i =3D 0; i < num_nodes; ++i) {
> +		unsigned long pages =3D min(pages_left, pages_per_node);
> +		uint32_t alignment =3D mem->page_alignment;
> +
> +		if (pages =3D=3D pages_per_node)
> +			alignment =3D pages_per_node;
> +		else
> +			sflags |=3D DRM_MM_SEARCH_BEST;
> +
> +		r =3D drm_mm_insert_node_in_range_generic(mm, &nodes[i], pages,
> +							alignment, 0,
> +							place->fpfn, lpfn,
> +							sflags, aflags);
> +		if (unlikely(r))
> +			goto error;
> +
> +		pages_left -=3D pages;
> +	}
> +	spin_unlock(&mgr->lock);
> +
> +	mem->start =3D num_nodes =3D=3D 1 ? nodes[0].start : AMDGPU_BO_INVALI=
D_OFFSET;
> +	mem->mm_node =3D nodes;
> +
> +	return 0;
> +
> +error:
> +	while (i--)

Perhaps make this more explicit of intent, I feel i being negative is a
bug waiting to happen?

> +		drm_mm_remove_node(&nodes[i]);

Could be wrong but do we miss one nodes[] here?

> +	spin_unlock(&mgr->lock);
> +
> +	kfree(nodes);
> +	return r =3D=3D -ENOSPC ? 0 : r;
> +}
> +
> +/**
> + * amdgpu_vram_mgr_del - free ranges
> + *
> + * @man: TTM memory type manager
> + * @tbo: TTM BO we need this range for
> + * @place: placement flags and restrictions
> + * @mem: TTM memory object
> + *
> + * Free the allocated VRAM again.
> + */
> +static void amdgpu_vram_mgr_del(struct ttm_mem_type_manager *man,
> +				struct ttm_mem_reg *mem)
> +{
> +	struct amdgpu_vram_mgr *mgr =3D man->priv;
> +	struct drm_mm_node *nodes =3D mem->mm_node;
> +	unsigned i, pages =3D mem->num_pages;
> +
> +	if (!mem->mm_node)
> +		return;
> +
> +	spin_lock(&mgr->lock);
> +	for (i =3D 0; pages; ++i) {

More explicit on the intent of the pages predicate.

> +		pages -=3D nodes[i].size;
> +		drm_mm_remove_node(&nodes[i]);
> +	}
> +	spin_unlock(&mgr->lock);
> +
> +	kfree(mem->mm_node);
> +	mem->mm_node =3D NULL;
> +}
> +
> +/**
> + * amdgpu_vram_mgr_debug - dump VRAM table
> + *
> + * @man: TTM memory type manager
> + * @prefix: text prefix
> + *
> + * Dump the table content using printk.
> + */
> +static void amdgpu_vram_mgr_debug(struct ttm_mem_type_manager *man,
> +				  const char *prefix)
> +{
> +	struct amdgpu_vram_mgr *mgr =3D man->priv;
> +
> +	spin_lock(&mgr->lock);
> +	drm_mm_debug_table(&mgr->mm, prefix);
> +	spin_unlock(&mgr->lock);
> +}
> +
> +const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func =3D {
> +	amdgpu_vram_mgr_init,
> +	amdgpu_vram_mgr_fini,
> +	amdgpu_vram_mgr_new,
> +	amdgpu_vram_mgr_del,
> +	amdgpu_vram_mgr_debug
> +};
>=20


--kIp8w4lKf8aXN4jHufQLcB0x7kVgO62wC--

--aJKHoVe9P60Kvjok9Wa6QdDm7fHjHtIhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxA4sAAoJEP4bvbfZuWjbOTcQAJ3Nm1uvDv+wajrigIf3rl7K
HsOEd4jPOF06lUNLmk2JaXzJev+si6m6OGigChTYnzXZZJRERP7N7b2s79kaOkt+
OZs6bHnQccL3dozXNHo15zm8f5bq7qSAAIMqxsyY3iITBXdXfdARYXj7l1/e10Nz
X2HfokN5bRsyri+Y9OwEHNk+X+WSzO0lVfcnC4GVy2M7+2G4MOb90AOypkhA+yuK
NooHLy9VaKGtTglWfFa8f19B8e3SsXXq9YFte9tkRrmyoyRmQ8rXtjIwaWNbUUOO
DxM15Yf8cEhikmCkoWsc1GjrbNgNva5VdXAugb41k1p5pvynK7zqdgtbgrLGJIE5
F1vzpCZDy1L+dpIRiD89Dt+XP8h1htb2sbCJUnTeFmW3CkqyWfuLMkQ4H+4nQzJ9
Ekd3u7ZdaR76hn4z8dU/g2cLvEFn4hCovNVJMuevX01zehnFPQeLEP8cVbe+Lv8g
sRzqDOKu+sAfrN3qDVWqAOWCpv/uhWzq+pX55wNC2ErRtzHjSj7/U7pbCWO62jxV
gyFnaQo0hw4PKaJPjWYDOybkixUNT/vlYxBpbGvJb7jM28igl1E+CCacNH5t0foM
HHQiHjl/Iy4arAMntjpqBJBNYLEkI7MfFzQsxxs3aOp9RCytT6Wxs7DId1Ue3wi0
D+2XDVx6jsg6r/x9+1pQ
=V0m7
-----END PGP SIGNATURE-----

--aJKHoVe9P60Kvjok9Wa6QdDm7fHjHtIhf--

--===============0575923716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0575923716==--
