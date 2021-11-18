Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB499C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A01261107
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A01261107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC966E985;
	Thu, 18 Nov 2021 14:11:59 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97216E985
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:11:57 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id n29so11785204wra.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 06:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=evD4+1AvRbroZe6eKPmjf+b8XzxHmn8yByT+iln4cE8=;
 b=hx+b2RSp4H1P2J+qNZ2TvHFLRtasky4j0Yhs/pzXSZpB3AWnFzj9FO1Hrt4I4Bf/kj
 YV8W+M5+AUJsZT2XCm5WsXjeXHODfnSEiN4A2tRLNjAfu28d3YDjdcmZerZZ21S8bfuH
 /YZiey/Ra2jsN98znvkTXszlDDZarGkOZfkr5PIVxpTH8VdFjQvbpCbgdlpWc1c2GTwS
 Cdn3HMF7rFPd4kjaO/ovNOp46kpGX1uyvnodvjkO2XCcE1+ZVu3R1X7vH9LU/UjLKPon
 5Zbp5iJ1Hpdl5Cbp8gvOesIuGPTOxgrGv/qn6F5P0C725MNZNrxLQf4H94B+Q+mNAMq1
 bEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=evD4+1AvRbroZe6eKPmjf+b8XzxHmn8yByT+iln4cE8=;
 b=rcYCxCTXTr82Yf7pDOvsMgPT5W8VMnKiKNG9byGCdhlx9XFNH82m1AAIDp37t8bFwH
 zdDf6lRzoJzJhU7oYkKtHHNrYBTsVajHiszjDd+BqTZvC9irFs/AVsd0edDao9ZJExXZ
 sXZuxb1FbBIHIR5h9EkUVgdi41Jt8oaSdOxBLq5uHWQ2K+lWqw0fs2emuR3ISLItFAJD
 iV64+/BD46+zw0VnY6TKck37e18JyZMYOVy3eNOSLCiSTsrfNif4iKwdG9cyXtOhWS1k
 Q2hO5WPaKEXI6rUbhfMgdo/TVj/ytHdHjjnaopm2ejLFwWQA4iAcbAzTwS6oDICP1+iL
 QNQw==
X-Gm-Message-State: AOAM531FPGFVu9fHtJuAMOVwmB7C1roFvu1lAIsqzoQROBWIubHJJzI3
 jr1jsCQIM1r0LAWDjL85W3pGGRlCDCU=
X-Google-Smtp-Source: ABdhPJxhprLXh48VP2ZStwndnzhOPyNQRi8qBbxYVtNBSi22DJPFfcGaHcljB9n+KjM+FwW3so3ofw==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr32714901wrj.325.1637244716497; 
 Thu, 18 Nov 2021 06:11:56 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id p62sm3186974wmp.10.2021.11.18.06.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Nov 2021 06:11:56 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 "Liang, Prike" <Prike.Liang@amd.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
Date: Thu, 18 Nov 2021 15:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.11.21 um 15:09 schrieb Lazar, Lijo:
> On 11/18/2021 7:36 PM, Alex Deucher wrote:
>> On Thu, Nov 18, 2021 at 8:11 AM Liang, Prike <Prike.Liang@amd.com> 
>> wrote:
>>>
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, November 18, 2021 4:01 PM
>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend
>>>> aborted
>>>>
>>>>
>>>>
>>>> On 11/18/2021 12:32 PM, Prike Liang wrote:
>>>>> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu
>>>>> suspend to keep AMDGPU in a clean reset state and that can avoid
>>>>> re-initialize device improperly error.
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19
>>>> +++++++++++++++++++
>>>>>    3 files changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index b85b67a..8bd9833 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1053,6 +1053,7 @@ struct amdgpu_device {
>>>>>      bool                            in_s3;
>>>>>      bool                            in_s4;
>>>>>      bool                            in_s0ix;
>>>>> +   bool                            pm_completed;
>>>>
>>>> PM framework maintains separate flags, why not use the same?
>>>>
>>>>           dev->power.is_suspended = false;
>>>>           dev->power.is_noirq_suspended = false;
>>>>           dev->power.is_late_suspended = false;
>>>>
>>>
>>> Thanks for pointing it out and I miss that flag. In this case we can 
>>> use the PM flag is_noirq_suspended for checking AMDGPU device 
>>> whether is finished suspend.
>>>
>>>> BTW, Alex posted a patch which does similar thing, though it tries 
>>>> reset if
>>>> suspend fails.
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FDM6PR12MB26195F8E099407B4B6966FEBE4999%40&amp;data=04%7C01%7CLijo.Lazar%40amd.com%7C6401dce9411b4c134b0208d9aa9ca644%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637728412055353107%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Z4dgNvHISHVlR4grHm1RU3%2FJMJVdRe7Ukq1DnjCgG0o%3D&amp;reserved=0 
>>>>
>>>> DM6PR12MB2619.namprd12.prod.outlook.com/
>>>>
>>>> If that reset also failed, then no point in another reset, or keep 
>>>> it as part of
>>>> resume.
>>>>
>>>
>>> Alex's patch seems always do the ASIC reset at the end of AMDGPU 
>>> device, but that may needn't on the normal AMDGPU device suspend. 
>>> However, this patch shows that can handle the system suspend aborted 
>>> after AMDGPU suspend case well, so now seems we only need take care 
>>> suspend abort case here.
>>>
>>
>> Yeah, I was thinking we'd take this patch rather than mine to minimize
>> the number of resets.
>>
>
> Wondering if suspend fails whether there is a need to call resume. It 
> may not get to resume() to do a reset, that needs to be checked.

I would rather do it so that we reset the ASIC during resume when we 
detect that the hardware is in a bad state.

This way it should also work with things like kexec and virtualization.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>
>> Alex
>>
>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>
>>>>>      atomic_t                        in_gpu_reset;
>>>>>      enum pp_mp1_state               mp1_state;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index ec42a6f..a12ed54 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device
>>>> *dev, bool fbcon)
>>>>>      if (adev->in_s0ix)
>>>>>              amdgpu_gfx_state_change_set(adev,
>>>> sGpuChangeState_D0Entry);
>>>>>
>>>>> +   if (!adev->pm_completed) {
>>>>> +           dev_warn(adev->dev, "suspend aborted will do asic 
>>>>> reset\n");
>>>>> +           amdgpu_asic_reset(adev);
>>>>> +   }
>>>>>      /* post card */
>>>>>      if (amdgpu_device_need_post(adev)) {
>>>>>              r = amdgpu_device_asic_init(adev); diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index eee3cf8..9f90017 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct
>>>> device *dev)
>>>>>      return r;
>>>>>    }
>>>>>
>>>>> +/*
>>>>> + * Actually the PM suspend whether is completed should be confirmed
>>>>> + * by checking the sysfs
>>>>> +sys/power/suspend_stats/failed_suspend.However,
>>>>> + * in this function only check the AMDGPU device whether is 
>>>>> suspended
>>>>> + * completely in the system-wide suspend process.
>>>>> + */
>>>>> +static int amdgpu_pmops_noirq_suspend(struct device *dev) {
>>>>> +   struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>> +   struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>> +
>>>>> +   dev_dbg(dev, "amdgpu suspend completely.\n");
>>>>> +   adev->pm_completed = true;
>>>>> +
>>>>> +   return 0;
>>>>> +}
>>>>> +
>>>>>    static int amdgpu_pmops_resume(struct device *dev)
>>>>>    {
>>>>>      struct drm_device *drm_dev = dev_get_drvdata(dev); @@ -2181,6
>>>>> +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>>>>>      r = amdgpu_device_resume(drm_dev, true);
>>>>>      if (amdgpu_acpi_is_s0ix_active(adev))
>>>>>              adev->in_s0ix = false;
>>>>> +   adev->pm_completed = false;
>>>>>      return r;
>>>>>    }
>>>>>
>>>>> @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops
>>>> = {
>>>>>      .runtime_suspend = amdgpu_pmops_runtime_suspend,
>>>>>      .runtime_resume = amdgpu_pmops_runtime_resume,
>>>>>      .runtime_idle = amdgpu_pmops_runtime_idle,
>>>>> +   .suspend_noirq = amdgpu_pmops_noirq_suspend,
>>>>>    };
>>>>>
>>>>>    static int amdgpu_flush(struct file *f, fl_owner_t id)
>>>>>

