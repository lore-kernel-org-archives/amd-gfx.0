Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F2CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 10:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA7710E6E5;
	Wed, 13 Aug 2025 10:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="g2CBG74Q";
	dkim-atps=neutral
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [91.218.175.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C725310E606
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 20:05:22 +0000 (UTC)
Message-ID: <2cefb4a5-bedf-469b-b4ff-2f55b8d4a933@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1755029119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BoAC6hV2cPxw8zZPiB/1tANMoMj6r/vN4w8vRpDiiCM=;
 b=g2CBG74Qfr/Bm1ioW66rs3rHxHinrl2Oy9HxZkmTfhPx1/Z1q5zKbP1sdQ2hTEWehepF7j
 Oo8TddyGQjcdFAN0c+P+uN3v6XlvgXgiVaUZl0dALPlA+V4VMi+IYx+VOYCachfoNDeO74
 qKRr4MPZKsSss1pRQ3mClNQFhCd2d6E=
Date: Tue, 12 Aug 2025 13:05:15 -0700
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v2] drm/amdgpu: fix task hang from failed job submission
 during process kill
To: Liu01 Tong <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, gang.ba@amd.com, "Lin . Cao" <lincao12@amd.com>
References: <20250812083116.4091828-1-Tong.Liu01@amd.com>
Content-Language: en-US
In-Reply-To: <20250812083116.4091828-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 13 Aug 2025 10:15:14 +0000
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

On 8/12/25 1:31 AM, Liu01 Tong wrote:
> During process kill, drm_sched_entity_flush() will kill the vm
> entities. The following job submissions of this process will fail, and
> the resources of these jobs have not been released, nor have the fences
> been signalled, causing tasks to hang and timeout.
> 
> Fix by check entity status in amdgpu_vm_ready() and avoid submit jobs to
> stopped entity.
> 
> v2: add amdgpu_vm_ready() check before amdgpu_vm_clear_freed() in
> function amdgpu_cs_vm_handling().
> 
> Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
> Signed-off-by: Lin.Cao <lincao12@amd.com>

Closes: https://lore.kernel.org/regressions/f2b70e6e-bff6-42f3-82a2-81eed892cc30@linux.dev/
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Thanks,
Matt

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index e1e48e6f1f35..cdc02860011c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1138,6 +1138,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  		}
>  	}
>  
> +	if (!amdgpu_vm_ready(vm))
> +		return -EINVAL;
> +
>  	r = amdgpu_vm_clear_freed(adev, vm, NULL);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 283dd44f04b0..bf42246a3db2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -654,11 +654,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   * Check if all VM PDs/PTs are ready for updates
>   *
>   * Returns:
> - * True if VM is not evicting.
> + * True if VM is not evicting and all VM entities are not stopped
>   */
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  {
> -	bool empty;
>  	bool ret;
>  
>  	amdgpu_vm_eviction_lock(vm);
> @@ -666,10 +665,18 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  	amdgpu_vm_eviction_unlock(vm);
>  
>  	spin_lock(&vm->status_lock);
> -	empty = list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->evicted);
>  	spin_unlock(&vm->status_lock);
>  
> -	return ret && empty;
> +	spin_lock(&vm->immediate.lock);
> +	ret &= !vm->immediate.stopped;
> +	spin_unlock(&vm->immediate.lock);
> +
> +	spin_lock(&vm->delayed.lock);
> +	ret &= !vm->delayed.stopped;
> +	spin_unlock(&vm->delayed.lock);
> +
> +	return ret;
>  }
>  
>  /**

