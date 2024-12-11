Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED04CE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 20:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED9110EC0F;
	Wed, 11 Dec 2024 20:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HVwC/H8U";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BCF10E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 20:19:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B69C55C53FB;
 Wed, 11 Dec 2024 20:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C71C4CED2;
 Wed, 11 Dec 2024 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733948374;
 bh=e7akgBVWU6iasIyUJ8piqQIP4O1YOKxs2TiPqTTyjtQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HVwC/H8UFUUhm2H3KnBIrERJ75ldwrXBEeXJ13h1iGdPnVcfuCJ4P8s/J2k4cFGX6
 faVjHTC/5TRO4V5hVFwD9ygUQmcJH8L62e4/ot4ERWXjTqOMGxYmUP4uKxBFxVp8K4
 B+zRSW1jx5vXLcV6MiHLkBoDhN4XH1bOT+z/u0vc+30UdEjv7X9uYVleRaBgZhhhb+
 5JtmvHyt+nzrlAHbl3/kZzl89MN/U+LCS7z51N/pbP9uOEKpIM55rDhk/6d04lsX5C
 7MG56ofs9meyTwVh0jpi2Z0erfgF4lIHi66EwVfceJeYw4P9z/Tz2eB9aWgEhEHx6g
 jK9GqX1vor+Yg==
Message-ID: <820bc463-80d7-4121-837d-b620bfa67575@kernel.org>
Date: Wed, 11 Dec 2024 14:19:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Require CONFIG_HOTPLUG_PCI_PCIE for BOCO
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Gabriel Marcano <gabemarcano@yahoo.com>
References: <20241211155601.3585256-1-superm1@kernel.org>
 <CADnq5_PxZP4fgMcuD0xD3m2Y3_kbOV_wK4Qq4GzGHJB_9wxepQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_PxZP4fgMcuD0xD3m2Y3_kbOV_wK4Qq4GzGHJB_9wxepQ@mail.gmail.com>
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

On 12/11/2024 14:08, Alex Deucher wrote:
> On Wed, Dec 11, 2024 at 10:56 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If the kernel hasn't been compiled with PCIe hotplug support this
>> can lead to problems with dGPUs that use BOCO because they effectively
>> drop off the bus.
>>
>> To prevent issues, disable BOCO support when compiled without PCIe hotplug.
>>
>> Reported-by: Gabriel Marcano <gabemarcano@yahoo.com>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707#note_2696862
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thx.

> 
> Seems like this should affect any device which supports d3cold.  Maybe
> we want something more general as well?

Any specific ideas?  One of these two hunks I think make sense, leaning 
upon the second one more strongly.
  
  
  
                                   diff --git a/drivers/pci/pci.c 
b/drivers/pci/pci.c
index 0b29ec6e8e5e2..01691f1d26fbe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2751,6 +2751,10 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
         if (target_state == PCI_POWER_ERROR)
                 return -EIO;

+       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
+           target_state == PCI_D3cold)
+               return -EBUSY;
+
         pci_enable_wake(dev, target_state, wakeup);

         error = pci_set_power_state(dev, target_state);
@@ -2797,6 +2801,10 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
         if (target_state == PCI_POWER_ERROR)
                 return -EIO;

+       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
+            target_state == PCI_D3cold)
+               return -EBUSY;
+
         __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));

         error = pci_set_power_state(dev, target_state);
> 
> Alex
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 764d41434a82f..7db796ebb967e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -419,6 +419,9 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
>>   {
>>          struct amdgpu_device *adev = drm_to_adev(dev);
>>
>> +       if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>> +               return false;
>> +
>>          if (adev->has_pr3 ||
>>              ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>>                  return true;
>> --
>> 2.43.0
>>

