Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F219C369AA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE02010E2AF;
	Thu, 10 Apr 2025 13:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="Fb8ctfzS";
	dkim-atps=neutral
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
 by gabe.freedesktop.org (Postfix) with ESMTP id D381810E172
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
 t=1744224353; bh=f9a1XqQLDNh1vEwIwEt4W9XxbqqlXzCj/L9/JkkY6t0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fb8ctfzScQvlZ4qK3VjMPQNuQSiNVvzlMa6xXuD085pKsMYcrYepYNgLrY4dl9rEz
 uRvRCCyv8bPCtN1lyIPDYg9SWw9Dn21+iY3zkXV4a8JNCpjppYSdSPKJPkD3LqDJT4
 NW5OqhGXN5jc/ZdqdRx58Dw81eE1WQaPze59f8kDykkgaCbJoIf1LN865c4Gz9I/F2
 0xU8Uoj6fAcrdees8NU2dxzubGysJnfhVjJ7W/jnfS70Vl1yd6CmJ7drY8IN7SMPMx
 BtTRLZiriLsEWkRbrNJz5nVtKB0pX22mAw95KJIoXDud1Ll6E0EgVWXwoEFsE+cs3/
 GqVPX4eh6u21nRjKOEpBmkYGytASF6XlxnmQ9OtEdsW0M6EHN0upIJBXUj0seBLzd/
 9Xskika8yI1EhekIt6G0KoajVXiQAIaxR2iRFkXKeO7oe7cne5HVN6/TVCznGJMsGC
 ax+EsrrZ1lUgK5qIaGuKqXCGz3j/MjAbu6OHeaqAKEl1srkshE5+z5zCZ9hjdzEwML
 X9KGBAwdgkxq0U/qtG3poSZpZ8olGSyq/NV0y9hHysx6pcdr0PzG1qhdRMLqW4rf6Y
 gnP0HwZ6DOPVRP/EjxRSXlsWFrYpPF+STdYP8p2tbmd0pZ0kuvaDB4kJWydHlJb9WD
 FQ8N8UwQ2dRqfWYMZlcphco0=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl
 [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
 by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 2EC7F160180;
 Wed,  9 Apr 2025 20:45:53 +0200 (CEST)
Message-ID: <3c3a0b28-831e-4c8a-8904-cee96c021d23@ijzerbout.nl>
Date: Wed, 9 Apr 2025 20:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/09] drm/amdgpu: Few optimization and fixes for userq
 fence driver
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
 <20240930115906.191060-6-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20240930115906.191060-6-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:31 +0000
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

Op 30-09-2024 om 13:59 schreef Arunpravin Paneer Selvam:
> Few optimization and fixes for userq fence driver.
>
> v1:(Christian):
>    - Remove unnecessary comments.
>    - In drm_exec_init call give num_bo_handles as last parameter it would
>      making allocation of the array more efficient
>    - Handle return value of __xa_store() and improve the error handling of
>      amdgpu_userq_fence_driver_alloc().
>
> v2:(Christian):
>     - Revert userq_xa xarray init to XA_FLAGS_LOCK_IRQ.
>     - move the xa_unlock before the error check of the call xa_err(__xa_store())
>       and moved this change to a separate patch as this is adding a missing error
>       handling.
>     - Removed the unnecessary comments.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 44 ++++++++++++-------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 +--
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
>   4 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index ca8f01b2bd96..56bd870ff15d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -77,7 +77,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
>   	if (!fence_drv) {
>   		DRM_ERROR("Failed to allocate memory for fence driver\n");
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto free_fence_drv;
>   	}
>   
>   	/* Acquire seq64 memory */
> @@ -85,7 +86,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   			       &fence_drv->cpu_addr);
>   	if (r) {
>   		kfree(fence_drv);
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto free_seq64;
Sorry to come back to this old patch.
Can I still ask you to take a closer look? The erroneous
code is still present in today's linux-next.

You've replaced a `return -ENOMEM` by setting `r` and
jumping to `free_seq64` where the freed pointer
is used again (use-after-free). And it is doing another
`kfree` with the same pointer.

>   	}
>   
>   	memset(fence_drv->cpu_addr, 0, sizeof(u64));
> @@ -95,7 +97,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	spin_lock_init(&fence_drv->fence_list_lock);
>   
>   	fence_drv->adev = adev;
> -	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
> +	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> @@ -107,6 +109,13 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	userq->fence_drv = fence_drv;
>   
>   	return 0;
> +
> +free_seq64:
> +	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +free_fence_drv:
> +	kfree(fence_drv);
> +
> +	return r;
>   }
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
> [...]

