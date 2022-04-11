Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F77C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436F610E2E0;
	Mon, 11 Apr 2022 15:28:21 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1992D10E2E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:28:20 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5ae91f.dynamic.kabel-deutschland.de
 [95.90.233.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6CE4661EA1923;
 Mon, 11 Apr 2022 17:28:18 +0200 (CEST)
Message-ID: <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de>
Date: Mon, 11 Apr 2022 17:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Content-Language: en-US
To: Yongqiang Sun <yongqiang.sun@amd.com>
References: <20220411135939.906700-1-yongqiang.sun@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220411135939.906700-1-yongqiang.sun@amd.com>
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
Cc: jingwen.chen2@amd.com, zhigang.luo@amd.com, monk.liu@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Yongqiang,


Thank you for your patch.

Am 11.04.22 um 15:59 schrieb Yongqiang Sun:
> MS_HYPERV with vega10 doesn't have the interface to process
> request init data msg.

Should some Hyper-V folks be added to the reviewers list too?

> Check hypervisor type to not send the request for MS_HYPERV.

Please add a blank line between paragraphs.

> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 933c41f77c92..56b130ec44a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -23,6 +23,10 @@
>   
>   #include <linux/module.h>
>   
> +#ifdef CONFIG_X86
> +#include <asm/hypervisor.h>
> +#endif
> +
>   #include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
> @@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   			break;
>   		case CHIP_VEGA10:
>   			soc15_set_virt_ops(adev);
> -			/* send a dummy GPU_INIT_DATA request to host on vega10 */
> -			amdgpu_virt_request_init_data(adev);
> +#ifdef CONFIG_X86
> +			/* not send GPU_INIT_DATA with MS_HYPERV*/
> +			if (hypervisor_is_type(X86_HYPER_MS_HYPERV) == false)
> +#endif

Why guard everything with CONFIG_X86? (If it’s needed, it should be done 
in C code.)

> +				/* send a dummy GPU_INIT_DATA request to host on vega10 */
> +				amdgpu_virt_request_init_data(adev);
>   			break;
>   		case CHIP_VEGA20:
>   		case CHIP_ARCTURUS:


Kind regards,

Paul
