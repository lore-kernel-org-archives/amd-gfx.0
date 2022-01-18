Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2565C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 11:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F322B10E2E6;
	Tue, 18 Jan 2022 11:02:03 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CD110E21B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 11:02:03 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id p18so26753351wmg.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=okoM9A3gRzhSejhUTpbkz+FjCkmHgk5/xQg59OCNVGc=;
 b=Ge7Y8uQEU2JbEQ4vRHrMoBHuLLyJzZCqYgKqPNMPj2jSUYft43TJiXEBIt2OHu62LZ
 YGX1vhFPjVJRA1T4fIfmnZi4G8fJhYYzb85IhCAKfNrQmWCglp9HikxBpOC+TATSkA/0
 qXLbv/E/nTPrcKT6JuyYI8pEP6oXvAaLFkRCi+HMtKN515sKnoDVd/ziN2J62l9vDNCs
 B+IPg9L/2xtGQlpbH216e+7j7oak8llSnC5gy2iOGseIRlLU4AY1uMFkvp/LNHjnMg3i
 6/GNfhna/QaFxzR62Tg9QvWsjJAvyk0bTptRWiXlFiSk0L9UsVWY75DBUtaTuYpq6RdM
 0buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=okoM9A3gRzhSejhUTpbkz+FjCkmHgk5/xQg59OCNVGc=;
 b=Bqyu+UkaKKuhDCdPZg0DrabI4LI++BRjSaS7Vfl6zQE6Rkrn51bAoAhIMvmh9Wb3JI
 mrI8v2b8zXolcyffTJmSPusNQuCXXuCMuaRpW9lgvd8bl9AUKHs5ZmLdACP6KKvziffM
 IrWAKJYYbq6IqiifiIEJJGlkeh8Yh1cc9fkVvyGSRneDNH/tH+0BrFlToryCOymyKjKE
 5ZiaPslsxD5L/tgeJkkLSojsXruw95aIqeAIhqN0Hds4f4zmFGhPqTcSSPY7ocPoph58
 feM7+l5bCX6NEzht+Xd1gWWTHf8od0GFLLkG5d/Lf/Pl+O5M8IqY6RcKK4ybbsJM8y5x
 BsyA==
X-Gm-Message-State: AOAM530DQjv20hSJe+eFG8cwmeBDFyoZ6ed3XFMidt7H9pPktuI4k7D+
 I6Fvt8+FkVf+b/+/RQ0QLjU=
X-Google-Smtp-Source: ABdhPJxalS1D2of5jPuVAzL9oJp8kSID2iLZ+SftPapLvDHCTWhtM3NaPrpoLrzi1USzWiz8bQo/og==
X-Received: by 2002:a1c:98d0:: with SMTP id
 a199mr14260611wme.130.1642503721906; 
 Tue, 18 Jan 2022 03:02:01 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:6333:dba2:34ad:c3d6?
 ([2a02:908:1252:fb60:6333:dba2:34ad:c3d6])
 by smtp.gmail.com with ESMTPSA id l13sm4736284wrs.107.2022.01.18.03.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 03:02:01 -0800 (PST)
Subject: Re: [PATCH 3/3] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: "S, Shirish" <sshankar@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111071219.5638-1-Amaranath.Somalapuram@amd.com>
 <1b35f6db-d101-519f-aac9-f30380fbcb34@amd.com>
 <f10b8279-fce1-ca17-b6dd-0108e4d1793c@amd.com>
 <2b0607e9-8f83-a0e0-3e4b-f6b796e5e308@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4cb348ec-c68e-36c7-9be2-390f5a31a5f9@gmail.com>
Date: Tue, 18 Jan 2022 12:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2b0607e9-8f83-a0e0-3e4b-f6b796e5e308@amd.com>
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.01.22 um 11:40 schrieb S, Shirish:
> Hi Shashank,
>
>
> On 1/12/2022 6:30 PM, Sharma, Shashank wrote:
>>
>>
>> On 1/11/2022 12:26 PM, Christian König wrote:
>>> Am 11.01.22 um 08:12 schrieb Somalapuram Amaranath:
>>>> AMDGPURESET uevent added to notify userspace,
>>>> collect dump_stack and amdgpu_reset_reg_dumps
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/nv.c | 31 +++++++++++++++++++++++++++++++
>>>>   1 file changed, 31 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> index 2ec1ffb36b1f..41a2c37e825f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -529,10 +529,41 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>>>       }
>>>>   }
>>>> +/**
>>>> + * drm_sysfs_reset_event - generate a DRM uevent
>>>> + * @dev: DRM device
>>>> + *
>>>> + * Send a uevent for the DRM device specified by @dev. Currently 
>>>> we only
>>>> + * set AMDGPURESET=1 in the uevent environment, but this could be 
>>>> expanded to
>>>> + * deal with other types of events.
>>>> + *
>>>> + * Any new uapi should be using the 
>>>> drm_sysfs_connector_status_event()
>>>> + * for uevents on connector status change.
>>>> + */
>>>> +void drm_sysfs_reset_event(struct drm_device *dev)
>>>> +{
>>>> +    char *event_string = "AMDGPURESET=1";
>>>> +    char *envp[2] = { event_string, NULL };
>>>> +
>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>
>>> That won't work like this.
>>>
>>> kobject_uevent_env() needs to allocate memory to send the event to 
>>> userspace and that is not allowed while we do an reset. The Intel 
>>> guys felt into the same trap already.
>>>
>>> What we could maybe do is to teach kobject_uevent_env() gfp flags 
>>> and make all allocations from the atomic pool.
>>>
>>> Regards,
>>> Christian.
>>
>> Hi Amar,
>>
>> I see another problem here,
>>
>> We are sending the event at the GPU reset, but we are collecting the 
>> register values only when the corresponding userspace agent calls a 
>> read() on the respective sysfs entry.
>
> Is the presumption here that gpu reset is always triggered within 
> kernel & user space has to be made aware of it?

Yes, pretty much.

>
> From what I know OS'/apps use GL extensions like robustness and other 
> ways to detect hangs/gpu resets and flush out guilty contexts or take 
> approp next steps.
>
> BTW, is there any userspace infra already in place that have a 
> task/thread listening  for reset events implemented, similar to hpd?

No, it's also completely different to HPD since we need to gather and 
save prerecorded data of the crash.

>
> I believe there are several ways to make user space aware of reset via 
> gpu_reset_counter etc, also if the objective is the have call trace 
> upon reset or dump registers you can do it in the 
> amdgpu_device_gpu_recover() but guard it with a proper CONFIG
>
> that can be enabled in kernel's debug builds only, like tag along with 
> KASAN etc.,
>
> This way there will be lesser dependency on userspace.

That's a really bad idea. Gathering crash dump data should work on 
production kernels as well and is nothing we really need a compiler 
switch for.

Regards,
Christian.

>
>
> Regards,
>
> Shirish S
>
>>
>> There is a very fair possibility that the register values are reset 
>> by the HW by then, and we are reading re-programmed values. At least 
>> there will be a race().
>>
>> I think we should change this design in such a way:
>> 1. Get into gpu_reset()
>> 2. collect the register values and save this context into a separate 
>> file/node. Probably sending a trace_event here would be easiest way.
>> 3. Send the drm event to the userspace client
>> 4. The client reads from the trace file, and gets the data.
>>
>> - Shashank
>>
>>>
>>>> +}
>>>> +
>>>> +void amdgpu_reset_dumps(struct amdgpu_device *adev)
>>>> +{
>>>> +    struct drm_device *ddev = adev_to_drm(adev);
>>>> +    /* original raven doesn't have full asic reset */
>>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>>> +        return;
>>>> +    drm_sysfs_reset_event(ddev);
>>>> +    dump_stack();
>>>> +}
>>>> +
>>>>   static int nv_asic_reset(struct amdgpu_device *adev)
>>>>   {
>>>>       int ret = 0;
>>>> +    amdgpu_reset_dumps(adev);
>>>>       switch (nv_asic_reset_method(adev)) {
>>>>       case AMD_RESET_METHOD_PCI:
>>>>           dev_info(adev->dev, "PCI reset\n");
>>>

