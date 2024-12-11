Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C71E77182
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 22:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBE810EC3E;
	Wed, 11 Dec 2024 22:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TWTfE5vB";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029A110EC3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 22:18:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D9DD5A41BEC;
 Wed, 11 Dec 2024 22:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A05C4CED3;
 Wed, 11 Dec 2024 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733955502;
 bh=AsZ7V/Y18SibOhPW26jhuFIgp4B3tATw5ndo9vloKpc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TWTfE5vBhmPxp7Rl23XEs2yMumqNa6GHvAOIJ+vNwAQwnFOX3GakTdsnMShiAGaRZ
 RKXtSbdMBEW/NnkLT7lUMQkJhwc7m8HZb3zbGtWTSZ9eh6Tffh4BlM535w33V+XKHB
 NlNCT2ECPrSufDlENu2AKPUO2CbIiBmBwtZZYf3i/TD4aH5fLaOFnFJhTHS99gvpbK
 gDSdqq/4Lra+UItbvLx2pPq/qGDs6HcdLLxLO5o/Qr3tNcxjGynXJ6O4M6w2JYPFNO
 Ci4C1zuDHmeQGjgXOzIgCuIRKwIhiP+BLgYW9TR/pGmQJwAbqcPk8BnQ1NQitSi2LP
 VzpxrqfBfxBlQ==
Message-ID: <4855aec4-b008-40f1-af75-9134035428da@kernel.org>
Date: Wed, 11 Dec 2024 16:18:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Require CONFIG_HOTPLUG_PCI_PCIE for BOCO
To: Gabriel Marcano <gabemarcano@yahoo.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20241211155601.3585256-1-superm1@kernel.org>
 <CADnq5_PxZP4fgMcuD0xD3m2Y3_kbOV_wK4Qq4GzGHJB_9wxepQ@mail.gmail.com>
 <820bc463-80d7-4121-837d-b620bfa67575@kernel.org>
 <CADnq5_ORSYTV1yLXhmWvaxwi_F9QfOWMzjzFHFrNvF5DCjZ_xQ@mail.gmail.com>
 <848196f8-2318-4a69-8e1c-7f534bbdb00d@kernel.org>
 <530881126.1281723.1733955365060@mail.yahoo.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <530881126.1281723.1733955365060@mail.yahoo.com>
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

On 12/11/2024 16:16, Gabriel Marcano wrote:
>   >On 12/11/2024 15:41, Alex Deucher wrote:
>>> On Wed, Dec 11, 2024 at 3:19â€¯PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 12/11/2024 14:08, Alex Deucher wrote:
>>>>> On Wed, Dec 11, 2024 at 10:56â€¯AM Mario Limonciello <superm1@kernel.org> wrote:
>>>>>>
>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> If the kernel hasn't been compiled with PCIe hotplug support this
>>>>>> can lead to problems with dGPUs that use BOCO because they effectively
>>>>>> drop off the bus.
>>>>>>
>>>>>> To prevent issues, disable BOCO support when compiled without PCIe hotplug.
>>>>>>
>>>>>> Reported-by: Gabriel Marcano <gabemarcano@yahoo.com>
>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707#note_2696862
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> Thx.
>>>>
>>>>>
>>>>> Seems like this should affect any device which supports d3cold.  Maybe
>>>>> we want something more general as well?
>>>>
>>>> Any specific ideas?  One of these two hunks I think make sense, leaning
>>>> upon the second one more strongly.
>>>   
>>> Actually, I wonder if the affected hardware pre-dates d3cold and uses
>>> the old proprietary AMD ATPX interface to control dGPU power.  In that
>>> case, the d3cold is managed by the driver rather than the PCI/ACPI
>>> subsystems.  IIRC, there was a workaround in the PCIe hotplug code to
>>> avoid calling the pci remove function when the driver powered down the
>>> GPU via ATPX (or the nvidia equivalent).  If so, this check should go
>>> in amdgpu_device_supports_px() instead.
>>
>> Gabriel,
>>
>> Can you please share a full kernel log so we can clarify which method
>> your hardware uses?
>>
> 
> Sure thing. I am attaching a kernel output from last night (it actually crashed
> what looks to be the renoir APU as I tried to turn off the computer, which
> shows up in the logs towards the end).
> 
> Some caveats about my system:
>   - I'm using some modified ACPI tables:
>     - I've tweaked some WMI-related WMAX code (read/write GPIO for RGB controller)
>     - I've fixed a missing symbol issue (renamed _EC0 to __EC)
>     - Fixed a bunch of other warnings reported by iasl
>   - I have `#define DEBUG 1` in amdgpu_drv.c
>   - I have a patch from https://bugzilla.kernel.org/show_bug.cgi?id=215884
>     applied
>   - My kernel is using Gentoo patches
> 
> Looking at my dmesg output, it looks like I'm using ATPX:
> [  +0.000022] amdgpu: vga_switcheroo: detected switching method
>                        \_SB_.PCI0.GP17.VGA_.ATPX handle
> [  +0.001561] amdgpu: ATPX version 1, functions 0x00000001
> [  +0.000120] amdgpu: ATPX Hybrid Graphics
> 
> Also I see this in my ACPI table dissasembly:
>    Scope (\_SB.PCI0.GP17.VGA)
>    {
>        Name (M189, Buffer (0x0100){})
>        Name (M190, Ones)
>        Name (M191, Ones)
>        Method (ATPX, 2, Serialized)
>        {
> 
> 
> If you need me to recompile the kernel and/or disable my changes to my ACPI
> tables, let me know.

Your log also reports this though:

amdgpu 0000:03:00.0: amdgpu: Using BOCO for runtime pm


> 
> Thanks,
> 
> Gabriel
> 
> 
>> Thanks,
>>>   
>>> Alex
>>>   
>>>>
>>>>
>>>>
>>>>                                      diff --git a/drivers/pci/pci.c
>>>> b/drivers/pci/pci.c
>>>> index 0b29ec6e8e5e2..01691f1d26fbe 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -2751,6 +2751,10 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>>>>            if (target_state == PCI_POWER_ERROR)
>>>>                    return -EIO;
>>>>
>>>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
>>>> +           target_state == PCI_D3cold)
>>>> +               return -EBUSY;
>>>> +
>>>>            pci_enable_wake(dev, target_state, wakeup);
>>>>
>>>>            error = pci_set_power_state(dev, target_state);
>>>> @@ -2797,6 +2801,10 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>>>>            if (target_state == PCI_POWER_ERROR)
>>>>                    return -EIO;
>>>>
>>>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
>>>> +            target_state == PCI_D3cold)
>>>> +               return -EBUSY;
>>>> +
>>>>            __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>>>>
>>>>            error = pci_set_power_state(dev, target_state);
>>>>>
>>>>> Alex
>>>>>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 764d41434a82f..7db796ebb967e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -419,6 +419,9 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
>>>>>>     {
>>>>>>            struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>>
>>>>>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>>>>>> +               return false;
>>>>>> +
>>>>>>            if (adev->has_pr3 ||
>>>>>>                ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>>>>>>                    return true;
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>
> 
> 

