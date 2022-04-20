Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79297C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 20:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3377C10E1BC;
	Wed, 20 Apr 2022 20:12:14 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E42710E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 20:12:13 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae925.dynamic.kabel-deutschland.de
 [95.90.233.37])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4353D61CCD7D8;
 Wed, 20 Apr 2022 22:12:11 +0200 (CEST)
Message-ID: <c2861692-1646-b94c-286f-e28df1ec901d@molgen.mpg.de>
Date: Wed, 20 Apr 2022 22:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
Content-Language: en-US
To: Alice Wong <shiwei.wong@amd.com>
References: <20220420193700.1878150-1-shiwei.wong@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220420193700.1878150-1-shiwei.wong@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alice,


Thank you for your patch.

Am 20.04.22 um 21:37 schrieb Alice Wong:
> Call psp_hw_fini when psp_hw_init failed.

Please amend the commit message, and add the motivation/reasoning too [1].

I think it’s common, if a patch (series) is rerolled to list the changes 
between the versions.


Kind regards,

Paul


[1]: https://cbea.ms/git-commit/

> Signed-off-by: Alice Wong <shiwei.wong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 +++++++++++++------------
>   1 file changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 5b9e48d44f5b..52b14efa848a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2537,6 +2537,34 @@ static int psp_load_fw(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> +static int psp_hw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->ta_fw) {
> +		psp_ras_terminate(psp);
> +		psp_securedisplay_terminate(psp);
> +		psp_rap_terminate(psp);
> +		psp_dtm_terminate(psp);
> +		psp_hdcp_terminate(psp);
> +	}
> +
> +	psp_asd_terminate(psp);
> +
> +	psp_tmr_terminate(psp);
> +	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> +
> +	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> +			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> +	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> +			      &psp->fence_buf_mc_addr, &psp->fence_buf);
> +	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> +			      (void **)&psp->cmd_buf_mem);
> +
> +	return 0;
> +}
> +
>   static int psp_hw_init(void *handle)
>   {
>   	int ret;
> @@ -2563,37 +2591,10 @@ static int psp_hw_init(void *handle)
>   failed:
>   	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
>   	mutex_unlock(&adev->firmware.mutex);
> +	psp_hw_fini(handle);
>   	return -EINVAL;
>   }
>   
> -static int psp_hw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct psp_context *psp = &adev->psp;
> -
> -	if (psp->ta_fw) {
> -		psp_ras_terminate(psp);
> -		psp_securedisplay_terminate(psp);
> -		psp_rap_terminate(psp);
> -		psp_dtm_terminate(psp);
> -		psp_hdcp_terminate(psp);
> -	}
> -
> -	psp_asd_terminate(psp);
> -
> -	psp_tmr_terminate(psp);
> -	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> -
> -	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> -			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> -	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> -			      &psp->fence_buf_mc_addr, &psp->fence_buf);
> -	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> -			      (void **)&psp->cmd_buf_mem);
> -
> -	return 0;
> -}
> -
>   static int psp_suspend(void *handle)
>   {
>   	int ret;
