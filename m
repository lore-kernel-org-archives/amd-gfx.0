Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED570D3B994
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 14:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AEB10E3F2;
	Tue, 26 Nov 2024 14:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eZk2wDSp";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FC310E3F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 14:20:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7CAFD5C5BE4;
 Tue, 26 Nov 2024 14:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C0CC4CED0;
 Tue, 26 Nov 2024 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732630842;
 bh=Kazu7CBwLzTS51Fu9xb+0tDAbcwnEQCDZDNUNTAG/F8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eZk2wDSp6hNbvgCErc2MnSsfOuQhMakB+6AA9x+krZ//VazzGD01u8Bv534E/sWPC
 dXLZ/1U2tTfxIgScMUbL8WGr3/6Fe563YUB/WXw+GBZGljv+Ul19rtzsiVECZnEvFZ
 RcYA/Zk6NXytAswGyBtzr8O4OerD1DepTt7c/ssz/wcPo7vfj6x3vMtiurEmKgKxd3
 A0OkTs6NlCDhnbKhbermC3ixdXSpOsZSX9sPudefOo2hh7fJCSAP+YVUzLFERzoiD9
 J9Gub9rtFf8LjkrKznCGaWDbPp7c6UzzdONIVoeakOVs9T9pS3NZCIcwaSsZsiuVdE
 Bk5QXJg8DfwEg==
Message-ID: <bb6af227-6e20-4e9c-b105-74b7bb44f435@kernel.org>
Date: Tue, 26 Nov 2024 08:20:40 -0600
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <0cce0ffc-2844-4fbb-9f8f-76d812d2936d@amd.com>
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

>>> Based on https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>
>>> What if this callback takes care only of suspend case and leaves the
>>> hibernate case to dpm_prepare callback?
>>
>> Then hibernate would fail under memory pressure.
>>
>> My take is this failure with hibernate is a userspace problem (whether
>> userspace decides to freeze the tasks or not).  I think it's better that
>> we /try/ to do the eviction and notify them if userspace should be changed.
>>
> 
> Hmm, the logic is kind of inconsistent now.
> 
> For dGPUs, evict is required for s0ix, s3, s4 and attempted twice.
> For APUs, evict is required for s4, but attempted only once.

Well the logic was inconsistent before already.

But FWIW it will still be attempted a second time for APUs.
The call sequence is:

1) PM notifier
amdgpu_device_pm_notifier()
->amdgpu_device_evict_resources()

Eviction for dGPU and APU in S4.

2) Prepare callback
amdgpu_pmops_prepare()
->amdgpu_device_prepare()
->->amdgpu_device_evict_resources()

Eviction for dGPU only.

3) Suspend callback
amdgpu_pmops_freeze()
->amdgpu_device_suspend()
->->amdgpu_device_evict_resources()

Eviction for dGPU and APU in S4.

So yes it's incongruent that prepare() doesn't include APU S4, but the 
problem is you won't know at prepare() time whether it's S4 AFAICT.

Or is there way to tell at prepare() for S4?

> 
> Thanks,
> Lijo
> 
>>>
>>> Thanks,
>>> Lijo
>>>> +    case PM_SUSPEND_PREPARE:
>>>> +        r = amdgpu_device_evict_resources(adev);
>>>> +        adev->in_s4 = false;
>>>> +        /*
>>>> +         * This is considered non-fatal at thie time because
>>>> +         * amdgpu_device_prepare() will also evict resources.
>>>> +         * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>> +         */
>>>> +        if (r)
>>>> +            drm_warn(adev_to_drm(adev), "Failed to evict resources,
>>>> freeze active processes if problems occur\n");
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    return NOTIFY_DONE;
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_prepare - prepare for device suspend
>>>>     *
>>>
>>
> 

