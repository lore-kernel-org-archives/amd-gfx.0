Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF9CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 17:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F176B10E22E;
	Tue,  6 Oct 2026 17:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KRskUSc+";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20A610E2EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 17:46:42 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2dcbcc546fso123077766b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791308801; x=1791913601; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HpjrKK1KbiRyxkBadE42LrH0xAhCc5XaMXFE68mClBg=;
 b=KRskUSc+K49WKMMlqMKXYBGaKOxhnXa+ckr+sYZQlUSZ0EuwkWZW7xntPf0BfutjNP
 ecgUEEKYD4d7UKTkMNMDooRyQqlgzbLudQox2gOmNYASfwrm8rnS9xSVh4iDoXgqEnEl
 ZVVz9nYEpeufcnOf6gK60FQysqRFnJWjwumYLwVxD0+9kjg/pNYfRthD32jbqNyAKtWQ
 l5pEGiCYqiIc0phHFoatWDVu4VsLTazlBLYhj+6UOW0VojQt1fphJkjoWI1CVQeAMVw3
 9qRkjQC26thKs18Ln1PT1jXAC59L6oayWsTTH9/EaHkBPkE0OSh7BXn27HK4xm6eCLff
 JR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791308801; x=1791913601;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HpjrKK1KbiRyxkBadE42LrH0xAhCc5XaMXFE68mClBg=;
 b=jRLFhdWzf1LWFk3HRJJ9u0cfAvmr2ck73Z35uRFK1hX5yFW+WyKUA0U+c0zXqxFLEt
 O700G9BgEswIze9EzelHzaJmgcAqj7S7SN5b8t+seZD6DN8A3CCjI8H0NSiMMS+aRlJ2
 N/cfuZCjphoFJbNfPThB6CfzY8k7X9e7YnGG/H4pmlTOB5TAqlKkMEs2+IaqmK7PHq9x
 sbn76zym+0bXcm5/f6AqtP5xT7iF6rSxIbFf48u/2Jq4pIHHD79F6TwinbcShhXIwas2
 D3UkdLy88QzfmLgaeL4w13X2asshIeJT3iY2418T/wzG/MAEZoJQlot23rqXJO4Li7jk
 h0jw==
X-Gm-Message-State: AFuF++ndPhYfXNzri8FAUVbddwjikCb71yaxLxzSmdMURnWHur20amBa
 TqhaNdny6+Lzhe2w2sfUIPcujQNAyZL5xMkHn89gdvRHUyAY9SOdfzfD
X-Gm-Gg: AYBFou33uZCjJNbKECnk6A7VPBEkYHShCfl3xjhuaag7bbxnWKJHlJiYurUYK31f9yZ
 nZzxJKsGwemDiUFxxjirnKtsok+akkiae8ssGA5bI+TGGblS/SFb3xauToN5I7ggyPkWYQmo3Dg
 QTrdEGLwKuVhZtXK6EPQwOsbsiesFKYhV7hjOVLa2WB2UGyBJwjvkUOW50fikJi9km4gCUxVL7p
 yEiX00ag5hgi7XDzs66lTHkw2N7lJtOJgDRU4UusjvwZv6hVdjRgQBWMYRq3cjKSUr/O2fdMJXg
 G/CRV7AFDHg4jllDOeNkTq5HyjyJL0Nfs3KeL5+smmItc7HUPcDQdgWqvaRx5woRw5w8ZmFCk9f
 NpXNJmr4nv3uwX6OWHsuHvhhWUApDEhxfBbn1bumLZ+p0JfXj06IaExlLP9EO8vcwWsU0daD7MD
 7DKfFhacFq9rlvW6CBgGag0CwtEz5iiZ/spPZs6O7L4eJglddEmJnyYcDDsyzecy7tYFmmhD9zB
 ByABfouV9ati+dLZt8Ob3CpKT9A7xcRYx0IYWhUVh0StTjM5Lv94jHhWZs=
X-Received: by 2002:a17:907:97d0:b0:c2e:9fa:cd14 with SMTP id
 a640c23a62f3a-c3169fc60a8mr223124766b.12.1791308800702; 
 Tue, 06 Oct 2026 10:46:40 -0700 (PDT)
Received: from timur-hyperion.localnet (86FF63C5.dsl.pool.telekom.hu.
 [134.255.99.197]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3167df3534sm91991666b.28.2026.10.06.10.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:46:40 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com,
 christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 6/8] drm/amdgpu: split amdgpu_vm_update_range v3
Date: Tue, 06 Oct 2026 19:32:37 +0200
Message-ID: <m2G7mLw1Qwi6xurfS_KwIQ@gmail.com>
In-Reply-To: <20260930133315.12270-6-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
 <20260930133315.12270-6-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, September 30, 2026 3:33:12=E2=80=AFPM Central European Summer=
 Time=20
Christian K=C3=B6nig wrote:
> Split amdgpu_vm_update_range into two functions.
>=20
> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
> which can be done while holding the VM lock.
>=20
> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
> lock in MMU notifiers.
>=20
> v2: add unlocked parameter and drop flags
> v3: use correct clear flags
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  50 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 117 +++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  16 ++-
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  40 ++----
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  17 ++-
>  7 files changed, 157 insertions(+), 89 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h index
> ae569b4497f6a..d4a4e51f3b1da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>  /* Internal kernel job ids. (decreasing values, starting from U64_MAX). =
*/
>  #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE            =20
> (18446744073709551615ULL) #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES    =
 =20
>   (18446744073709551614ULL) -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE=
 =20
>      (18446744073709551613ULL) +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE=
 =20
>         (18446744073709551613ULL) #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEA=
R=20
>           (18446744073709551612ULL) #define
> AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
> #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA
> (18446744073709551610ULL) @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>  #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST       =20
> (18446744073709551600ULL) #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST     =
 =20
>   (18446744073709551599ULL) #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER      =
 =20
>     (18446744073709551598ULL) +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANG=
E=20
>        (18446744073709551597ULL)
>=20
>  struct amdgpu_job {
>  	struct drm_sched_job    base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c index
> 708ca8d56e8c2..7915f3735016a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -2056,9 +2056,9 @@ static int amdgpu_ualink_unmap_npa_addr(struct
> amdgpu_device *adev, return r;
>  	}
>=20
> -	r =3D amdgpu_vm_update_range(adev, vm, false, true, false, NULL,=20
npa_addr,
> -				   npa_addr + size - 1,=20
pte_value, 0, 0, NULL,
> -				   NULL, &vm->last_update);
> +	r =3D amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
> +				npa_addr + size - 1, pte_value, 0,=20
0, NULL,
> +				NULL, &vm->last_update);
>  	if (r) {
>  		dev_err(adev->dev,
>  			"Failed to unmap NPA addr (%llx) from NPA=20
VM\n", npa_addr);
> @@ -2108,10 +2108,10 @@ static int amdgpu_ualink_map_npa_addr(struct
> amdgpu_device *adev, u64 npa_addr, return r;
>  	}
>=20
> -	r =3D amdgpu_vm_update_range(adev, vm, false, true, false, NULL,=20
npa_addr,
> -				   npa_addr + size - 1, pte_flags,=20
offset,
> -				   adev-
>vm_manager.vram_base_offset,
> -				   bo->tbo.resource, NULL, &vm-
>last_update);
> +	r =3D amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
> +				npa_addr + size - 1, pte_flags,=20
offset,
> +				adev->vm_manager.vram_base_offset,
> +				bo->tbo.resource, NULL, &vm-
>last_update);
>  	if (r) {
>  		dev_warn(adev->dev,
>  			"Failed to map NPA addr (%llx) into NPA=20
VM\n", npa_addr);
> @@ -2645,12 +2645,12 @@ static void amdgpu_ualink_force_retry_rpcs(struct
> amdgpu_device *adev, "RETRY-RPC: setting PTE.X=3D1 for NPA:%llx remote:%u
> pte:0x%llx\n", npa_addr, remote_acc_id, pte_flags);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, true,=20
false, NULL,
> -					   npa_addr, npa_addr=20
+ size - 1,
> -					   pte_flags, 0,
> -					   adev-
>vm_manager.vram_base_offset,
> -					   bo->tbo.resource,=20
NULL,
> -					   &vm->last_update);
> +		r =3D amdgpu_vm_map_range(adev, vm, true, false, NULL,
> +					npa_addr, npa_addr +=20
size - 1,
> +					pte_flags, 0,
> +					adev-
>vm_manager.vram_base_offset,
> +					bo->tbo.resource, NULL,
> +					&vm->last_update);
>=20
>  		if (r)
>  			dev_warn(adev->dev,
> @@ -2783,10 +2783,10 @@ static void amdgpu_ualink_unmap_all_npa_addr(stru=
ct
> amdgpu_device *adev, npa_addr, exp_xa_node->handle.handle_hi,
> exp_xa_node->handle.handle_lo, remote_acc_id, pte_value);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, true,=20
false, NULL,
> -					   npa_addr, npa_addr=20
+ size - 1,
> -					   pte_value, 0, 0,=20
NULL, NULL,
> -					   &vm->last_update);
> +		r =3D amdgpu_vm_map_range(adev, vm, true, false, NULL,
> +					npa_addr, npa_addr +=20
size - 1,
> +					pte_value, 0, 0, NULL,=20
NULL,
> +					&vm->last_update);
>=20
>  		if (r)
>  			dev_err(adev->dev,
> @@ -4588,10 +4588,10 @@ static int amdgpu_ualink_npa_vm_map_range(struct
> amdgpu_device *adev, struct amd offset, size_in_pages <<
> AMDGPU_GPU_PAGE_SHIFT, pte_flags,
>  		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
>=20
> -	r =3D amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
> -				   npa_in_pages, npa_in_pages +=20
size_in_pages - 1,
> -				   pte_flags, offset, adev-
>vm_manager.vram_base_offset,
> -				   bo->tbo.resource, NULL,=20
&npa_vm->last_update);
> +	r =3D amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
> +				npa_in_pages, npa_in_pages +=20
size_in_pages - 1,
> +				pte_flags, offset, adev-
>vm_manager.vram_base_offset,
> +				bo->tbo.resource, NULL, &npa_vm-
>last_update);
>  	if (r)
>  		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA=20
VM\n", r,
>  			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
> @@ -4622,10 +4622,10 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct
> amdgpu_device *adev, struct a offset, size_in_pages <<
> AMDGPU_GPU_PAGE_SHIFT, pte_flags,
>  		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
>=20
> -	r =3D amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
> -				   npa_in_pages, npa_in_pages +=20
size_in_pages - 1,
> -				   pte_flags, offset, 0, bo-
>tbo.resource, NULL,
> -				   &npa_vm->last_update);
> +	r =3D amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
> +				npa_in_pages, npa_in_pages +=20
size_in_pages - 1,
> +				pte_flags, offset, 0, bo-
>tbo.resource, NULL,
> +				&npa_vm->last_update);
>  	if (r)
>  		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from=20
NPA VM\n", r,
>  			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 75a6f9c2a8be3..d039346fda7=
91
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1101,11 +1101,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params
> *params, }
>=20
>  /**
> - * amdgpu_vm_update_range - update a range in the vm page table
> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>   *
>   * @adev: amdgpu_device pointer to use for commands
>   * @vm: the VM to update the range
> - * @unlocked: unlocked invalidation during MM callback
>   * @flush_tlb: trigger tlb invalidation after update completed
>   * @allow_override: change MTYPE for local NUMA nodes
>   * @sync: fences we need to sync to
> @@ -1118,23 +1117,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params
> *params, * @pages_addr: DMA addresses to use for mapping
>   * @fence: optional resulting fence
>   *
> - * Fill in the page table entries between @start and @last.
> + * Fill in the page table entries between @start and @last. Allocate and
> free + * new page tables as needed. Can only be called while holding the =
VM
> lock. *
>   * Returns:
>   * 0 for success, negative erro code for failure.
>   */
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, -			   bool unlocked, bool flush_tlb, bool=20
allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t=20
offset,
> -			   uint64_t vram_base, struct ttm_resource=20
*res,
> -			   dma_addr_t *pages_addr, struct dma_fence=20
**fence)
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence=20
**fence)
>  {
>  	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>  	struct amdgpu_vm_update_params params;
>  	struct amdgpu_res_cursor cursor;
>  	int r, idx;
>=20
> +	amdgpu_vm_assert_locked(vm);
> +
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return -ENODEV;
>=20
> @@ -1159,7 +1161,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm, params.adev =3D adev;
>  	params.vm =3D vm;
>  	params.pages_addr =3D pages_addr;
> -	params.unlocked =3D unlocked;
>  	params.needs_flush =3D flush_tlb;
>  	params.override_pte =3D allow_override && adev->gmc.override_pte;
>  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1168,7 +1169,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm, if (r)
>  		goto error_free;
>=20
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>  		struct dma_fence *tmp =3D dma_fence_get_stub();
>=20
>  		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> @@ -1177,7 +1178,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm, }
>=20
>  	r =3D vm->update_funcs->prepare(&params, sync,
> -				     =20
AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +				     =20
AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>  	if (r)
>  		goto error_free;
>=20
> @@ -1255,6 +1256,82 @@ int amdgpu_vm_update_range(struct amdgpu_device
> *adev, struct amdgpu_vm *vm, return r;
>  }
>=20
> +/**
> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
> + *
> + * @adev: amdgpu_device pointer to use for commands
> + * @vm: the VM to update the range
> + * @unlocked: unlocked invalidation during MM callback
> + * @sync: fences we need to sync to
> + * @start: start of unmapped range
> + * @last: last unmapped entry
> + * @fence: optional resulting fence
> + *
> + * Fill in the page table entries between @start and @last with a fixed
> flags + * value without allocating or freeing page tables. Can be used
> without locking + * the VM.
> + *
> + * Returns:
> + * 0 for success, negative erro code for failure.
> + */
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *=
vm,
> +			  bool unlocked, struct amdgpu_sync *sync,
> +			  uint64_t start, uint64_t last,
> +			  struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_manager *vm_mgr =3D &adev->vm_manager;
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm_update_params params;
> +	uint64_t flags[AMDGPU_VM_MAX_LEVEL];

This should be AMDGPU_VM_NUM_LEVELS now.

> +	int r, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
> +
> +	tlb_cb =3D kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb) {
> +		drm_dev_exit(idx);
> +		return -ENOMEM;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev =3D adev;
> +	params.vm =3D vm;
> +	params.needs_flush =3D true;
> +	params.unlocked =3D unlocked;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> +
> +	r =3D amdgpu_vm_begin_critical(&params);
> +	if (r)
> +		goto error_end_critical;
> +
> +	r =3D vm->update_funcs->prepare(&params, sync,
> +				     =20
AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> +	if (r)
> +		goto error_free;
> +
> +	for (int level =3D AMDGPU_VM_PTB; level !=3D vm_mgr->root_level;=20
level--)
> +		flags[level] =3D amdgpu_vm_pt_clear_flags(adev, vm, level);
> +
> +	amdgpu_vm_pt_leaves(&params, start, last + 1, NULL, flags);
> +
> +	r =3D vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +	amdgpu_vm_pt_free_list(adev, &params);
> +	tlb_cb =3D NULL;
> +
> +error_free:
> +	kfree(tlb_cb);
> +
> +error_end_critical:
> +	amdgpu_vm_end_critical(&params);
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
>  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>  			  struct amdgpu_mem_stats=20
stats[__AMDGPU_PL_NUM])
>  {
> @@ -1383,11 +1460,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v,
> struct amdgpu_bo_va *bo_va,
>=20
>  		trace_amdgpu_vm_bo_update(mapping);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, flush_tlb,
> -					   !uncached, &sync,=20
mapping->start,
> -					   mapping->last,=20
update_flags,
> -					   mapping->offset,=20
vram_base, mem,
> -					   pages_addr,=20
last_update);
> +		r =3D amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached,=20
&sync,
> +					mapping->start,=20
mapping->last,
> +					update_flags, mapping-
>offset,
> +					vram_base, mem,=20
pages_addr,
> +					last_update);
>  		if (r)
>  			goto error_free;
>  	}
> @@ -1594,9 +1671,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *ade=
v,
>  			struct amdgpu_bo_va_mapping, list);
>  		list_del(&mapping->list);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, true,=20
false,
> -					   &sync, mapping-
>start, mapping->last,
> -					   0, 0, 0, NULL,=20
NULL, &f);
> +		r =3D amdgpu_vm_map_range(adev, vm, true, false,
> +					&sync, mapping->start,=20
mapping->last,
> +					0, 0, 0, NULL, NULL,=20
&f);
>  		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  		if (r) {
>  			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index d84e0a3ff88d4..2a6424f4a66=
42
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -464,12 +464,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device
> *adev, uint32_t xcc_mask);
>  void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  			    struct amdgpu_vm *vm, struct amdgpu_bo=20
*bo);
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, -			   bool unlocked, bool flush_tlb, bool=20
allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t=20
offset,
> -			   uint64_t vram_base, struct ttm_resource=20
*res,
> -			   dma_addr_t *pages_addr, struct dma_fence=20
**fence);
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence=20
**fence);
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *=
vm,
> +			  bool unlocked, struct amdgpu_sync *sync,
> +			  uint64_t start, uint64_t last,
> +			  struct dma_fence **fence);
>  int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>  			struct amdgpu_bo_va *bo_va,
>  			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h index
> 89fdeff0575ef..db748e8b3bf38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -115,6 +115,9 @@ struct amdgpu_vm_update_funcs {
>  		      struct dma_fence **fence);
>  };
>=20
> +uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  unsigned int level);
>  int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		       struct amdgpu_bo_vm *vmbo);
>  int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> 3b262b0d186a5..d7134fd5d7d45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -347,9 +347,9 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
> *adev, (entry) =3D (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor=
)))
>=20
>  /* Return the flags used for cleared PDEs/PTES */
> -static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> -					struct amdgpu_vm *vm,
> -					unsigned int level)
> +uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  unsigned int level)
>  {
>  	uint64_t flags;
>=20
> @@ -590,7 +590,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *ade=
v,
>  			    struct amdgpu_vm_update_params *params)
>  {
>  	struct amdgpu_vm_bo_base *entry, *next;
> -	bool unlocked =3D params->unlocked;
>=20
>  	if (list_empty(&params->tlb_flush_waitlist))
>  		return;
> @@ -598,7 +597,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *ade=
v,
>  	/*
>  	 * unlocked unmap clear page table leaves, warning to free the=20
page entry.
> */
> -	WARN_ON(unlocked);
> +	WARN_ON(params->unlocked);
>=20
>  	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist,
> vm_status) amdgpu_vm_pt_free(entry);
> @@ -830,23 +829,17 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params, uint64_t incr, entry_end, pe_start;
>  		struct amdgpu_bo *pt;
>=20
> -		if (!params->unlocked) {
> -			/* make sure that the page tables covering=20
the
> -			 * address range are actually allocated
> -			 */
> -			r =3D amdgpu_vm_pt_alloc(params, &cursor);
> -			if (r)
> -				return r;
> -		}
> +		/* make sure that the page tables covering the
> +		 * address range are actually allocated
> +		 */
> +		r =3D amdgpu_vm_pt_alloc(params, &cursor);
> +		if (r)
> +			return r;
>=20
>  		shift =3D amdgpu_vm_pt_level_shift(adev, cursor.level);
>  		parent_shift =3D amdgpu_vm_pt_level_shift(adev,=20
cursor.level - 1);
> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the=20
leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>  			/* No huge page support before GMC v9 */
>  			if (cursor.level !=3D AMDGPU_VM_PTB) {
>  				if (!
amdgpu_vm_pt_descendant(adev, &cursor))
> @@ -892,14 +885,7 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params, mask =3D amdgpu_vm_pt_entries_mask(adev,
> cursor.level);
>  		pe_start =3D ((cursor.pfn >> shift) & mask) * 8;
>=20
> -		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> -			/*
> -			 * MMU notifier callback unlocked unmap huge=20
page, leave is PDE entry,
> -			 * only clear one entry. Next entry search=20
again for PDE or PTE leave.
> -			 */
> -			entry_end =3D 1ULL << shift;
> -		else
> -			entry_end =3D ((uint64_t)mask + 1) << shift;
> +		entry_end =3D ((uint64_t)mask + 1) << shift;
>  		entry_end +=3D cursor.pfn & ~(entry_end - 1);
>  		entry_end =3D min(entry_end, end);
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c index af8d2ede183a1..263e68d29360d
> 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1396,7 +1396,6 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, uint64_t start, uint64_t last,
>  			 struct dma_fence **fence)
>  {
> -	uint64_t init_pte_value =3D adev->gmc.init_pte_flags;
>  	uint64_t gpu_start, gpu_end;
>=20
>  	/* Convert CPU page range to GPU page range */
> @@ -1411,9 +1410,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, return -EINVAL;
>  	}
>=20
> -	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL,
> gpu_start, -				      gpu_end,=20
init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +	return amdgpu_vm_unmap_range(adev, vm, true, NULL, gpu_start,=20
gpu_end,
> +				     fence);
>  }
>=20
>  static int
> @@ -1523,12 +1521,11 @@ svm_range_map_to_gpu(struct kfd_process_device *p=
dd,
> struct svm_range *prange, (last_domain =3D=3D SVM_RANGE_VRAM_DOMAIN) ? 1 =
: 0,
>  			 pte_flags);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, flush_tlb,=20
true,
> -					   NULL, gpu_start,=20
gpu_end,
> -					   pte_flags,
> -					   (last_start -=20
prange->start) << PAGE_SHIFT,
> -					   bo_adev ? bo_adev-
>vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr,=20
&vm->last_update);
> +		r =3D amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
> +					gpu_start, gpu_end,=20
pte_flags,
> +					(last_start - prange-
>start) << PAGE_SHIFT,
> +					bo_adev ? bo_adev-
>vm_manager.vram_base_offset : 0,
> +					NULL, dma_addr, &vm-
>last_update);
>=20
>  		for (j =3D last_start - prange->start; j <=3D i; j++)
>  			dma_addr[j] |=3D last_domain;



