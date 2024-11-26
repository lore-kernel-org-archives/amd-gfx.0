Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E84CD3B9AC
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 16:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024EB10E912;
	Tue, 26 Nov 2024 16:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lQJuxr1i";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E7C10E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 16:09:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1F3255C570B;
 Tue, 26 Nov 2024 16:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453A3C4CECF;
 Tue, 26 Nov 2024 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732637358;
 bh=K5pdTyPbCInvqM9CluiRbmxEwWAzxbac8uEDfP0qmso=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lQJuxr1igYXv7nqqYxgQOizXQUV+GnIPVizx9EwHo6iwdvLjUxZILK0muMfWnm57o
 VIWzPu/BlwC8p1IDmheyru1JAolWBQKXKVEK0+KSi+CGu8ZhIw+YRvsklsoXerzrST
 c/TXqRb3cz2Rv4yjAeXPF/0wl+kPhIkTCjI17ylA/sjPGQMQcDRE+iuRewuLRURlwt
 /BATLzYz83JRucakLxv+p3ndvRgXuZrUsBquMiALTEL6/EbMxR0w+B+lfltrBS3mj+
 8cTcUUAOnksz9m+x0ECTXTPasogIcSGK+i4+NuBGAvFcvuM8nyUl3vYhe2+W7SgG/n
 2eq0dgFUc9O7w==
Message-ID: <5684bb94-f48b-4d55-bd1f-6fbace51ad30@kernel.org>
Date: Tue, 26 Nov 2024 10:09:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amd: Add Suspend/Hibernate notification
 callback support
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20241124190001.2633591-1-superm1@kernel.org>
 <20241124190001.2633591-2-superm1@kernel.org>
 <2ab89895-64a3-45fa-b6a9-37407ef6e3ab@amd.com>
 <4c939f50-a1c0-4476-9a16-ced6e6102aa2@kernel.org>
 <0cce0ffc-2844-4fbb-9f8f-76d812d2936d@amd.com>
 <bb6af227-6e20-4e9c-b105-74b7bb44f435@kernel.org>
 <414f787a-9e39-43de-a1be-9b4e3a62ed03@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <414f787a-9e39-43de-a1be-9b4e3a62ed03@amd.com>
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



On 11/26/24 09:37, Lazar, Lijo wrote:
> 
> 
> On 11/26/2024 7:50 PM, Mario Limonciello wrote:
>>>>> Based on https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>>>
>>>>> What if this callback takes care only of suspend case and leaves the
>>>>> hibernate case to dpm_prepare callback?
>>>>
>>>> Then hibernate would fail under memory pressure.
>>>>
>>>> My take is this failure with hibernate is a userspace problem (whether
>>>> userspace decides to freeze the tasks or not).  I think it's better that
>>>> we /try/ to do the eviction and notify them if userspace should be
>>>> changed.
>>>>
>>>
>>> Hmm, the logic is kind of inconsistent now.
>>>
>>> For dGPUs, evict is required for s0ix, s3, s4 and attempted twice.
>>> For APUs, evict is required for s4, but attempted only once.
>>
>> Well the logic was inconsistent before already.
>>
>> But FWIW it will still be attempted a second time for APUs.
>> The call sequence is:
>>
>> 1) PM notifier
>> amdgpu_device_pm_notifier()
>> ->amdgpu_device_evict_resources()
>>
>> Eviction for dGPU and APU in S4.
>>
>> 2) Prepare callback
>> amdgpu_pmops_prepare()
>> ->amdgpu_device_prepare()
>> ->->amdgpu_device_evict_resources()
>>
>> Eviction for dGPU only.
>>
>> 3) Suspend callback
>> amdgpu_pmops_freeze()
>> ->amdgpu_device_suspend()
>> ->->amdgpu_device_evict_resources()
>>
>> Eviction for dGPU and APU in S4.
>>
>> So yes it's incongruent that prepare() doesn't include APU S4, but the
>> problem is you won't know at prepare() time whether it's S4 AFAICT.
>>
>> Or is there way to tell at prepare() for S4?
>>
> Now this notifier comes in before that and tells that right?
> 

Oh yeah, it does!

In that case we can set adev-in_s4 during the PM notifier and keep it 
set unless there is a failure during prepare().

> BTW, I didn't realize that there is a max of 3 attempts now (didn't
> notice it being called in suspend also).

Yeah, there are other reasons suspend callback gets called so it's 
better to keep that sequence identical.

> 
> Thanks,
> Lijo
> 
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>> +    case PM_SUSPEND_PREPARE:
>>>>>> +        r = amdgpu_device_evict_resources(adev);
>>>>>> +        adev->in_s4 = false;
>>>>>> +        /*
>>>>>> +         * This is considered non-fatal at thie time because
>>>>>> +         * amdgpu_device_prepare() will also evict resources.
>>>>>> +         * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>>>> +         */
>>>>>> +        if (r)
>>>>>> +            drm_warn(adev_to_drm(adev), "Failed to evict resources,
>>>>>> freeze active processes if problems occur\n");
>>>>>> +        break;
>>>>>> +    }
>>>>>> +
>>>>>> +    return NOTIFY_DONE;
>>>>>> +}
>>>>>> +
>>>>>>     /**
>>>>>>      * amdgpu_device_prepare - prepare for device suspend
>>>>>>      *
>>>>>
>>>>
>>>
>>
> 

