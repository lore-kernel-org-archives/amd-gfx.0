Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F06BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 12:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC25C10E52B;
	Mon, 11 Apr 2022 12:50:06 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0931210E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 12:50:04 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae91f.dynamic.kabel-deutschland.de
 [95.90.233.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 422F261EA1923;
 Mon, 11 Apr 2022 14:50:03 +0200 (CEST)
Message-ID: <33b35ddf-9468-7029-6c55-9ce990a6556a@molgen.mpg.de>
Date: Mon, 11 Apr 2022 14:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: Release memory when psp sw_init is failed
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>
References: <20220411124206.1348117-1-Jun.Ma2@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220411124206.1348117-1-Jun.Ma2@amd.com>
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
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Ma,


Thank you for your patch.

Am 11.04.22 um 14:42 schrieb Ma Jun:
> Release the memory (psp->cmd) when psp initialization is
> failed in psp_sw_init

s/is failed/fails/

Period/full stop at the end of sentences, and it still fits into 75 
characters per line.

Next time you could also add one simple statement like:

Add new label `failure` to jump to in case of the failure.

> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Change-Id: I2f88b5919142d55dd7d3820a7da94823286db235

Without the URL of the Gerrit instance, the Change-Id is not of much use.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a6acec1a6155..1227dc014c80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -305,9 +305,10 @@ static int psp_sw_init(void *handle)
>   		ret = psp_init_sriov_microcode(psp);
>   	else
>   		ret = psp_init_microcode(psp);
> +

Unrelated.

>   	if (ret) {
>   		DRM_ERROR("Failed to load psp firmware!\n");
> -		return ret;
> +		goto failure;
>   	}
>   
>   	adev->psp.xgmi_context.supports_extended_data =
> @@ -339,25 +340,27 @@ static int psp_sw_init(void *handle)
>   		ret = psp_memory_training_init(psp);
>   		if (ret) {
>   			DRM_ERROR("Failed to initialize memory training!\n");
> -			return ret;
> +			goto failure;
>   		}
>   
>   		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
>   		if (ret) {
>   			DRM_ERROR("Failed to process memory training!\n");
> -			return ret;
> +			goto failure;
>   		}
>   	}
>   
>   	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
>   	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
>   		ret= psp_sysfs_init(adev);
> -		if (ret) {
> -			return ret;
> -		}
> +		if (ret)
> +			goto failure;
>   	}
>   
>   	return 0;
> +failure:
> +	kfree(psp->cmd);
> +	return ret;
>   }
>   
>   static int psp_sw_fini(void *handle)

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
