Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C93CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 12:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB9810E2C9;
	Fri, 31 Oct 2025 12:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HCQqu2NB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D347810E2C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 12:59:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FB2543A89;
 Fri, 31 Oct 2025 12:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194ACC4CEE7;
 Fri, 31 Oct 2025 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761915562;
 bh=2+bKvseDzlU36uPI8SuBPsdfoSIchUIH5Tb8M5x+liY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HCQqu2NB90CiAEyDrlG8X166iR3B+sOyQmtrauNs38QgAkF6FB5OevnBZNWv0ripc
 MiEVKWvMy+cEbuUhWv68XR5F1qPqDRpri6A5WCBfLAR+aD9hpFeuQcy59uJYrtwHT6
 F+lfc56CMB4W1OemxX+rv6u8la1oFTfwFcNwdP25IGh7YIiiGWLr+Ba62XdEZL90oP
 azjyNMFFbrfrJVw4fCzX8JH0oBH0WxU5hQZTBpcNaj5AKYp7e6T1aQL5KDh6HbFNJ5
 vtYoRzFuxNJXIviSemsrHzZPVGtaPkDH57VtQC0ERHPFUga29825L+wOU3TG+yacDJ
 dtxLo1RDJ40rA==
Message-ID: <b8cab278-fe8d-4edf-a951-ab1b1128be79@kernel.org>
Date: Fri, 31 Oct 2025 07:59:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/amdgpu: Drop PMFW RLC notifier from
 amdgpu_device_suspend()
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20251026042942.549389-1-superm1@kernel.org>
 <20251026042942.549389-2-superm1@kernel.org>
 <CAGwozwHcbfct6REgHA1fb3rLFiNrpcb4nek+FYP7np15Laibng@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAGwozwHcbfct6REgHA1fb3rLFiNrpcb4nek+FYP7np15Laibng@mail.gmail.com>
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



On 10/31/2025 7:01 AM, Antheas Kapenekakis wrote:
> On Sun, 26 Oct 2025 at 05:30, Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> For S3 on vangogh, PMFW needs to be notified before the
>> driver powers down RLC.  This already happens in smu_disable_dpms()
>> so drop the superfluous call in amdgpu_device_suspend().
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Just for this patch:
> 
> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> 
> If the subject is refactored to take into account that it fixes sleep add:
> #Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> #Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> 
> Tested on a Steam Deck OLED and Xbox Ally.

Thanks for checking.  This series is already merged so too late for 
tags.  But I'll add your tags to the other patch.

> 
> @Mario: For my series, can you have a look at the first two patches
> and if they are ok push forward with merging? Also, reminder for the
> Legion Go 2 quirk.

I'll look at the two platform-x86 ones again and leave comments if 
necessary.

> 
> Best,
> Antheas
> 
>> ---
>> Cc: lkml@antheas.dev
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ----
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 18 ------------------
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 --
>>   3 files changed, 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b8d91247f51a..f6850b86e96f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5280,10 +5280,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>          if (amdgpu_sriov_vf(adev))
>>                  amdgpu_virt_release_full_gpu(adev, false);
>>
>> -       r = amdgpu_dpm_notify_rlc_state(adev, false);
>> -       if (r)
>> -               return r;
>> -
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index 5d08dc3b7110..5c4d0eb198c4 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>>          return ret;
>>   }
>>
>> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
>> -{
>> -       int ret = 0;
>> -       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>> -
>> -       if (pp_funcs && pp_funcs->notify_rlc_state) {
>> -               mutex_lock(&adev->pm.mutex);
>> -
>> -               ret = pp_funcs->notify_rlc_state(
>> -                               adev->powerplay.pp_handle,
>> -                               en);
>> -
>> -               mutex_unlock(&adev->pm.mutex);
>> -       }
>> -
>> -       return ret;
>> -}
>> -
>>   int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>>   {
>>          const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index 3bce74f8bb0a..c7ea29385682 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
>>   int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>>                               enum pp_mp1_state mp1_state);
>>
>> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
>> -
>>   int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
>>
>>   int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
>> --
>> 2.51.1
>>
>>
> 

