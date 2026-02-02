Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99680E7DEFB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 16:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367D410E51D;
	Mon,  2 Feb 2026 16:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WxqihVcg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05E310E51D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 16:11:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EB15D600B0;
 Mon,  2 Feb 2026 16:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3873AC116C6;
 Mon,  2 Feb 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770048663;
 bh=u9zzblW4tRxJxcmoMTGOIkYc4jE8VQm/Vyry0RSB8SI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WxqihVcgdI+zyjAwCiV0wuFGxfCfNcD+Za5K8Gyh+6nRbfoRKfYy9+2VkrEBi2IJb
 nG0EW6iPIUJSWzAkbMiAJrHSo4PUmlLEeichgT40tk77+Ss967kbbQOKko2rQyOr2G
 ww9qh+a6qnM9g8QHWdz6lURYEAAwztBIW7AkNVcr7c7eAG1osPOUx0OjdbmB4THN9S
 Gqwq7Aifzd8d93xx5BkxaN6pnkcqDcqE+XsX85Vg49BaXk1DpxpuEa8yCgT6bX1atV
 eT+TCeHwaUoa1AMysozYpxYrxOcaAVZiPSpmbeMirLs3GvKRixyuhe4jtxWVLh2wRd
 0WG+gD2fshJbQ==
Message-ID: <2a3a3d4f-efa2-46e5-8fee-f51cf12812a9@kernel.org>
Date: Mon, 2 Feb 2026 10:11:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd: Check if ASPM is enabled from PCIe
 subsystem"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260201002446.1293486-1-spasswolf@web.de>
 <02fe7f9e-f25b-4b6b-8420-57de982147bd@kernel.org>
 <b978d83d-3bd2-4ef0-8a2c-eb756a880fa4@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <b978d83d-3bd2-4ef0-8a2c-eb756a880fa4@amd.com>
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

On 2/2/26 8:35 AM, Christian König wrote:
> On 2/2/26 15:25, Mario Limonciello wrote:
>> On 1/31/26 6:24 PM, Bert Karwatzki wrote:
>>> This reverts commit 7294863a6f01248d72b61d38478978d638641bee.
>>>
>>> This commit was erroneously applied again after commit 0ab5d711ec74
>>> ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
>>> removed it, leading to very hard to debug crashes, when used with a system with two
>>> AMD GPUs of which only one supports ASPM.
>>>
>>> Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@web.de/
>>> Link: https://github.com/acpica/acpica/issues/1060
>>> Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
>>>
>>> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>>> ---
>>
>> Amazing detective work, thanks so much.
>>
>> This added the code initially:
>> cba07cce39ace drm/amd: Check if ASPM is enabled from PCIe subsystem
>>
>> This effectively removed it:
>> 0ab5d711ec74d drm/amd: Refactor `amdgpu_aspm` to be evaluated per device
>>
>> This was the accidental re-apply:
>> 7294863a6f012 drm/amd: Check if ASPM is enabled from PCIe subsystem
>>
>> It looks like this as right on the edge of the 5.17-rc6 and 5.18-rc1.
>> I think drm-fixes-2022-02-25 and amd-drm-next-5.18-2022-02-25 ended up with different content.
>>
>> Nonethless this is the correct change and I've applied it to amd-staging-drm-next.
>>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> There is just one major question left: Why is disabling ASPM causing problems?
> 

My theory is that it's a mismatch of PCIe core and AMDGPU.  IE if the 
PCIe core thinks it's enabled but amdgpu thinks it is disabled can hit 
some corner scenarios.

> I mean we had tons of problems with ASPM before, but only by accidentally enabling it and never accidentally disabling it.
> 
> IIRC we even suggested to disable ASPM as possible workaround.
> 
> Thanks,
> Christian.
> 
>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index d6d0a6e34c6b..95d26f086d54 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2405,9 +2405,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>>                return -ENODEV;
>>>        }
>>>    -    if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
>>> -        amdgpu_aspm = 0;
>>> -
>>>        if (amdgpu_virtual_display ||
>>>            amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
>>>            supports_atomic = true;
>>
> 

