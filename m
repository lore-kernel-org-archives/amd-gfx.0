Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4291AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 07:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFF010F76E;
	Wed,  2 Feb 2022 07:45:01 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1406610F76E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 07:45:01 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 o30-20020a05600c511e00b0034f4c3186f4so3866173wms.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Feb 2022 23:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=7NIafuIJZJk/Nd4JXYX38cbFxlMW1Q5sCIAmgWNVYL4=;
 b=Ik68Br8zH1tlcKD44EQgsqdHnNcFT+6dNF4GrlTNkkCowTaV4zCda4ocCFFnf4miqs
 xLU81FkZZRfmOaiyeLY8GohkHzKPzoSuR/Ce2YMwN7paQUKjdxc7pU46L9Ch9V63EIaD
 PI6cOT/I1brAFFrgTympQlzAScWbejNAnZeAV6SbtWsy79hq8lJ7BwPh2xB/d8tRMY4M
 NQp6QDHOR8X0EUPAW6EW4drNoXkLNEycb2/xJTjey6UNugQcTuNuMH27JFAaNcHiBH8p
 JL+PuMefXHriddZfHSy4qQFwhv9QEtBlWjc92Srt0ZbrQxmZQ4/GTpMhbawxpoTxeHD3
 O/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7NIafuIJZJk/Nd4JXYX38cbFxlMW1Q5sCIAmgWNVYL4=;
 b=IxspFpjYFSh8GUpu4UdWmgfBRuPHsJwQ0IlpP04B8/kwuACNlvTc4l7wkMYNSK5txO
 ys9Avv/4blGpF1kSmDYfK1ofIL+BytBP9R/qVWJqiRyzZHUNmr1JZvV7bJlrNklaoG62
 Jcd5wJFR34Q0XP8H1ae/SlEGOU8v/iCGTs0/rYUuw25OAgMcwXxkVDJNo+jK3hd0wk3d
 2r0d1x8p9weRsfRNttgvvCPoxjmQHMwMPEJ4Mn9kIBbzRY3V7b/oCL16zod8ytBXG3o9
 UgvpZx+8gG0uVflsfuN6kcxD1LgcZ+/yihxFmMZTxNwDPGM2+5xtDgjNYnPXbLVt+qTv
 W0zQ==
X-Gm-Message-State: AOAM530acRExnssyg07p7Wl56eYW+c3pLhQgwWShbBx4KUqvsHksc3pZ
 OmVrLOFbnSlFcHyvooNyEUw=
X-Google-Smtp-Source: ABdhPJwgKA3AhlmcV3suV0j8kbpKT0d7q0gC1XPpiipc7WtQbT9uB/CU1lBpwF4k6yE78J78CYQp4A==
X-Received: by 2002:a1c:f309:: with SMTP id q9mr4897520wmq.173.1643787899459; 
 Tue, 01 Feb 2022 23:44:59 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id g15sm12047268wri.82.2022.02.01.23.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 23:44:58 -0800 (PST)
Message-ID: <1ff213f1-e6fa-3444-d85e-b235f0a3d58f@gmail.com>
Date: Wed, 2 Feb 2022 08:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Handle the GPU recovery failure in SRIOV
 environment.
Content-Language: en-US
To: Surbhi Kakarya <surbhi.kakarya@amd.com>, amd-gfx@lists.freedesktop.org,
 Bokun.Zhang@amd.com, HaiJun.Chang@amd.com, Monk.Liu@amd.com,
 Alexander.Deucher@amd.com, Kelly.Zytaruk@amd.com,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20220201214719.166802-1-surbhi.kakarya@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220201214719.166802-1-surbhi.kakarya@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Adding Andrey as well]

Am 01.02.22 um 22:47 schrieb Surbhi Kakarya:
> This patch handles the GPU recovery faliure in sriov environment by
> retrying the reset if the first reset fails. To determine the condition of retry, a
> new function amdgpu_is_retry_sriov_reset() is added which returns true if failure is due
> to ETIMEDOUT, EINVAL or EBUSY, otherwise return false. MAX_RETRY_LIMIT is used to
> limit the retry to 2.
>
> It also handles the return status in Post Asic Reset by updating the return code
> with asic_reset_res and eventually return the return code in amdgpu_job_timedout().
>
> Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
> Change-Id: Ib2e408819b4780e6963e1dc078c3410cd512e6e8
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 ++-
>   2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 53af2623c58f..f50c18cb38c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -89,6 +89,7 @@ MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
>   
>   #define AMDGPU_RESUME_MS		2000
> +#define MAX_RETRY_LIMIT		2

Please AMDGPU_ prefix for all defines.

>   
>   const char *amdgpu_asic_name[] = {
>   	"TAHITI",
> @@ -5026,11 +5027,27 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_is_retry_sriov_reset - check if we should retry sriov reset
> + *
> + * Check amdgpu_is_retry_sriov_reset and return status to see if we should retry reset.
> + */
> +static bool amdgpu_is_retry_sriov_reset(int r)

Please use an amdgpu_device_ prefix here.

> +{
> +
> +        if(r == -EBUSY || r == -ETIMEDOUT || r == -EINVAL)
> +                return true;
> +        else
> +                return false;
> +
> +}
> +
>   static void amdgpu_device_recheck_guilty_jobs(
>   	struct amdgpu_device *adev, struct list_head *device_list_handle,
>   	struct amdgpu_reset_context *reset_context)
>   {
>   	int i, r = 0;
> +	int retry_limit = 0;
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> @@ -5064,8 +5081,18 @@ static void amdgpu_device_recheck_guilty_jobs(
>   			if (amdgpu_sriov_vf(adev)) {
>   				amdgpu_virt_fini_data_exchange(adev);
>   				r = amdgpu_device_reset_sriov(adev, false);
> -				if (r)
> +				if (r) {
>   					adev->asic_reset_res = r;
> +					if (amdgpu_is_retry_sriov_reset(r)) {
> +						adev->asic_reset_res = 0;
> +						if (retry_limit < MAX_RETRY_LIMIT) {
> +							retry_limit++;
> +							goto retry;
> +						}
> +						else
> +							DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> +					}
> +				}

That looks like this should rather be inside the 
amdgpu_device_reset_sriov() function.

Additional to that please check the coding style with checkpatch.pl.



>   			} else {
>   				clear_bit(AMDGPU_SKIP_HW_RESET,
>   					  &reset_context->flags);
> @@ -5122,6 +5149,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	bool locked = false;
>   	int tmp_vram_lost_counter;
>   	struct amdgpu_reset_context reset_context;
> +	int retry_limit = 0;
>   
>   	memset(&reset_context, 0, sizeof(reset_context));
>   
> @@ -5299,8 +5327,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Host driver will handle XGMI hive reset for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_device_reset_sriov(adev, job ? false : true);
> -		if (r)
> -			adev->asic_reset_res = r;
> +                if (r) {
> +                        adev->asic_reset_res = r;
> +                        if (amdgpu_is_retry_sriov_reset(r)) {
> +				adev->asic_reset_res = 0;
> +				if (retry_limit < MAX_RETRY_LIMIT) {
> +					retry_limit++;
> +					goto retry;
> +				}
> +				else
> +					DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> +                        }
> +                }
>   	} else {
>   		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
>   		if (r && r == -EAGAIN)
> @@ -5341,6 +5379,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
>   		}
>   
> +		if (tmp_adev->asic_reset_res)
> +			r = tmp_adev->asic_reset_res;
> +
>   		tmp_adev->asic_reset_res = 0;
>   
>   		if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e0730ea56a8c..1f0fb21ac15a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -37,6 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_task_info ti;
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
> +	int r = 0;

Please don't initialize local variables if it isn't necessary.

Regards,
Christian.

>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
> @@ -63,7 +64,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>   
>   	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> -		amdgpu_device_gpu_recover(ring->adev, job);
> +		r = amdgpu_device_gpu_recover(ring->adev, job);
> +		if (r)
> +			DRM_ERROR("GPU Recovery Failed: %d\n",r);
> +
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
>   		if (amdgpu_sriov_vf(adev))

