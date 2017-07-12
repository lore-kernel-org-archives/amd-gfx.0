From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Off by one sanity checks
Date: Wed, 12 Jul 2017 09:42:14 +0200
Message-ID: <83d7a8d8-4722-afba-11be-2df5e35b8631@amd.com>
References: <20170711195327.dzwtcsrguzmv3y6t@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170711195327.dzwtcsrguzmv3y6t@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Alex Deucher <alexander.deucher@amd.com>, Andres Rodriguez <andresx7@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 11.07.2017 um 21:53 schrieb Dan Carpenter:
> This is just future proofing code, not something that can be triggered
> in real life.  We're testing to make sure we don't shift wrap when we
> do "1ull << i" so "i" has to be in the 0-63 range.  If it's 64 then we
> have gone too far.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Christian König <christian.koenig@amd.com>

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 3a0b69b09ed6..e63925dffd2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2425,7 +2425,7 @@ static int gfx_v9_0_kiq_kcq_enable(struct amdgpu_device *adev)
>   		/* This situation may be hit in the future if a new HW
>   		 * generation exposes more than 64 queues. If so, the
>   		 * definition of queue_mask needs updating */
> -		if (WARN_ON(i > (sizeof(queue_mask)*8))) {
> +		if (WARN_ON(i >= (sizeof(queue_mask)*8))) {
>   			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
>   			break;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index aa5a50f5eac8..85a79829842e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4564,7 +4564,7 @@ static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
>   		/* This situation may be hit in the future if a new HW
>   		 * generation exposes more than 64 queues. If so, the
>   		 * definition of queue_mask needs updating */
> -		if (WARN_ON(i > (sizeof(queue_mask)*8))) {
> +		if (WARN_ON(i >= (sizeof(queue_mask)*8))) {
>   			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
>   			break;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 955aa304ff48..0def783889cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -671,7 +671,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
>   		/* This situation may be hit in the future if a new HW
>   		 * generation exposes more than 64 queues. If so, the
>   		 * definition of res.queue_mask needs updating */
> -		if (WARN_ON(i > (sizeof(res.queue_mask)*8))) {
> +		if (WARN_ON(i >= (sizeof(res.queue_mask)*8))) {
>   			pr_err("Invalid queue enabled by amdgpu: %d\n", i);
>   			break;
>   		}


