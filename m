Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC1BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 07:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3734310E41A;
	Thu,  5 May 2022 07:15:06 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C218910E331
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 07:15:04 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aeaed.dynamic.kabel-deutschland.de
 [95.90.234.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 50F4A61EA1928;
 Thu,  5 May 2022 09:15:02 +0200 (CEST)
Message-ID: <578caa75-5510-22d9-ef9f-0173a025b84a@molgen.mpg.de>
Date: Thu, 5 May 2022 09:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: flush delete wq after wait fence
Content-Language: en-US
To: Yiqing Yao <yiqing.yao@amd.com>
References: <20220505063527.957333-1-yiqing.yao@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220505063527.957333-1-yiqing.yao@amd.com>
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
Cc: jingwen.chen2@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Yiging,


Thank you for your patch.

Am 05.05.22 um 08:35 schrieb Yiqing Yao:
> [why]
> lru_list not empty warning in sw fini during repeated device bind unbind.
> There should be a amdgpu_fence_wait_empty() before the flush_delayed_work()
> call as sugested.

sug*g*ested

Suggested by whom? Or do you mean suggested in this diff?

> [how]
> Do flush_delayed_work for ttm bo delayed delete wq after fence_driver_hw_fini.
> 
> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 14c5ccf81e80..92e5ed3ed345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4003,10 +4003,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
> -	if (adev->mman.initialized) {
> -		flush_delayed_work(&adev->mman.bdev.wq);
> -		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> -	}

 From the commit message, it’s not clear, that you remove this here.


Kind regards,

Paul


>   	adev->shutdown = true;
>   
>   	/* make sure IB test finished before entering exclusive mode
> @@ -4029,6 +4025,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	}
>   	amdgpu_fence_driver_hw_fini(adev);
>   
> +	if (adev->mman.initialized) {
> +		flush_delayed_work(&adev->mman.bdev.wq);
> +		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +	}
> +
>   	if (adev->pm_sysfs_en)
>   		amdgpu_pm_sysfs_fini(adev);
>   	if (adev->ucode_sysfs_en)
