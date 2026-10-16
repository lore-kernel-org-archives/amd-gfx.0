Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82BBCCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A62D10E266;
	Fri, 16 Oct 2026 08:23:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E00A10E266
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 08:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=bTi3NCkNmtgSBjqdU27FjPOLAR+gdnaDOsvZlBQ6V50=; b=LuH90geFSjxkBw6ZvhiqexCKUl
 KtZxzWAW5ZTi4l91rflXpdTjq+xAkmr+JRTrH2B3yEwAKMRi5is/6IVrAeuv9zXYW4vy+fMah2VY6
 73Rhr+ybsd2IvHgYsY1eVCwdzZU5dSZEWzId2dq1EpM9rohpUtW+/m6WWx+AzTmLugHsFxDVgKF2l
 gNfNTaznozoDUgsq9Z688O+NcEAahGiRrCgYfEx3qIcw8QoFXGl/Gu5N6lI3OWhabMr23qELhC6gz
 b2MOQe60sZ6heoQ2W/kFWoMIAZaurLIWK3yVg/KLWl7Ackq6EvRcdbuGmkgX/frhEJ8ZKNMnute4T
 Yzcw06xA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHdDU-000wpL-Jq; Fri, 16 Oct 2026 10:23:04 +0200
Message-ID: <d6a743a1-7268-4167-9378-a364b6c04fbb@igalia.com>
Date: Fri, 16 Oct 2026 09:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on
 failed probe
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: phasta@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com
References: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 15/10/2026 20:30, Olivier Kaloudoff wrote:
> Since commit 037b98a2312e ("drm/amdgpu: move UVD and VCE sched entity
> init after sched init"), drm_sched_entity_init() for the VCE and UVD
> kernel entities runs in the scheduler-init phase, well after the
> IP-block sw_init phase has allocated the vcpu_bos.
> 
> If probe fails between the two phases, amdgpu_device_fini_sw() still
> runs the per-IP sw_fini callbacks for blocks that did complete
> sw_init. Both amdgpu_vce_sw_fini() and amdgpu_uvd_sw_fini() then call
> drm_sched_entity_destroy() on an entity that was never initialized:
> entity->rq is NULL and drm_sched_entity_flush() dereferences it,
> oopsing in whatever context drove the failed probe.
> 
> The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
> Remove redundant entity->rq initialization and checks") removed the
> if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
> Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
> grounds that entity->rq can never be NULL. That holds only for
> entities that completed drm_sched_entity_init() — not for the
> never-initialized entity this teardown path reaches.
> 
> Observed on real hardware: MI50 (Vega20, VCE 4.0 / UVD 7.2) behind a
> Thunderbolt link — a pciehp presence/link-change event re-probes the
> device; when the re-probe fails (-EINVAL here), the cleanup path
> NULL-derefs inside drm_sched_entity_flush() in the pciehp IRQ thread
> and takes the whole machine down (panic_on_oops, EFI pstore capture).
> Reproduced twice on 7.3-rc5, 2026-10-06 and 2026-10-09, identical
> signature; the faulting instruction is `mov (%rax),%r15` on rax =
> entity->rq == NULL, i.e. `sched = entity->rq->sched`:
> 
>    BUG: kernel NULL pointer dereference
>    RIP: drm_sched_entity_flush+0x34/0x2d0 [gpu_sched]
>    drm_sched_entity_destroy
>    amdgpu_vce_sw_fini
>    vce_v4_0_sw_fini
>    amdgpu_device_fini_sw
>    ...
>    pciehp_configure_device
>    pciehp_handle_presence_or_link_change
> 
> Guard the entity teardown on entity->rq, which is set only by
> drm_sched_entity_init(). amdgpu_ring_fini() already self-guards via
> the rings[] registration, and the vcpu_bo/firmware cleanup still runs
> as before.
> 
> v2: retarget Fixes: at commit 2df5efb45425 ("drm/sched: Remove
> redundant entity->rq initialization and checks") — the !entity->rq
> check from commit 1decbf6bb0b4 ("drm/sched: Fix entities with 0
> rqs.") that Alex pointed to was removed by it in the 7.3 window,
> so this is a regression there, not a pre-existing hole.
> 
> Fixes: 2df5efb45425 ("drm/sched: Remove redundant entity->rq initialization and checks")
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index ecd7caa95..cd35ff7ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -377,7 +377,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
>   	int i, j;
>   
> -	drm_sched_entity_destroy(&adev->uvd.entity);
> +	if (adev->uvd.entity.rq)
> +		drm_sched_entity_destroy(&adev->uvd.entity);
>   
>   	for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
>   		if (adev->uvd.harvest_config & (1 << j))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1f7a98cdc..3952af9ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>   	if (adev->vce.vcpu_bo == NULL)
>   		return 0;
>   
> -	drm_sched_entity_destroy(&adev->vce.entity);
> +	if (adev->vce.entity.rq)
> +		drm_sched_entity_destroy(&adev->vce.entity);
>   
>   	for (i = 0; i < adev->vce.num_rings; i++)
>   		amdgpu_ring_fini(&adev->vce.ring[i]);

Dang, it looks like currently the ownership of entity initialization is 
broken between the IP agnostic phase which does the init, and per-IP 
phase which tears it down.

The fix will get in the way of me re-trying to embed the run-queue into 
the scheduler but it does look correct.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I will see if I can re-work the init/cleanup phases so this can be 
removed, or if not, try to add a proper DRM scheduler API to query the 
status of an entity.

For now lets merge the fixup.

Regards,

Tvrtko

