Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EB4C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 17:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD1B10E68A;
	Wed, 21 Aug 2024 17:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="mGIwk4a0";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FB910E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1724261989; x=1724866789; i=friedrich.vock@gmx.de;
 bh=1M74iaLh8LBnA696mK5NfHKxdHYVGH6LPp6zQtuJpJ0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mGIwk4a02xZaJQd5XxCGDLNGvrCQjzOsWn6aJDdtRlF5o/mtzHNuJmNazhmmjoQD
 zI/YgOlpfTtcyUXJCQeZ4Bs8F+VENB3BQ8IiYgyJCGoCE+Zm2UdjhtXbOM4zC2ojJ
 uXkHZNFF8Xbx91Ca5a6SVQ2w61Ts8v9vCTyEHizKLyt1sTZvCwDwYArN3sbotl+2r
 piuccOlyLElKwJBOzziZQHPydQ9CpiGi4n4hXbNrjwbDj8vuS8IqjFGfoGg+AvyZC
 UV058u9+0iFUzXK8YkKaIyLjdHeTZT+FcEse9BGNvV46R30lTKPETVV9h7yK3F7Ht
 DiIzhQNgzJ+MhVLGJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.114.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1sVMyN1cNu-00MuwC; Wed, 21
 Aug 2024 19:39:49 +0200
Message-ID: <c9d10825-de7e-4734-9761-bb0baa04d3f8@gmx.de>
Date: Wed, 21 Aug 2024 19:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: re-work VM syncing
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com, felix.kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20240821120324.4583-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FC15RWhItrFhRySdZZfWSZlTpMqNp+T1x1lQmuQvxvJoPLhAO6D
 E9CH1aBNR7h3gUke9BVrYgJu+aqDtboFrVUOORh88i0yfwZ2qZ1IkeHNpDeinL2YE9/kpra
 LP/QXjmAwUZmqPLBNNOD4h0xgqXfI2CXLarh3dyF6As3kBfLfjSdWH+JiZI1NgrOIbk/5Uy
 CQEph3JKoM+60sumHd9BQ==
UI-OutboundReport: notjunk:1;M01:P0:PQI6+oasUmI=;vxUrCdEBvG3xBT/zzSRzunzid/9
 DveJ/7NTw4Z7501WZdUUaJQ5PT+IRKGevlImhVSOFjMTcrQVACSzUeOgAwBj435cJms16hLsM
 hsUAKvkNGwoIbbsll7wiUnHJlWQ/qapoKn17gnULFtKcbRw4W7Heo07a+CVpzNp6AhYTWIKzD
 168jXOZ1vdck8Qp/r0WkRwKAHmOIwuYodUbrqQffynEpY6DPpvyJ2y40Sa7EtNY6PVBr8Yp1Q
 mlaFhqZMEhO0aIYUzLOjI/Kw9OwhwKfW7kcV0etr5wXa+amUFu4p4GfJyERJ31O+z3MRTv74s
 6jvTnIZcT/L0Q2olpypZi1B2l9mot1p29PxO0S3jhh5De+Q6LSVxPx5cPr8vtheSArO0E5GWF
 Shj6kpfTpZQbRRV2xpn1OdIrY2F0vQeZ5s3y0JRt0SG7u/7hDvWChUWex6Lu+7NB97/7cCNai
 DrLeK2s7/H6hkXV2uahgDM3gQVZC/VwY1XwHPrJq9svjpF5jUlrb26D7aJ+UGqKRAeWLzoP5M
 C8hBr06SHhQYosssd3mJGrr9yZGLw3/KV5gAe47xlFz7IXib9QBQgxPrlmNShkGnMEUosKIyL
 s3spgkXGVX9SOPtz8YlcsOBJdEl5XUIxEfQVc8y+kuKj6kdBNk4c0umqnMb3ckSK1vhC2KNyn
 YjztkyTPFbe0rkvQ/vGNWVCXaTiieWYT/O22+fT7eDXrCmKRBIBAta00JbV3x7VC1/Eu0BxD/
 ivJja58HVQ5mP2BYNR5h/U3acLDS8Lwb8zBppbCfewcCiparzIUPSlPYh8raYXfrl4IZftssp
 pcAP2d0KXlwShJHs39UNmIHA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 21.08.24 14:03, Christian K=C3=B6nig wrote:
> Rework how VM operations synchronize to submissions. Provide an
> amdgpu_sync container to the backends instead of an reservation
> object and fill in the amdgpu_sync object in the higher layers
> of the code.
>
> No intended functional change, just prepares for upcomming changes.

This looks like a really nice cleanup! I'm not sure how much it's worth
given that I'm not a maintainer, but this one and patch 3 are

Reviewed-by: Friedrich Vock <friedrich.vock@gmx.de>

Patch 2 looks ok to me as well, but I'm not in the loop as to what
problem this fixes. If the problem already occurs in the wild, it might
make sense to consider backporting?

Regards,
Friedrich

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 84 +++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 11 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 +---
>   5 files changed, 65 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm.c
> index bcb729094521..ba99d428610a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -838,7 +838,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
,
>   	params.vm =3D vm;
>   	params.immediate =3D immediate;
>
> -	r =3D vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
> +	r =3D vm->update_funcs->prepare(&params, NULL);
>   	if (r)
>   		goto error;
>
> @@ -933,7 +933,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *=
params,
>    * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
> - * @resv: fences we need to sync to
> + * @sync: fences we need to sync to
>    * @start: start of mapped range
>    * @last: last mapped entry
>    * @flags: flags for the entries
> @@ -949,16 +949,16 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params=
 *params,
>    * 0 for success, negative erro code for failure.
>    */
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_v=
m *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb, bool allow_overrid=
e,
> -			   struct dma_resv *resv, uint64_t start, uint64_t last,
> -			   uint64_t flags, uint64_t offset, uint64_t vram_base,
> +			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool allow_override, struct amdgpu_sync *sync,
> +			   uint64_t start, uint64_t last, uint64_t flags,
> +			   uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
>   			   struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
> -	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
>
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -991,14 +991,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>   	params.allow_override =3D allow_override;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>
> -	/* Implicitly sync to command submissions in the same VM before
> -	 * unmapping. Sync to moving fences before mapping.
> -	 */
> -	if (!(flags & AMDGPU_PTE_VALID))
> -		sync_mode =3D AMDGPU_SYNC_EQ_OWNER;
> -	else
> -		sync_mode =3D AMDGPU_SYNC_EXPLICIT;
> -
>   	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r =3D -EBUSY;
> @@ -1013,7 +1005,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,
>   		dma_fence_put(tmp);
>   	}
>
> -	r =3D vm->update_funcs->prepare(&params, resv, sync_mode);
> +	r =3D vm->update_funcs->prepare(&params, sync);
>   	if (r)
>   		goto error_free;
>
> @@ -1155,23 +1147,30 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ad=
ev, struct amdgpu_bo_va *bo_va,
>   	struct amdgpu_bo *bo =3D bo_va->base.bo;
>   	struct amdgpu_vm *vm =3D bo_va->base.vm;
>   	struct amdgpu_bo_va_mapping *mapping;
> +	struct dma_fence **last_update;
>   	dma_addr_t *pages_addr =3D NULL;
>   	struct ttm_resource *mem;
> -	struct dma_fence **last_update;
> +	struct amdgpu_sync sync;
>   	bool flush_tlb =3D clear;
> -	bool uncached;
> -	struct dma_resv *resv;
>   	uint64_t vram_base;
>   	uint64_t flags;
> +	bool uncached;
>   	int r;
>
> +	amdgpu_sync_create(&sync);
>   	if (clear || !bo) {
>   		mem =3D NULL;
> -		resv =3D vm->root.bo->tbo.base.resv;
> +
> +		/* Implicitly sync to command submissions in the same VM before
> +		 * unmapping.
> +		 */
> +		r =3D amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> +				     AMDGPU_SYNC_EQ_OWNER, vm);
> +		if (r)
> +			goto error_free;
>   	} else {
>   		struct drm_gem_object *obj =3D &bo->tbo.base;
>
> -		resv =3D bo->tbo.base.resv;
>   		if (obj->import_attach && bo_va->is_xgmi) {
>   			struct dma_buf *dma_buf =3D obj->import_attach->dmabuf;
>   			struct drm_gem_object *gobj =3D dma_buf->priv;
> @@ -1185,6 +1184,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v, struct amdgpu_bo_va *bo_va,
>   		if (mem && (mem->mem_type =3D=3D TTM_PL_TT ||
>   			    mem->mem_type =3D=3D AMDGPU_PL_PREEMPT))
>   			pages_addr =3D bo->tbo.ttm->dma_address;
> +
> +		/* Implicitly sync to moving fences before mapping anything */
> +		r =3D amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
> +				     AMDGPU_SYNC_EXPLICIT, vm);
> +		if (r)
> +			goto error_free;
>   	}
>
>   	if (bo) {
> @@ -1234,12 +1239,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ad=
ev, struct amdgpu_bo_va *bo_va,
>   		trace_amdgpu_vm_bo_update(mapping);
>
>   		r =3D amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
> -					   !uncached, resv, mapping->start, mapping->last,
> -					   update_flags, mapping->offset,
> -					   vram_base, mem, pages_addr,
> -					   last_update);
> +					   !uncached, &sync, mapping->start,
> +					   mapping->last, update_flags,
> +					   mapping->offset, vram_base, mem,
> +					   pages_addr, last_update);
>   		if (r)
> -			return r;
> +			goto error_free;
>   	}
>
>   	/* If the BO is not in its preferred location add it back to
> @@ -1267,7 +1272,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
, struct amdgpu_bo_va *bo_va,
>   			trace_amdgpu_vm_bo_mapping(mapping);
>   	}
>
> -	return 0;
> +error_free:
> +	amdgpu_sync_free(&sync);
> +	return r;
>   }
>
>   /**
> @@ -1414,25 +1421,34 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *=
adev,
>   			  struct amdgpu_vm *vm,
>   			  struct dma_fence **fence)
>   {
> -	struct dma_resv *resv =3D vm->root.bo->tbo.base.resv;
>   	struct amdgpu_bo_va_mapping *mapping;
> -	uint64_t init_pte_value =3D 0;
>   	struct dma_fence *f =3D NULL;
> +	struct amdgpu_sync sync;
>   	int r;
>
> +
> +	/*
> +	 * Implicitly sync to command submissions in the same VM before
> +	 * unmapping.
> +	 */
> +	amdgpu_sync_create(&sync);
> +	r =3D amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> +			     AMDGPU_SYNC_EQ_OWNER, vm);
> +	if (r)
> +		goto error_free;
> +
>   	while (!list_empty(&vm->freed)) {
>   		mapping =3D list_first_entry(&vm->freed,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>
>   		r =3D amdgpu_vm_update_range(adev, vm, false, false, true, false,
> -					   resv, mapping->start, mapping->last,
> -					   init_pte_value, 0, 0, NULL, NULL,
> -					   &f);
> +					   &sync, mapping->start, mapping->last,
> +					   0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> -			return r;
> +			goto error_free;
>   		}
>   	}
>
> @@ -1443,7 +1459,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *ad=
ev,
>   		dma_fence_put(f);
>   	}
>
> -	return 0;
> +error_free:
> +	amdgpu_sync_free(&sync);
> +	return r;
>
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm.h
> index 046949c4b695..1a759012ce93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -304,8 +304,8 @@ struct amdgpu_vm_update_params {
>
>   struct amdgpu_vm_update_funcs {
>   	int (*map_table)(struct amdgpu_bo_vm *bo);
> -	int (*prepare)(struct amdgpu_vm_update_params *p, struct dma_resv *res=
v,
> -		       enum amdgpu_sync_mode sync_mode);
> +	int (*prepare)(struct amdgpu_vm_update_params *p,
> +		       struct amdgpu_sync *sync);
>   	int (*update)(struct amdgpu_vm_update_params *p,
>   		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
>   		      unsigned count, uint32_t incr, uint64_t flags);
> @@ -505,9 +505,10 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_devic=
e *adev,
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_v=
m *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb, bool allow_overrid=
e,
> -			   struct dma_resv *resv, uint64_t start, uint64_t last,
> -			   uint64_t flags, uint64_t offset, uint64_t vram_base,
> +			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool allow_override, struct amdgpu_sync *sync,
> +			   uint64_t start, uint64_t last, uint64_t flags,
> +			   uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
>   			   struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_cpu.c
> index 3895bd7d176a..9ff59a4e6f15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -46,13 +46,12 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_=
vm *table)
>    * Negativ errno, 0 for success.
>    */
>   static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
> -				 struct dma_resv *resv,
> -				 enum amdgpu_sync_mode sync_mode)
> +				 struct amdgpu_sync *sync)
>   {
> -	if (!resv)
> +	if (!sync)
>   		return 0;
>
> -	return amdgpu_bo_sync_wait_resv(p->adev, resv, sync_mode, p->vm, true)=
;
> +	return amdgpu_sync_wait(sync, true);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm_pt.c
> index e39d6e7643bf..a076f43097e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -403,7 +403,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>   	params.vm =3D vm;
>   	params.immediate =3D immediate;
>
> -	r =3D vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
> +	r =3D vm->update_funcs->prepare(&params, NULL);
>   	if (r)
>   		goto exit;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vm_sdma.c
> index 9b748d7058b5..4772fba33285 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -77,32 +77,24 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm=
_update_params *p,
>    * amdgpu_vm_sdma_prepare - prepare SDMA command submission
>    *
>    * @p: see amdgpu_vm_update_params definition
> - * @resv: reservation object with embedded fence
> - * @sync_mode: synchronization mode
> + * @sync: amdgpu_sync object with fences to wait for
>    *
>    * Returns:
>    * Negativ errno, 0 for success.
>    */
>   static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
> -				  struct dma_resv *resv,
> -				  enum amdgpu_sync_mode sync_mode)
> +				  struct amdgpu_sync *sync)
>   {
> -	struct amdgpu_sync sync;
>   	int r;
>
>   	r =3D amdgpu_vm_sdma_alloc_job(p, 0);
>   	if (r)
>   		return r;
>
> -	if (!resv)
> +	if (!sync)
>   		return 0;
>
> -	amdgpu_sync_create(&sync);
> -	r =3D amdgpu_sync_resv(p->adev, &sync, resv, sync_mode, p->vm);
> -	if (!r)
> -		r =3D amdgpu_sync_push_to_job(&sync, p->job);
> -	amdgpu_sync_free(&sync);
> -
> +	r =3D amdgpu_sync_push_to_job(sync, p->job);
>   	if (r) {
>   		p->num_dw_left =3D 0;
>   		amdgpu_job_free(p->job);
