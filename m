Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D4C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 13:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DCC10E824;
	Wed, 18 Jun 2025 13:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NfS8DAhC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23BA10E824
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 13:35:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E0012629FD;
 Wed, 18 Jun 2025 13:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B857C4CEE7;
 Wed, 18 Jun 2025 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750253732;
 bh=fTN4qp+NU0OBbVUR8V46tMmeMKZ3neGu0ibB9pow9sY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NfS8DAhCYl4c6FqYRpK9QZPysIaWVsiwVAOox4d4106o2Q0tx2I8eqLKR1aWs8Ghd
 Fkws8bU02EYg843bZYvetpQaG0gOJBYd0PllMtpkCBdo7uCFGQqz/OTvEu2FwHL5no
 vbAoBPOiQvnCyZJP7ZhlZg6daMqCw6QxyHpU3HYtjs2zCH9D6OWkMnsRkIfew9cBme
 fwXKMkNSm7rCy95oKprfcvjb9JXVFA3lXJRjzlAdTR3hXE2yWmGZwQo3s0HaqEF9uc
 s+IyIi4lxgwb9DpahNR8QSBnJIZZ7PnPZMcPDs08gne02a4JQCUNbpMOgwo7jvwFZ5
 ycb0VCfqk2M4w==
Message-ID: <423aec58-0ab2-4471-b986-dfb955e63ca8@kernel.org>
Date: Wed, 18 Jun 2025 08:35:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Peter Zijlstra <peterz@infradead.org>, bhe@redhat.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <20250618091232.GD1613633@noisy.programming.kicks-ass.net>
 <20250618092625.GE1613633@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250618092625.GE1613633@noisy.programming.kicks-ass.net>
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

On 6/18/2025 4:26 AM, Peter Zijlstra wrote:
> On Wed, Jun 18, 2025 at 11:12:32AM +0200, Peter Zijlstra wrote:
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
> Bah, so first kexec after a fresh reboot into a kernel carrying this has
> the thing failing.
> 

Dang, too bad.
