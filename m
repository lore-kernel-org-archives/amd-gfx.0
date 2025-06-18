Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B30C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 13:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC3F10E832;
	Wed, 18 Jun 2025 13:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vwh1769G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9985710E836
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 13:35:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CC6444CC0;
 Wed, 18 Jun 2025 13:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A65CC4CEE7;
 Wed, 18 Jun 2025 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750253698;
 bh=ny1NDbdkUXe0G54cgyu+9Iqir8capZn8xavcC2FhdO4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Vwh1769Ga9sD2rrkx1K2RhZXe4OUiFF8SFZBpjz4c6SqeoOiZNK9AmnPpDo/eG1K+
 PoVwHZNpxc55+2he8zkdTQRSqyaz4g4O8vRZvk5v6rjeP/MoytNGF+HkAAiMy7GHLI
 9MXjZRPVACCcSCKBfsbJkCyT8f9ZK/zjXkXQhqxovTaEaQuJZ3QNZ6XQQw/uKtf+a6
 ZstsklCxLqSy7kK4NYdvvr2zEkkRDebNonrHZlXxsr7qJcIIt0Uum08ybrQxEGiDTA
 GQhrY5wg+FvmdCx2Yw1PNAD4aFE3wa2eXifW7KgxL4S/uPiuXzfofU5VabAQzV8T/S
 jS4M+WHF8Zaag==
Message-ID: <83550401-b2ae-4165-84b2-4f9343d3d1ed@kernel.org>
Date: Wed, 18 Jun 2025 08:34:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <f474345d-78f6-424b-8c0f-584c5f0c162d@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f474345d-78f6-424b-8c0f-584c5f0c162d@amd.com>
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

On 6/18/2025 4:05 AM, Christian König wrote:
> On 6/18/25 10:51, Peter Zijlstra wrote:
>> On Tue, Jun 17, 2025 at 09:12:12PM -0500, Mario Limonciello wrote:
>>
>>> How about if we reset before the kexec?  There is a symbol for drivers to
>>> use to know they're about to go through kexec to do $THINGS.
>>>
>>> Something like this:
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 0fc0eeedc6461..2b1216b14d618 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -34,6 +34,7 @@
>>>
>>>   #include <linux/cc_platform.h>
>>>   #include <linux/dynamic_debug.h>
>>> +#include <linux/kexec.h>
>>>   #include <linux/module.h>
>>>   #include <linux/mmu_notifier.h>
>>>   #include <linux/pm_runtime.h>
>>> @@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>>                  adev->mp1_state = PP_MP1_STATE_UNLOAD;
>>>          amdgpu_device_ip_suspend(adev);
>>>          adev->mp1_state = PP_MP1_STATE_NONE;
>>> +
>>> +       if (kexec_in_progress)
>>> +               amdgpu_asic_reset(adev);
>>>   }
>>>
>>>   static int amdgpu_pmops_prepare(struct device *dev)
>>
>> I will throw this in the dev kernel... I'll let you know.
> 
> Mhm if the drivers are informed about the kexec

It looks like PeterZ found the symbol isn't exported; but that's not to 
say it "can't be" if it fixes this issue.

> then we could also send the unload/reset packet only to the PSP IIRC.
> 
> That might have a better chance of succeeding than a full ASIC reset.
> 
> Lijo should know more about that.
> 
> Regards,
> Christian.

Another idea is to do a FLR on the way down.
