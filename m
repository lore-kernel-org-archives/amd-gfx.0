Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Feb 2022 10:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEA810E955;
	Tue,  1 Feb 2022 10:03:41 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEFC10E955
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Feb 2022 10:03:40 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id h7so52543632ejf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Feb 2022 02:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=hZ/GtfJXMJ+uCIFNQdEJss8e2IB9srPFE0xTZ3ZF8L0=;
 b=Xkepf2f3Uz3Ub2VvRQzpayDbVNdRcgrp34xtNAxtLmi0IIKsABkyJv0A0TgwhW1JeO
 u57ABXP9p6a2kxVMSLshP7IWZYHY40YLTKwH9J0BG8/WMri+fNXTimgvIWutnZu9+szl
 ZLJPEcbp7HXYYG3ByiganTO1Y/1VMxNneAf4lLT9Ia2kmfGlt1DbBoOnmp4YI8A9Qw6R
 88dTobTyajPOZb2pu119CwIQdDIsVMZ7kayf9BIDRk8lqxXIPXQISP3kPHRZ4BoR2w63
 MwrPl3oK+bJ8xefBgHtU8BhacmCBiw0730V9P4GvEVo7ZSWXY1h1iWdwVk/6uwjk5+hB
 4qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hZ/GtfJXMJ+uCIFNQdEJss8e2IB9srPFE0xTZ3ZF8L0=;
 b=m72qTseeJBuwVyHwVzNcs3WqdQ18H+7ZqnxCCr669DJa2+vNTMiKsrAWqVv7lTlpwI
 jwl5vbSc3ZVIvGU8NXjW5wsfwE+T4UXkVV55IjN63XKj3wCzNjoK0YTukWZQYoaO8mkT
 okHaQ+6Kpt8sQg3ptbdmML5OdAS9DvgxI4E1bbGZ3m5dijIlvQGxIwyH0vt0B9VJDV0W
 ZqpMEKaU6zgxq9a9Lfc/y1bCaRdqmT1N1dzIH3qCw2qDFH5Y40wlyd7fxKDCh7xBZPCq
 hSq8LG3awyioJphkM4c1CEClKP4mc3H+OakBvQseRN2ejEtlwyJpmw/xSCuFnFCC3lyO
 3bIQ==
X-Gm-Message-State: AOAM530DMJf+XOmp/CEFEmBxCW7nAf3WXmZsIoDHFtFzwUD/ZUQQPUXc
 j5QdXwvWIfgR7J8WHD2OXVk=
X-Google-Smtp-Source: ABdhPJzc2d5ZSUhAmL+UZBADEMC9cQJ2W1kFv/jjJ9VAt4BKirAp1wtbbNB4G9EXhn/5Llz5MIQwow==
X-Received: by 2002:a17:907:3e9c:: with SMTP id
 hs28mr19968737ejc.735.1643709818972; 
 Tue, 01 Feb 2022 02:03:38 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:da17:c9a1:5359:a5d?
 ([2a02:908:1252:fb60:da17:c9a1:5359:a5d])
 by smtp.gmail.com with ESMTPSA id fn3sm14323581ejc.58.2022.02.01.02.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Feb 2022 02:03:38 -0800 (PST)
Message-ID: <b2de251b-6235-f6d9-bba5-ab68c9a6b4c8@gmail.com>
Date: Tue, 1 Feb 2022 11:03:37 +0100
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
References: <20220131153527.11051-1-surbhi.kakarya@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220131153527.11051-1-surbhi.kakarya@amd.com>
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

Am 31.01.22 um 16:35 schrieb Surbhi Kakarya:
> This patch handles the GPU recovery faliure in sriov environment by
> retrying the reset if the first reset fails. To determine the condition of retry, a
> new function amdgpu_is_retry_sriov_reset() is added which returns true if failure is due
> to ETIMEDOUT, EINVAL or EBUSY, otherwise return false.
>
> It also handles the return status in Post Asic Reset by updating the return code
> with asic_reset_res and eventually return the return code in amdgpu_job_timedout().

That patch is certainly a NAK.

The retry should never be in the job, but rather in the device code itself.

Please sync up with Andrey and Monk about that.

Regards,
Christian.

>
> Change-Id: I45b9743adb548606aef8774496527d29fb3de0af
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++-
>   2 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 53af2623c58f..8a742b77eef8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5026,6 +5026,21 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_is_retry_sriov_reset - check if we should retry sriov reset
> + *
> + * Check amdgpu_is_retry_sriov_reset and return status to see if we should retry reset.
> + */
> +static bool amdgpu_is_retry_sriov_reset(int r)
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
> @@ -5064,8 +5079,13 @@ static void amdgpu_device_recheck_guilty_jobs(
>   			if (amdgpu_sriov_vf(adev)) {
>   				amdgpu_virt_fini_data_exchange(adev);
>   				r = amdgpu_device_reset_sriov(adev, false);
> -				if (r)
> +				if (r) {
>   					adev->asic_reset_res = r;
> +					if (amdgpu_is_retry_sriov_reset(r)) {
> +						adev->asic_reset_res = 0;
> +						goto retry;
> +					}
> +				}
>   			} else {
>   				clear_bit(AMDGPU_SKIP_HW_RESET,
>   					  &reset_context->flags);
> @@ -5299,8 +5319,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Host driver will handle XGMI hive reset for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_device_reset_sriov(adev, job ? false : true);
> -		if (r)
> -			adev->asic_reset_res = r;
> +                if (r) {
> +                        adev->asic_reset_res = r;
> +                        if (amdgpu_is_retry_sriov_reset(r)) {
> +				adev->asic_reset_res = 0;
> +				goto retry;
> +                        }
> +                }
>   	} else {
>   		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
>   		if (r && r == -EAGAIN)
> @@ -5341,6 +5366,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

