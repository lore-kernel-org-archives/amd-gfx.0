Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F7C3601B
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 19:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C339A10EA70;
	Thu,  3 Apr 2025 19:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzMp+0U3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AFC10EA70
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 19:13:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2662D6115B;
 Thu,  3 Apr 2025 19:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7253AC4CEE3;
 Thu,  3 Apr 2025 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743707606;
 bh=9j3X8cYbJPnTM2hu/v71mN4UAwTCxjDANzgCOndh1UA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TzMp+0U3SUwU3bR39ckNl5FBcD5h/TEITrpo10f8tPRLMknosmoVrdyi3xGPa0BEP
 8eVuAOrecrDashabYVnSk4UHM4ONISkvHx4KDxxcKmVHZkxkY1m6Xcmv1lDNzB1UKr
 iqutjt3EJhexjjmpj+7RtbkivlXJKRBj5GpIV/UZavDhDI7Je23pRTGVV2p9x3a/Gw
 9Pced2DIxAieBiYbBqI8auLWmpVMPfFQPd5Rm/n4xGkgGZcf5HUUWkVip8FgA9zkWx
 UnhHeTSbMTqQh9BatWpdqiKdRV3xYOrMRjkagSy6B1kW21Tks4p39aji4BqyUVfRmV
 IAN5xBs1AGaRA==
Message-ID: <1d762b4d-3aae-4fad-b464-d1baa124e86e@kernel.org>
Date: Thu, 3 Apr 2025 14:13:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Add pre-zen AMD hardware to PCIe dynamic
 switching exclusions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250403031148.1266785-1-superm1@kernel.org>
 <CADnq5_Nz76WBm8wsU8k4LUpXrjKk6AbJfYV0CpaV3sXAJ2McEQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_Nz76WBm8wsU8k4LUpXrjKk6AbJfYV0CpaV3sXAJ2McEQ@mail.gmail.com>
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

On 4/3/2025 10:48 AM, Alex Deucher wrote:
> On Wed, Apr 2, 2025 at 11:12 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> AMD RX580 when added AMD Phenom 2 has problems with overheating. This is due to
> 
> I don't think this is entirely accurate.  I think the GPU gets hot
> because the device hangs due to a problem with changing the PCIe
> clocks.
> 
>> changes with PCIe dynamic switching introduced by commit 466a7d115326e
>> ("drm/amd: Use the first non-dGPU PCI device for BW limits").
>>
>> To avoid risks of other issues with old hardware require at least Zen hardware
>> for AMD side to enable PCIe dynamic switching.
> 
> I'm pretty sure PCIe reclocking worked on pre-Zen hardware.  We've
> supported this on our GPUs going back at least 15 or more years.  I
> suspect the actual problem is that some links may not reliably train
> at the full bandwidth on some motherboards.  Forcing a higher link
> speed may cause problems.  

That seems odd to me it would advertise a higher link speed than it 
could train at.

> Maybe it would be better to limit the max
> PCIe link rate to whatever the link is currently trained to.  IIRC,
> PCIe links will train at the fastest link possible by default.  The
> previous behavior was to limit the max clock to the slowest link in
> the topology to save power, but then we changed it to use the fastest
> link possible based on the PCIe link caps.  Perhaps limiting it to the
> fastest currently trained link rate would be better.

I mean that's essentially what happens when 
amdgpu_device_pcie_dynamic_switching_supported() returns that it doesn't 
work.

If your theory is right; maybe what we really need is a pile of DMI 
quirks for M/B that are having this problem.

> 
> Alex
> 
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
>> Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Cover more hardware
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a30111d2c3ea0..caa44ee788c8f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1854,6 +1854,9 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>>    *
>>    * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
>>    * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
>> + *
>> + * AMD Phenom II X6 1090T has a similar issue
>> + * https://gitlab.freedesktop.org/drm/amd/-/issues/4098
>>    */
>>   static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
>>   {
>> @@ -1866,6 +1869,8 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
>>
>>          if (c->x86_vendor == X86_VENDOR_INTEL)
>>                  return false;
>> +       if (c->x86_vendor == X86_VENDOR_AMD && !cpu_feature_enabled(X86_FEATURE_ZEN))
>> +               return false;
>>   #endif
>>          return true;
>>   }
>> --
>> 2.43.0
>>

