Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45145CCF9E5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA48E10E18A;
	Sun, 26 Oct 2025 04:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ua+L8Agf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0592710E18A
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:24:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5387843C6D;
 Sun, 26 Oct 2025 04:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F66C4CEE7;
 Sun, 26 Oct 2025 04:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761452684;
 bh=dMPMRRoMJgccc7BS2ULEhV3/kgrJg53BMMGB3w7j5js=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ua+L8Agf5hcpblDHmegCmONXhl2Y2fS66TM/va1Cjyww2CNYSCF2rsuHWF0Syy47s
 2Pkl5Y9WGV6xWlKvYnPVO+9l1dWtk8YpFDs28QTKMHV21v0uN9mSnpxCBFTilcb6mk
 6r5sIsY1mswD7BKaRQPQ4bKNPssN7TXYPPqARZyffLOt7JnRhjYBNiXRonXQnjc/su
 JGxD2LI/y9d1/rWz2ZdXQFmkYpuExY+A+hKNuR05FwvV3SFF/aO+mOJ6Nu53aCPM6H
 J3pdyYvx/EtmLuRqZsK/4gUfjE+DKgjxd+uwlYKhcmqvqRI3UKacqhSdYKTIlgMLjd
 4FvZSVNRV4XDw==
Message-ID: <2a9c8369-2fe6-45b3-84e3-b004bae74c47@kernel.org>
Date: Sat, 25 Oct 2025 23:24:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: move PMFW rlc notifier to where it's
 required
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lkml@antheas.dev, bob.beckett@collabora.com
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <c10ff333-d120-4ecf-94bf-7099feb48fed@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <c10ff333-d120-4ecf-94bf-7099feb48fed@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/24/25 12:11 PM, Mario Limonciello wrote:
> 
> 
> On 10/24/2025 12:08 PM, Alex Deucher wrote:
>> For S3 on vangogh, PMFW needs to be notified before the
>> driver powers down RLC.  Move this notification to
>> the rlc stop function so it will always get called bfore
>> stopping the RLC. The call in amdgpu_device_suspend()
>> seems to be superfluous so remove that as well.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> One nit below.
> 

Antheas had feedback that this version didn't work on another thread.
Also I noticed that amdgpu_dpm_notify_rlc_state() no longer was needed 
after this change.

As my unwind series is on top of this I'm going to send an updated 
unwind series that just takes the relevant chunk that we know works for now.

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 12 +++++++++++-
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 10 ----------
>>   3 files changed, 11 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_device.c
>> index 5053c5f475ba9..78c0fc3a50ae8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5283,10 +5283,6 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool notify_clients)
>>       if (amdgpu_sriov_vf(adev))
>>           amdgpu_virt_release_full_gpu(adev, false);
>> -    r = amdgpu_dpm_notify_rlc_state(adev, false);
>> -    if (r)
>> -        return r;
>> -
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/gfx_v10_0.c
>> index 39b8adf23a9fa..d64579f5fb1f8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -5470,8 +5470,18 @@ static int gfx_v10_0_init_csb(struct 
>> amdgpu_device *adev)
>>   static void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)
>>   {
>> -    u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
>> +    u32 tmp;
>> +    int r;
>> +
>> +    /* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
>> +     * otherwise SMU will hang while interacting with RLC if RLC is 
>> halted
>> +     * this is a WA for Vangogh asic which fix the SMU hang issue.
>> +     */
>> +    r = amdgpu_dpm_notify_rlc_state(adev, false);
>> +    if (r)
>> +        dev_info(adev->dev, "failed to notify PMFW of RLC powerdown\n");
> 
> This should probably be dev_err().
> 
>> +    tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
>>       tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
>>       WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
>>   }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/ 
>> drm/amd/pm/swsmu/amdgpu_smu.c
>> index 4317da6f7c389..10d42267085b0 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context 
>> *smu)
>>           }
>>       }
>> -    /* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
>> -     * otherwise SMU will hang while interacting with RLC if RLC is 
>> halted
>> -     * this is a WA for Vangogh asic which fix the SMU hang issue.
>> -     */
>> -    ret = smu_notify_rlc_state(smu, false);
>> -    if (ret) {
>> -        dev_err(adev->dev, "Fail to notify rlc status!\n");
>> -        return ret;
>> -    }
>> -
>>       if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
>>           !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
>>           !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
> 
> 

