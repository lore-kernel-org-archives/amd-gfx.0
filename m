Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686ADD58E7E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 08:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC6010E456;
	Mon,  2 Mar 2026 08:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="bBRjG1NK";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="YQcZ5WeC";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD2B10E45A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1772440739;
 bh=5tWnMCBXY3wEn6HIgKnHOO3
 eqUkgGW21iAmlZN93wgI=; b=bBRjG1NK6bk/LqoWZBQLRD/qYAQGrbSc63mt7f5+rvBXE2aMVL
 jXXx89/ReT2mDtXH0Wzy+MqTEICeNljSyjJwdbpYI/zQEMon6KMeBaM9Y6cOjGfSuo33rrqFIA5
 T8o+Eq3Zj7miCdf8jYxuC4w84MuRhTPYQPYs6vPdJ6V85gYlp2kuWnu1tKvITfKkk+BS3tGLXeA
 V7eFPTUhM4H3uwogSdVEfqAhPp5kg1MaLR2zNdGJMo0d/QI9oBOebum1MHJikq7zUxqD3L4/jaW
 H+rv/LIapl2eeSJF90U/NVHjWSvngq03eT5B1TJ94aQFLNktTooGIW6830DXSt917CQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1772440739; bh=5tWnMCBXY3wEn6HIgKnHOO3
 eqUkgGW21iAmlZN93wgI=; b=YQcZ5WeCIl+/vr7pPU5vWZX10edZ82Ad/v0BKJlP4MrAyZm27L
 +7T/J0CXp7FiMiXmYHVBxVETeoVN77UZlOBw==;
Message-ID: <810028fa-332e-4b62-8792-747d39ca0516@damsy.net>
Date: Mon, 2 Mar 2026 09:38:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix mutex handling in
 amdgpu_benchmark_do_move()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260228162640.1697925-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260228162640.1697925-1-srinivasan.shanmugam@amd.com>
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



Le 28/02/2026 à 17:26, Srinivasan Shanmugam a écrit :
> amdgpu_benchmark_do_move() can exit the loop early if
> amdgpu_copy_buffer() or dma_fence_wait() fails.
> 
> In the error path, the function jumps to the exit label
> without releasing adev->mman.default_entity.lock, which
> leaves the mutex held and results in a lock imbalance.
> 
> This can block subsequent users of default_entity and
> potentially cause deadlocks.
> 
> Move the mutex_unlock() to the common exit path so the
> lock is released on both success and error returns.
> 
> This fixes:
> drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:57 amdgpu_benchmark_do_move()
> warn: inconsistent returns '&adev->mman.default_entity.lock'.
> 
> Fixes: 64c9e5ec16fa ("drm/amdgpu: add missing lock in amdgpu_benchmark_do_move")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index 98ccd7ab9e9a..024d1fe36716 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -33,7 +33,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
>   {
>   	ktime_t stime, etime;
>   	struct dma_fence *fence;
> -	int i, r;
> +	int i, r = 0;
>   

This change is unrelated. Other than that the commit looks good, thanks!

Pierre-Eric

>   	mutex_lock(&adev->mman.default_entity.lock);
>   	stime = ktime_get();
> @@ -48,9 +48,10 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
>   		if (r)
>   			goto exit_do_move;
>   	}
> -	mutex_unlock(&adev->mman.default_entity.lock);
> +
>   
>   exit_do_move:
> +	mutex_unlock(&adev->mman.default_entity.lock);
>   	etime = ktime_get();
>   	*time_ms = ktime_ms_delta(etime, stime);
>   
