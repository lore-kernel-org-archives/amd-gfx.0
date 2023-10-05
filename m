Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C5E93709
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 12:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE2F10E3EA;
	Thu,  5 Oct 2023 12:35:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4893B10E3EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 12:35:32 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so7918665e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696509330; x=1697114130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=biIu/4jgtH/OcCpT+Eszru+Vj7fpbs4jyDrT9wTPaXo=;
 b=jp1s34I7bqfFWippdXJGN6gFSS0s9r88nf3ojKFCVIlld2XRMNKWiQYfES6RNJQMuR
 Bafuggqc6XX2HhJAOI0znFeecNYdzlN9kueujQpphlaOTng34DxMS4KcJjrfJYJiI+Bo
 sw8KBc0HtMYuUlf/RSjATiscKNisK8twcBH4r9E6VSkUc3DD6Qs3Emv8ztar57sMCom4
 Pk7OFS9phMLNeZO8uxjJXjrNk28sn3s/3NbsJp3okebaUhxatfAfqPXvz8y9ckAivhe9
 cgf7SZkbMYaHfUAaREmzdfD9lzrYLgRdkF/88edz/Rm2ZC6HBHGIFOab3CDmBLlFSgMs
 Vyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696509330; x=1697114130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=biIu/4jgtH/OcCpT+Eszru+Vj7fpbs4jyDrT9wTPaXo=;
 b=me+0KbGDU1kMXnS8rt6gbAkBleGTH1RH/RM7i3XqPHxvcOtrdS0fY0LqUJdW6OaCV6
 1hgsxX2dOXleXiYilObSs3FfNI/7YwcfKsJW3KM95POH7SCVffiCwxk+zgRqFXaCVzTr
 zxYskpT5EpVx16PqsPTIcVWjaqNiHKKflmEAB/Nvd7ekGfl6gYtaBGPmSRaIE3hhTDVh
 tjWXAXSuwecch163a1HKuhVgzQ03Ve47wm/NmoOj++PNGJALUUh+d23y4SU++lOFp3aC
 lwmi3eVgOK0GWUgOKy0n0la0mfiLSoXIhueD3zEd7t27FYrv3bW5rPCwGDsD1hsxvFD7
 Amkw==
X-Gm-Message-State: AOJu0Ywlcxm1d/EXbBqZ+ozqWb2hxcu5NXVWTnFB2z43/2GtmBmTj45k
 ObGOGFWWwzWh13L/kVvOhu8=
X-Google-Smtp-Source: AGHT+IG6832ALlAzDKbz05dmt5cT1gHHzaJVnTs/vJrQvFYz1LUEl+TDBWOLg/ahAayH8gHDwWmgBw==
X-Received: by 2002:a05:600c:b4b:b0:405:3b1f:968b with SMTP id
 k11-20020a05600c0b4b00b004053b1f968bmr4802193wmr.21.1696509330349; 
 Thu, 05 Oct 2023 05:35:30 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j35-20020a05600c1c2300b003fe15ac0934sm966112wms.1.2023.10.05.05.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 05:35:29 -0700 (PDT)
Message-ID: <4f7f21f3-d5b0-46b6-81f2-36dc354b25cd@gmail.com>
Date: Thu, 5 Oct 2023 14:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
 <20231003205437.123426-2-mario.limonciello@amd.com>
 <BL1PR12MB51447D279FB7F5AA88D328D2F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <3683532b-0dd8-4f0d-b1a6-a0a209bc295f@amd.com>
 <BL1PR12MB5144BAB16898B3A5644B3676F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <40f4b67e-a482-4dae-9af8-a365d3198157@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <40f4b67e-a482-4dae-9af8-a365d3198157@amd.com>
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.10.23 um 05:39 schrieb Mario Limonciello:
> On 10/3/2023 16:22, Deucher, Alexander wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Sent: Tuesday, October 3, 2023 5:17 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: Wentland, Harry <Harry.Wentland@amd.com>
>>> Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and
>>> complete() callbacks
>>>
>>> On 10/3/2023 16:11, Deucher, Alexander wrote:
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>> Mario Limonciello
>>>>> Sent: Tuesday, October 3, 2023 4:55 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
>>>>> <Mario.Limonciello@amd.com>
>>>>> Subject: [PATCH v3 1/4] drm/amd: Add support for prepare() and
>>>>> complete() callbacks
>>>>>
>>>>> Linux PM core has a prepare() callback run before suspend and
>>>>> complete() callback ran after resume() for devices to use.  Add
>>>>> plumbing to bring
>>>>> prepare() to amdgpu.
>>>>>
>>>>> The idea with the new vfuncs for amdgpu is that all IP blocks that
>>>>> memory allocations during suspend should do the allocation from this
>>>>> call instead of the suspend() callback.
>>>>>
>>>>> By moving the allocations to prepare() the system suspend will be
>>>>> failed before any IP block has done any suspend code.
>>>>>
>>>>> If the suspend fails, then do any cleanups in the complete() 
>>>>> callback.
>>>>>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
>>>>> ++++++++++++++++++++--
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++---
>>>>>    3 files changed, 46 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index 73e825d20259..5d651552822c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1415,6 +1415,8 @@ void amdgpu_driver_postclose_kms(struct
>>>>> drm_device *dev,  void amdgpu_driver_release_kms(struct drm_device
>>>>> *dev);
>>>>>
>>>>>    int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>>>>> +int amdgpu_device_prepare(struct drm_device *dev); void
>>>>> +amdgpu_device_complete(struct drm_device *dev);
>>>>>    int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);  
>>>>> int
>>>>> amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>>>>>    u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc); diff
>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index bad2b5577e96..f53cf675c3ce 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4259,6 +4259,43 @@ static int
>>>>> amdgpu_device_evict_resources(struct
>>>>> amdgpu_device *adev)
>>>>>    /*
>>>>>     * Suspend & resume.
>>>>>     */
>>>>> +/**
>>>>> + * amdgpu_device_prepare - prepare for device suspend
>>>>> + *
>>>>> + * @dev: drm dev pointer
>>>>> + *
>>>>> + * Prepare to put the hw in the suspend state (all asics).
>>>>> + * Returns 0 for success or an error on failure.
>>>>> + * Called at driver suspend.
>>>>> + */
>>>>> +int amdgpu_device_prepare(struct drm_device *dev) {
>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>> +     int r;
>>>>> +
>>>>> +     if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>> +             return 0;
>>>>> +
>>>>> +     adev->in_suspend = true;
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_device_complete - complete the device after resume
>>>>> + *
>>>>> + * @dev: drm dev pointer
>>>>> + *
>>>>> + * Clean up any actions that the prepare step did.
>>>>> + * Called after driver resume.
>>>>> + */
>>>>> +void amdgpu_device_complete(struct drm_device *dev) {
>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>> +
>>>>> +     adev->in_suspend = false;
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * amdgpu_device_suspend - initiate device suspend
>>>>>     *
>>>>> @@ -4277,8 +4314,6 @@ int amdgpu_device_suspend(struct drm_device
>>>>> *dev, bool fbcon)
>>>>>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>>                 return 0;
>>>>>
>>>>> -     adev->in_suspend = true;
>>>>> -
>>>>
>>>> We also set this to false in amdgpu_device_resume() so that should 
>>>> be fixed
>>> up as well.  But, I'm not sure we want to move this out of
>>> amdgpu_device_suspend().  There are places we use
>>> amdgpu_device_suspend/resume() outside of pmops that also rely on these
>>> being set.  Those places may need to be fixed up if we do. IIRC, the 
>>> switcheroo
>>> code uses this.
>>>
>>> The big reason that I moved it from suspend() to prepare() was so that
>>> amdgpu_device_evict_resources() was called with the context of it 
>>> being set.
>>>
>>> My thought process:
>>> 0) prepare() sets all the time
>>> 1) If prepare() fails complete() clears it.
>>> 2) If prepare() succeeds it remains set for suspend()
>>> 3) If suspend() succeeds it gets cleared at resume()
>>> 4) If resume() failed for some reason, it's cleared by complete().
>>>
>>> Does it actually matter that it's set while evicting resources?
>>
>> Shouldn't matter for evicting resources.  We even have debugfs nodes 
>> you can access to forcibly evict resources at runtime for testing 
>> memory pressure.
>
> Then in that case I think what I'll do is put an extra call for 
> amdgpu_device_evict_resources() in the prepare callback.
>
> It shouldn't do any harm to call three times in the suspend sequence 
> instead of two.

Yeah, I think you should move the first call from suspend to prepare.

Evacuating VRAM doesn't rely at all on the suspend flag, but the second 
evacuation only works after we turned of the hardware.

Regards,
Christian.

>
>>
>> Alex
>>
>>> If so, maybe I'll just have both prepare() and suspend() set it 
>>> universally and
>>> both resume() and complete() clear it universally.
>>>
>>>
>>>>
>>>> Alex
>>>>
>>>>>         /* Evict the majority of BOs before grabbing the full 
>>>>> access */
>>>>>         r = amdgpu_device_evict_resources(adev);
>>>>>         if (r)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index e3471293846f..4c6fb852516a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device
>>>>> *dev)
>>>>>         /* Return a positive number here so
>>>>>          * DPM_FLAG_SMART_SUSPEND works properly
>>>>>          */
>>>>> -     if (amdgpu_device_supports_boco(drm_dev))
>>>>> -             return pm_runtime_suspended(dev);
>>>>> +     if (amdgpu_device_supports_boco(drm_dev) &&
>>>>> +         pm_runtime_suspended(dev))
>>>>> +             return 1;
>>>>>
>>>>>         /* if we will not support s3 or s2i for the device
>>>>>          *  then skip suspend
>>>>> @@ -2435,12 +2436,14 @@ static int amdgpu_pmops_prepare(struct
>>> device
>>>>> *dev)
>>>>>             !amdgpu_acpi_is_s3_active(adev))
>>>>>                 return 1;
>>>>>
>>>>> -     return 0;
>>>>> +     return amdgpu_device_prepare(drm_dev);
>>>>>    }
>>>>>
>>>>>    static void amdgpu_pmops_complete(struct device *dev) {
>>>>> -     /* nothing to do */
>>>>> +     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>> +
>>>>> +     amdgpu_device_complete(drm_dev);
>>>>>    }
>>>>>
>>>>>    static int amdgpu_pmops_suspend(struct device *dev)
>>>>> -- 
>>>>> 2.34.1
>>>>
>>
>

