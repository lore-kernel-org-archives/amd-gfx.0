Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 10:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818D910E24B;
	Mon, 21 Mar 2022 10:47:07 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A2B10E24B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 10:47:05 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef4e.dynamic.kabel-deutschland.de
 [95.90.239.78])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3BF7561E6478B;
 Mon, 21 Mar 2022 11:47:03 +0100 (CET)
Message-ID: <14f7d9cc-e0e2-260f-0073-dde2d40a44f1@molgen.mpg.de>
Date: Mon, 21 Mar 2022 11:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>
References: <20220321093818.24270-1-tao.zhou1@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220321093818.24270-1-tao.zhou1@amd.com>
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
Cc: Felix.Kuehling@amd.com, yipeng.chai@amd.com, stanley.yang@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Tao,


Thank you for the patch.


Am 21.03.22 um 10:38 schrieb Tao Zhou:
> Print the status out when it passes, and also tell user gpu reset
> is triggered when we fallback to legacy way.
> 
> v2: make the message more explicitly.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 56902b5bb7b6..32c451f21db7 100644
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
> @@ -130,10 +128,15 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   	/* resetting queue passes, do page retirement without gpu reset
>   	 * resetting queue fails, fallback to gpu reset solution
>   	 */
> -	if (!ret)
> +	if (!ret) {
> +		pr_warn("RAS poison consumption, unmap queue flow succeeds: client id %d\n",
> +				client_id);

succeeded? As it’s a success message, should it be an informational message?

>   		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
> -	else
> +	} else {
> +		pr_warn("RAS poison consumption, fallback to gpu reset flow: client id %d\n",

Fall back.

> +				client_id);
>   		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);

Could the log be moved somehow to the handler?

> +	}
>   }
>   
>   static bool event_interrupt_isr_v9(struct kfd_dev *dev,

Unrelated to the patch, at least I as user, would wish these warnings to 
be more elaborate, telling me, what the problem is, what effects it has, 
and what to do to fix it.


Kind regards,

Paul
