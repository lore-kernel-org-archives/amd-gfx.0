Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC6EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 03:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349FD10E527;
	Tue, 22 Mar 2022 03:42:34 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9786310E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 03:42:32 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae922.dynamic.kabel-deutschland.de
 [95.90.233.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4808761E64846;
 Tue, 22 Mar 2022 04:42:30 +0100 (CET)
Message-ID: <3222c670-13fc-f47c-e463-08c7a6e61ed4@molgen.mpg.de>
Date: Tue, 22 Mar 2022 04:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v3)
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>
References: <20220322032916.3074-1-tao.zhou1@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220322032916.3074-1-tao.zhou1@amd.com>
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
Cc: Felix.Kuehling@amd.com, Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org,
 yipeng.chai@amd.com, stanley.yang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Tao,


Thank you for rerolling the pacth.

Am 22.03.22 um 04:29 schrieb Tao Zhou:
> Print the status out when it passes, and also tell user gpu reset
> is triggered when we fallback to legacy way.

The verb *fall back* is written with a space.

> v2: make the message more explicitly.

explicit

> v3: change succeeds to succeeded.
>      replace pr_warn with dev_info.

Please give the reason, why to decrease the debug level. (I would also 
do it in a separate commit.)

> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 56902b5bb7b6..cc9ddc4b4cb8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   	if (old_poison)
>   		return;
>   
> -	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
> -
>   	switch (client_id) {
>   	case SOC15_IH_CLIENTID_SE0SH:
>   	case SOC15_IH_CLIENTID_SE1SH:
> @@ -130,10 +128,17 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   	/* resetting queue passes, do page retirement without gpu reset
>   	 * resetting queue fails, fallback to gpu reset solution
>   	 */
> -	if (!ret)
> +	if (!ret) {
> +		dev_info(dev->adev->dev,
> +			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
> +			client_id);
>   		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
> -	else
> +	} else {
> +		dev_info(dev->adev->dev,
> +			"RAS poison consumption, fallback to gpu reset flow: client id %d\n",

The verb *fall back* is written with a space.

> +			client_id);
>   		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
> +	}
>   }
>   
>   static bool event_interrupt_isr_v9(struct kfd_dev *dev,
