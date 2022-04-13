Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADE2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 07:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CED10FDE1;
	Wed, 13 Apr 2022 07:34:14 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F64C10FDCC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 07:34:12 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae908.dynamic.kabel-deutschland.de
 [95.90.233.8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0F83861EA192A;
 Wed, 13 Apr 2022 09:34:11 +0200 (CEST)
Message-ID: <6bd90d6f-1475-4eba-b751-74ee797325a2@molgen.mpg.de>
Date: Wed, 13 Apr 2022 09:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/amdgpu: Make sure ttm delayed work finished
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>
References: <20220413064609.21491-1-xinhui.pan@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220413064609.21491-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear xinhui,


Am 13.04.22 um 08:46 schrieb xinhui pan:
> ttm_device_delayed_workqueue would reschedule itself if there is pending
> BO to be destroyed. So just one flush + cancel_sync is not enough. We
> still see lru_list not empty warnging.

warning

(`scripts/checkpatch.pl --codespell` should have found this.)

> 
> Fix it by waiting all BO to be destroyed.

Please explain the waiting algorithm. Why at least one millisecond?

Do you have a reproducer for this issue?

> Acked-by: Guchun Chen <guchun.chen@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6f47726f1765..56dcf8c3a3cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3957,11 +3957,17 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>    */
>   void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
> +	int pending = 1;

Could this be bool?

> +
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
> -	if (adev->mman.initialized) {
> +	while (adev->mman.initialized && pending) {
>   		flush_delayed_work(&adev->mman.bdev.wq);
> -		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +		pending = ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +		if (pending) {
> +			ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, true);

Does this call affect `adev->mman.initialized`? If not a do-while loop 
might be better suited, so pending is only checked once.

if (adev->mman.initialized) {
	do {
		flush_delayed_work(&adev->mman.bdev.wq);
		ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, true);
		msleep(((HZ / 100) < 1) ? 1 : HZ / 100);
	} while (ttm_bo_lock_delayed_workqueue(&adev->mman.bdev));
}

The logic is slightly different, as 
`ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, true);` and the sleep 
are run at least once, so the suggestion might be unsuitable.

> +			msleep(((HZ / 100) < 1) ? 1 : HZ / 100);

Maybe add a comment for that formula? (No idea, if common knowledge, but 
why is a delay needed, and the loop cannot be run as fast as possible?)

> +		}
>   	}
>   	adev->shutdown = true;
>   


Kind regards,

Paul
