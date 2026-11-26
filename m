Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D27606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6oT3jhw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D06F10E6F0;
	Thu, 26 Nov 2026 15:14:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488F610E6F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 15:14:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6271960E87;
 Thu, 26 Nov 2026 15:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB41B1F000C4;
 Thu, 26 Nov 2026 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795706090;
 bh=y5p9FJA7huZNI8OTCEP69wpO6J0CuCJvSdyw1F6QtHc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=m6oT3jhwawnAaT4IDc93s4wRY1vlbGvEZXcLTXcTxRjbnSeqq6QCKpCkCGTmhot8h
 rcdfNLGB1/CBJMxhqKNLFpjgDsoR2Q6H3ogqTqTqATuvAVQ3sk11dfLl0pUnlI8niB
 JJy0F/KHLiIFr4JmHeqMTDjOLsmyzZh0stQ4hryHqHuhb2npouibVjfVZPjDVKTElv
 /ZcXzVo5t/dsaMqD+I1MUoLumGWg56JvVhH/xE0z+zvLaPXYUtEKUbH1FJUS204oGT
 w9hDstlEFs7KIIXfS2iO8UE1Ftj2wjv5txpnZuA/zW85X4a9UuUN7kInPdBDFvr1RG
 ZK3uPo/Q4NWAg==
Message-ID: <sashiko-outbox-235786@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM clearing after GPU reset
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126144240.598627-1-Arunpravin.PaneerSelvam@amd.com>
References: <20261126144240.598627-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 15:14:50 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amdgpu: map and copy jobs on TTM entities skipped after
  reset
- [High] drm/amdgpu: unwiped VRAM blocks freed as cleared in
  amdgpu_vram_mgr_del()
- [Low] drm/amdgpu: missing mgr->vram_lost_counter sync in
  amdgpu_vram_mgr_del()
- [Low] drm/amdgpu: missing Fixes trailer for commit a68c7eaa7a8f
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/amdgpu: NULL pointer dereference and job leak in
  amdgpu_ttm_prepare_job() [1]
--

commit 644d53e55a5fbf61b0bce43757d1045f37e6f6c6
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

> drm/amdgpu: Fix VRAM clearing after GPU reset
>
> After a VRAM lost reset, freed VRAM can be handed out with old data:
>
> 1. Clear jobs inherit the error of a job cancelled by the reset and are
>    skipped. Let clear jobs ignore the entity error.
> 2. Free blocks marked as cleared before the reset are not clear anymore.
>    Reset their cleared state when the VRAM lost counter changes.
> 3. Blocks whose wipe was queued before the reset are freed as cleared,
>    but the wipe may have been dropped. Don't mark them as cleared then.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6141
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

[Severity: Low]
This fixes a bug in the VRAM clear-on-release tracking.  Should it include:

  Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index d3a875a32af1e..703c0952776e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

[ ... ]

> @@ -2639,6 +2641,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device=
 *adev,
>  	if (r)
>  		return r;
> =20
> +	job->ignore_entity_error =3D true;
> +
>  	for (i =3D 0; i < num_loops; i++) {
>  		uint32_t cur_size =3D min(byte_count, max_bytes);

[Severity: High]
This problem wasn't introduced by this patch, but amdgpu_ttm_prepare_job()
leaves its output job pointer in an inconsistent state on failure [1],
which can cause a NULL pointer dereference in amdgpu_copy_buffer() or leak
job in amdgpu_ttm_fill_mem():

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:amdgpu_ttm_prepare_job() {
	...
	r =3D amdgpu_job_alloc_with_ib(adev, &entity->base,
				     AMDGPU_FENCE_OWNER_UNDEFINED,
				     num_dw * 4, pool, k_job_id, job);
	if (r)
		return r;
	...
	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
						   DMA_RESV_USAGE_BOOKKEEP);
}

When amdgpu_job_alloc_with_ib() fails, *job is NULL, and amdgpu_copy_buffer=
()
jumps to error_free and passes NULL to amdgpu_job_free(), dereferencing
job->base.entity.  When drm_sched_job_add_resv_dependencies() fails after
amdgpu_job_alloc_with_ib() succeeds, amdgpu_ttm_fill_mem() returns r without
calling amdgpu_job_free(job), leaking the allocated job and its IB.

[Severity: High]
Should GART mapping jobs in amdgpu_ttm_map_buffer() and buffer copy jobs in
amdgpu_copy_buffer() also set job->ignore_entity_error =3D true?

The TTM scheduler entities (move_entities and clear_entities) persist across
GPU resets because amdgpu_ttm_disable_buffer_funcs() and
amdgpu_ttm_enable_buffer_funcs() return early when amdgpu_in_reset(adev) is
true.  If a reset cancels any job on move_entities[e], that entity's
last_scheduled fence remains at -ECANCELED.

In a later amdgpu_move_blit() on that entity for a BO with
AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE, the map and copy jobs submitted by
amdgpu_ttm_copy_mem_to_mem() have ignore_entity_error =3D=3D false and are
aborted by amdgpu_job_prepare_job(), whereas the trailing wipe job from
amdgpu_ttm_fill_mem() ignores the entity error and zeroes old_mem in VRAM
before its contents were copied to new_mem.  Similarly, in
amdgpu_ttm_clear_buffer(), any GART window mapping job submitted by
amdgpu_ttm_map_buffer() is skipped while amdgpu_ttm_fill_mem() runs against
a stale GART window.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 249f07f309515..ef4c7b4384061 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -456,7 +456,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_ma=
nager *man,
>  	struct gpu_buddy *mm =3D &mgr->mm;
>  	struct gpu_buddy_block *block;
>  	unsigned long pages_per_block;
> -	int r;
> +	int vram_lost, r;
> =20
>  	lpfn =3D (u64)place->lpfn << PAGE_SHIFT;
>  	if (!lpfn || lpfn > man->size)
> @@ -523,6 +523,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_m=
anager *man,
>  	}
> =20
>  	mutex_lock(&mgr->lock);
> +
> +	vram_lost =3D atomic_read(&adev->vram_lost_counter);
> +	if (unlikely(mgr->vram_lost_counter !=3D vram_lost)) {
> +		gpu_buddy_reset_clear(mm, false);
> +		mgr->vram_lost_counter =3D vram_lost;
> +	}
> +
>  	while (remaining_size) {
>  		if (tbo->page_alignment)
>  			min_block_size =3D (u64)tbo->page_alignment << PAGE_SHIFT;
> @@ -652,6 +659,11 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_=
manager *man,
>  	list_for_each_entry(block, &vres->blocks, link)
>  		vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> =20
> +	if ((vres->flags & GPU_BUDDY_CLEARED) &&
> +	    vres->clear_vram_lost_counter !=3D atomic_read(&adev->vram_lost_cou=
nter)) {
> +		vres->flags &=3D ~GPU_BUDDY_CLEARED;
> +	}
> +
>  	gpu_buddy_free_list(mm, &vres->blocks, vres->flags);
>  	amdgpu_vram_mgr_do_reserve(man);
>  	mutex_unlock(&mgr->lock);

[Severity: High]
Can amdgpu_vram_mgr_del() still free unwiped blocks as GPU_BUDDY_CLEARED
when a GPU reset aborts an in-flight wipe job?

Comparing vres->clear_vram_lost_counter against adev->vram_lost_counter in
amdgpu_vram_mgr_del() misses three cases where the counters still match even
though the wipe job never ran:

1. In amdgpu_move_blit(), when evict is true on a non-kernel BO,
   ttm_bo_move_accel_cleanup() calls ttm_bo_move_pipeline_evict(), which
   frees old_mem via amdgpu_vram_mgr_del() synchronously right after queuing
   wipe_fence.  At that point adev->vram_lost_counter has not changed yet,
   so the blocks are returned to gpu_buddy with GPU_BUDDY_CLEARED before the
   wipe job runs on the hardware.
2. During a VRAM-lost reset, amdgpu_device_pre_asic_reset() calls
   amdgpu_fence_driver_force_completion() to signal in-flight SDMA fences
   with -ECANCELED before the ASIC reset runs, whereas amdgpu_inc_vram_lost=
()
   is only called later in amdgpu_device_reinit_after_reset().  Force-
   completing the wipe fence immediately schedules ttm_bo_delayed_delete()
   to run amdgpu_vram_mgr_del() while adev->vram_lost_counter still matches
   vres->clear_vram_lost_counter:

CPU0 (reset)                      CPU1 (bdev->wq)
amdgpu_device_pre_asic_reset()
  amdgpu_fence_driver_force_completion()
    /* signals wipe fence (-ECANCELED) */
                                  ttm_bo_delayed_delete()
                                    ...
                                    amdgpu_vram_mgr_del()
                                      /* vram_lost_counter unchanged */
                                      gpu_buddy_free_list(...,
                                        GPU_BUDDY_CLEARED)
amdgpu_do_asic_reset()
  amdgpu_device_reinit_after_reset()
    amdgpu_inc_vram_lost()

3. On a GPU reset where VRAM is not lost (such as Mode 2 reset on APUs),
   amdgpu_device_pre_asic_reset() still force-completes in-flight wipe fenc=
es
   with -ECANCELED, but amdgpu_inc_vram_lost() is never called.

In each case, the unwiped blocks are marked clear in gpu_buddy and can be
handed out to later AMDGPU_GEM_CREATE_VRAM_CLEARED allocations with stale
data.

[Severity: Low]
Should amdgpu_vram_mgr_del() also synchronize mgr->vram_lost_counter and run
gpu_buddy_reset_clear(mm, false) before calling gpu_buddy_free_list()?

If a BO is released and wiped after a VRAM-lost reset completes, but before
the next amdgpu_vram_mgr_new() call, amdgpu_vram_mgr_del() frees those
Freshly wiped blocks into mm as cleared while mgr->vram_lost_counter still
holds the pre-reset value.  The first subsequent amdgpu_vram_mgr_new() then
sees mgr->vram_lost_counter !=3D vram_lost and calls
gpu_buddy_reset_clear(mm, false), marking those post-reset cleared blocks
dirty again.

[1] https://sashiko.dev/#/bug/linux-1b68b982-50e9-427b-a5c7-1a7c0cf5aa51

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126144240.5986=
27-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
