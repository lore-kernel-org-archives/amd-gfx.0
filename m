Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A41C7115A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 13:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB7510EA4F;
	Thu, 19 Jun 2025 13:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f3l6NJAF";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F4410EA4F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 13:33:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E62AC5C67BC;
 Thu, 19 Jun 2025 13:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80283C4CEEA;
 Thu, 19 Jun 2025 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750339980;
 bh=GMwXOeaXWN2v406169klXQK2DYMrtEo7oWJPyzBqDh4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=f3l6NJAFSS/9KxXJbiDU4FwkQTNKQa3DO9ARNdbNm+U9nnimhkcNTzCVvqhYANdL3
 Rat73/nO2axMM+MsspeJ04DKs1pCe8lKRwdWTjuCM/iYj89PYeEZbkgrPXUmWbFiFJ
 bmkdX7xJkRCX4nLLKrqM9SzeX4ZI3I1z/sT3taRCfnqm1NLxoZ7dJzVDrwHI9y/l07
 yNjM4RYRicUlLHNJJqU4rFhtkp0d+Rl4wptFObdjnIvJp5gqnjG19DwjdviHQ9KGoV
 c70lh4UpQxysenteVbBjbbEY7icRkFQjN0AY5XDPt3rScq+5m1kIbLOcURRRqXxBJG
 lAzVOgiH8Gbzw==
Message-ID: <35ab7037-6195-40cd-9d3f-8e5870402f4d@kernel.org>
Date: Thu, 19 Jun 2025 08:32:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
 <aFNR4E/4CR1b/MsG@MiWiFi-R3L-srv>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFNR4E/4CR1b/MsG@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/18/2025 6:55 PM, Baoquan He wrote:
> On 06/18/25 at 11:12am, Peter Zijlstra wrote:
>> On Wed, Jun 18, 2025 at 10:51:23AM +0200, Peter Zijlstra wrote:
>>> On Tue, Jun 17, 2025 at 09:12:12PM -0500, Mario Limonciello wrote:
>>>
>>>> How about if we reset before the kexec?  There is a symbol for drivers to
>>>> use to know they're about to go through kexec to do $THINGS.
>>>>
>>>> Something like this:
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 0fc0eeedc6461..2b1216b14d618 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -34,6 +34,7 @@
>>>>
>>>>   #include <linux/cc_platform.h>
>>>>   #include <linux/dynamic_debug.h>
>>>> +#include <linux/kexec.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/mmu_notifier.h>
>>>>   #include <linux/pm_runtime.h>
>>>> @@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>>>                  adev->mp1_state = PP_MP1_STATE_UNLOAD;
>>>>          amdgpu_device_ip_suspend(adev);
>>>>          adev->mp1_state = PP_MP1_STATE_NONE;
>>>> +
>>>> +       if (kexec_in_progress)
>>>> +               amdgpu_asic_reset(adev);
>>>>   }
>>>>
>>>>   static int amdgpu_pmops_prepare(struct device *dev)
>>>
>>> I will throw this in the dev kernel... I'll let you know.
>>
>> First hurdle appears to be that this symbol is not exported. I fixed
>> that, but perhaps the kexec folks don't like drivers to use this?
> 
> I can't find the original mail of this thread, while we don't have a
> known restriction about that afaik.
> 

FYI here's the whole thread:

https://lore.kernel.org/amd-gfx/423aec58-0ab2-4471-b986-dfb955e63ca8@kernel.org/T/#m68bea029aac9b7ec015a26a8dfb8268ffb007125


