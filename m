Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D603CD98D5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B264210F2AA;
	Fri, 12 Jun 2026 06:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AD2ut/VJ";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB5B10F2A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:58:05 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so1092831f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781247484; x=1781852284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnEA8fW7RXqhuxuJmXLInNZuiCnfjLI2aPXC346h8ZM=;
 b=AD2ut/VJZgPJ36go4/vNjlcUlgrEIT2cNiglE1pIfCWDl0VUK+Oo0DbboCx4SECBXB
 WgtqO5Boh7vd10+RH/jul70XGrt4D7LJZ146F1kUnXelrlaUOz7SyanqMIfmfqrmeWuD
 qTFqekjJd7N+4Wbt9HaKamlUeELrsM8bUJLFndMW4n0Wr+linrALSr3+ZCKRywldsRUp
 gQZ8PFQGenQ1k/QCNULYzLBmSUEm8f3NsaQptVE4VoEGFfjy18jALUHLbSDMlschAYyl
 Q3iyzH+jG3YHwqYPG4OGIwz6cYqUZCjejh2VCFB4TWtBeuRvo8dF+Z5GokgDWk1Z+eBj
 +Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781247484; x=1781852284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnEA8fW7RXqhuxuJmXLInNZuiCnfjLI2aPXC346h8ZM=;
 b=mvIEvyhzCEVIMXazhBCL6dF9h3gSI8h+qadYG0Jyj7n/PwVdiuWSuadxUTA+q6908c
 p3PbK3i+2vsIVTNU4XONQ0nXWxJYCc9SGbGs7lr9m7DQaOMlUpxy9ArA/8M1Lh6HWjyQ
 BfNgxnOrFpEh8H0s/Hlq+qj8X7811EnyWB+2dvUxR6ZT4j20QmBsyhlbWirJH4SJapkf
 XrsrgDfb0FQ6ENbbamgnk9oOcvb1EAGEeZdNzWfp+ZQ7YcCe6A5ZimA2yml51Z0rKLrl
 tpKcs9JQPOccXJs+ihmgiHHs2SLpMxU8Q9O9UyRQLz0tO2wf1S2HfIhll4BWHxivc2Ns
 HTcA==
X-Gm-Message-State: AOJu0YyWJoCU1O0sebTBQVn7VVrV+vKP2lhRP60AVbWK3u2HeHh/vSdx
 WunewMgJjec9uqOKZxtWcpEeRrIAaWk1+e2Yrc9FDjnZb7nTpl4Vlq4G
X-Gm-Gg: Acq92OH7pnlXAScSpUEcqwuJq0D16IsuYr/MbOdQsrJIDamGQN17DqzbXCDFqB2fKx0
 ThXybq1gkMDDVJ/BVTpJ6B1bq9xKGSbRZnszRy61ULGRb7Ysbt7dm4MqzlXXJwS6Uee3UMVRuE4
 yCej56HyueTPTN9OG8jrYh3A9a/TPPi+4/WevtKC6gdwcP4cHKuHSdTOcdOU+e2ro+/N9ks/2ur
 6zCjUH60icIOD0TcOA3kdyMiwBTIv0I0OAPy1PW1MRmF3hHJAmqLZCIjZhpohPTVn1j4LxRG/P7
 xIplcXlsnPceT3DI62t5pVCzz3GjCbIqdDqfApRMwr2xuNJXzTwNLFRilsmJwP874BYgNwrw5Wg
 2LytKrrDzIpVilABIeBWurQB5QSMh3gyi2m3CeGPsDwDhdoy9/xqS9Ym3eyXBPy/3JQtdu199ef
 IE8+/KEMIqM+d0v/g2N4bZyfkec29Rgm2c0SFx7yF00jFh/hzRzUWZoTu1N/a16nZ/Pf8pj3E6l
 t3IHzl9BfmAtErfA3iEnKeaDunjww==
X-Received: by 2002:a05:6000:2488:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-4606cb2a8f0mr2103195f8f.10.1781247484226; 
 Thu, 11 Jun 2026 23:58:04 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3fcfsm2880010f8f.26.2026.06.11.23.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:58:03 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 07/13] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_range
Date: Fri, 12 Jun 2026 08:58:03 +0200
Message-ID: <3617393.sQuhbGJ8Bu@timur-max>
In-Reply-To: <20260529114031.3714-8-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-8-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:09 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> That case is handled by amdgpu_vm_update_leaves now.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

This commit seems to be doing more than suggested by the (very short) commi=
t=20
message. It removes immediate updates not only from amdgpu_vm_update_range(=
)=20
but also amdgpu_vm_pt_clear() and amdgpu_vm_pt_create().

Otherwise the code looks good.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 21 +++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 16 +++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 19 ++++++-------------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  4 ++--
>  4 files changed, 24 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 94632a660b79..edc8b1ca2d3e
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1084,7 +1084,6 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params
> *params, *
>   * @adev: amdgpu_device pointer to use for commands
>   * @vm: the VM to update the range
> - * @immediate: immediate submission in a page fault
>   * @unlocked: unlocked invalidation during MM callback
>   * @flush_tlb: trigger tlb invalidation after update completed
>   * @allow_override: change MTYPE for local NUMA nodes
> @@ -1104,12 +1103,11 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params
> *params, * 0 for success, negative erro code for failure.
>   */
>  int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, -			   bool immediate, bool unlocked, bool=20
flush_tlb,
> -			   bool allow_override, struct amdgpu_sync=20
*sync,
> -			   uint64_t start, uint64_t last, uint64_t=20
flags,
> -			   uint64_t offset, uint64_t vram_base,
> -			   struct ttm_resource *res, dma_addr_t=20
*pages_addr,
> -			   struct dma_fence **fence)
> +			   bool unlocked, bool flush_tlb, bool=20
allow_override,
> +			   struct amdgpu_sync *sync, uint64_t start,
> +			   uint64_t last, uint64_t flags, uint64_t=20
offset,
> +			   uint64_t vram_base, struct ttm_resource=20
*res,
> +			   dma_addr_t *pages_addr, struct dma_fence=20
**fence)
>  {
>  	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>  	struct amdgpu_vm_update_params params;
> @@ -1139,7 +1137,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm, memset(&params, 0, sizeof(params));
>  	params.adev =3D adev;
>  	params.vm =3D vm;
> -	params.immediate =3D immediate;
>  	params.pages_addr =3D pages_addr;
>  	params.unlocked =3D unlocked;
>  	params.needs_flush =3D flush_tlb;
> @@ -1365,7 +1362,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
> struct amdgpu_bo_va *bo_va,
>=20
>  		trace_amdgpu_vm_bo_update(mapping);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, false,=20
flush_tlb,
> +		r =3D amdgpu_vm_update_range(adev, vm, false, flush_tlb,
>  					   !uncached, &sync,=20
mapping->start,
>  					   mapping->last,=20
update_flags,
>  					   mapping->offset,=20
vram_base, mem,
> @@ -1568,7 +1565,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *ade=
v,
>  			struct amdgpu_bo_va_mapping, list);
>  		list_del(&mapping->list);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, false,=20
true, false,
> +		r =3D amdgpu_vm_update_range(adev, vm, false, true, false,
>  					   &sync, mapping-
>start, mapping->last,
>  					   0, 0, 0, NULL,=20
NULL, &f);
>  		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> @@ -2617,7 +2614,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct
> amdgpu_vm *vm, vm->tlb_fence_context =3D dma_fence_context_alloc(1);
>=20
>  	r =3D amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
> -				false, &root, xcp_id);
> +				&root, xcp_id);
>  	if (r)
>  		goto error_free_delayed;
>=20
> @@ -2633,7 +2630,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct
> amdgpu_vm *vm, if (r)
>  		goto error_free_root;
>=20
> -	r =3D amdgpu_vm_pt_clear(adev, vm, root, false);
> +	r =3D amdgpu_vm_pt_clear(adev, vm, root);
>  	if (r)
>  		goto error_free_root;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index 04b32accfa3f..3e86a2a470f0
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -530,12 +530,11 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device
> *adev, void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  			    struct amdgpu_vm *vm, struct amdgpu_bo=20
*bo);
>  int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, -			   bool immediate, bool unlocked, bool=20
flush_tlb,
> -			   bool allow_override, struct amdgpu_sync=20
*sync,
> -			   uint64_t start, uint64_t last, uint64_t=20
flags,
> -			   uint64_t offset, uint64_t vram_base,
> -			   struct ttm_resource *res, dma_addr_t=20
*pages_addr,
> -			   struct dma_fence **fence);
> +			   bool unlocked, bool flush_tlb, bool=20
allow_override,
> +			   struct amdgpu_sync *sync, uint64_t start,
> +			   uint64_t last, uint64_t flags, uint64_t=20
offset,
> +			   uint64_t vram_base, struct ttm_resource=20
*res,
> +			   dma_addr_t *pages_addr, struct dma_fence=20
**fence);
>  int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>  			struct amdgpu_bo_va *bo_va,
>  			bool clear);
> @@ -602,10 +601,9 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>  			  struct amdgpu_mem_stats=20
stats[__AMDGPU_PL_NUM]);
>=20
>  int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		       struct amdgpu_bo_vm *vmbo, bool immediate);
> +		       struct amdgpu_bo_vm *vmbo);
>  int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			int level, bool immediate, struct=20
amdgpu_bo_vm **vmbo,
> -			int32_t xcp_id);
> +			int level, struct amdgpu_bo_vm **vmbo,=20
int32_t xcp_id);
>  void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm
> *vm);
>=20
>  int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> 9766b6b9aecc..6f5415d5a1bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -351,7 +351,6 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
> *adev, * @adev: amdgpu_device pointer
>   * @vm: VM to clear BO from
>   * @vmbo: BO to clear
> - * @immediate: use an immediate update
>   *
>   * Root PD needs to be reserved when calling this.
>   *
> @@ -359,7 +358,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
> *adev, * 0 on success, errno otherwise.
>   */
>  int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		       struct amdgpu_bo_vm *vmbo, bool immediate)
> +		       struct amdgpu_bo_vm *vmbo)
>  {
>  	unsigned int level =3D adev->vm_manager.root_level;
>  	struct ttm_operation_ctx ctx =3D { true, false };
> @@ -396,7 +395,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, memset(&params, 0, sizeof(params));
>  	params.adev =3D adev;
>  	params.vm =3D vm;
> -	params.immediate =3D immediate;
>=20
>  	r =3D vm->update_funcs->prepare(&params, NULL,
>  				     =20
AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
> @@ -434,13 +432,11 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, * @adev: amdgpu_device pointer
>   * @vm: requesting vm
>   * @level: the page table level
> - * @immediate: use a immediate update
>   * @vmbo: pointer to the buffer object pointer
>   * @xcp_id: GPU partition id
>   */
>  int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			int level, bool immediate, struct=20
amdgpu_bo_vm **vmbo,
> -			int32_t xcp_id)
> +			int level, struct amdgpu_bo_vm **vmbo,=20
int32_t xcp_id)
>  {
>  	struct amdgpu_bo_param bp;
>  	unsigned int num_entries;
> @@ -470,7 +466,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, bp.flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>=20
>  	bp.type =3D ttm_bo_type_kernel;
> -	bp.no_wait_gpu =3D immediate;
>  	bp.xcp_id_plus1 =3D xcp_id + 1;
>=20
>  	if (vm->root.bo)
> @@ -485,7 +480,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, * @adev: amdgpu_device pointer
>   * @vm: VM to allocate page tables for
>   * @cursor: Which page table to allocate
> - * @immediate: use an immediate update
>   *
>   * Make sure a specific page table or directory is allocated.
>   *
> @@ -495,8 +489,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, */
>  static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>  			      struct amdgpu_vm *vm,
> -			      struct amdgpu_vm_pt_cursor *cursor,
> -			      bool immediate)
> +			      struct amdgpu_vm_pt_cursor *cursor)
>  {
>  	struct amdgpu_vm_bo_base *entry =3D cursor->entry;
>  	struct amdgpu_bo *pt_bo;
> @@ -507,7 +500,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device
> *adev, return 0;
>=20
>  	amdgpu_vm_eviction_unlock(vm);
> -	r =3D amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
> +	r =3D amdgpu_vm_pt_create(adev, vm, cursor->level, &pt,
>  				vm->root.bo->xcp_id);
>  	amdgpu_vm_eviction_lock(vm);
>  	if (r)
> @@ -519,7 +512,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device
> *adev, pt_bo =3D &pt->bo;
>  	pt_bo->parent =3D amdgpu_bo_ref(cursor->parent->bo);
>  	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> -	r =3D amdgpu_vm_pt_clear(adev, vm, pt, immediate);
> +	r =3D amdgpu_vm_pt_clear(adev, vm, pt);
>  	if (r)
>  		goto error_free_pt;
>=20
> @@ -813,7 +806,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params, * address range are actually allocated
>  			 */
>  			r =3D amdgpu_vm_pt_alloc(params->adev, params-
>vm,
> -					       &cursor,=20
params->immediate);
> +					       &cursor);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c index 72cfb4a6ab3e..37b5166e9a14
> 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1372,7 +1372,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, return -EINVAL;
>  	}
>=20
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, false,=20
NULL,
> gpu_start, +	return amdgpu_vm_update_range(adev, vm, true, true,=20
false,
> NULL, gpu_start, gpu_end, init_pte_value, 0, 0, NULL, NULL,
>  				      fence);
>  }
> @@ -1489,7 +1489,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd,
> struct svm_range *prange, (last_domain =3D=3D SVM_RANGE_VRAM_DOMAIN) ? 1 =
: 0,
>  			 pte_flags);
>=20
> -		r =3D amdgpu_vm_update_range(adev, vm, false, false,=20
flush_tlb, true,
> +		r =3D amdgpu_vm_update_range(adev, vm, false, flush_tlb,=20
true,
>  					   NULL, gpu_start,=20
gpu_end,
>  					   pte_flags,
>  					   (last_start -=20
prange->start) << PAGE_SHIFT,




