Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2BCD2CE17
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 02:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB85D10E051;
	Mon,  8 Dec 2025 02:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ykp1DUCp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8282F10E051
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 02:38:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 59EC1600AD;
 Mon,  8 Dec 2025 02:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B43C4CEFB;
 Mon,  8 Dec 2025 02:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765161507;
 bh=8LFv0PRXw9XH5Gb2dTKrppsGrbVq/GAvQ1QQKJHZJeg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ykp1DUCpuyqQ8anLHo/nLmXng0kjHCpBxl6NB0yOcH+JJk2Pxw8lVmrYCCyw44DgZ
 +99ZkpExQDLdfkGiSDiKSgorkQ68cmd32DjZDR+V8TazvoDrNbqYS1l9bZuZFCbQJQ
 Cdjjhl9I7p8ei65hYrl7vUA+RpSlJvJWqUANkFS63JFDFfZhQmrFdS2zV8uvruD+Zs
 myt7VPdzG+98JybI9/bxN/kxUFBENogqWXswMx05QNcK7KiE3NwozvVShExxCKZfAG
 IJPeZwrBq70qs00qFF04UDPCjqAIF+EyR9xMX7b1fAmZwOHUkO6QZlUkUyosbj1AA+
 aC2y72MSxUxwg==
Message-ID: <0abcb636-e36f-4f1a-9d6d-051c3c36d4dd@kernel.org>
Date: Sun, 7 Dec 2025 20:38:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Runtime suspend for APUs
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: amd-gfx@lists.freedesktop.org
References: <20251207194910.122711-1-superm1@kernel.org>
 <CAGwozwFXvHJY_WOZXjBWhoFTt1rcsLX=1n5p49=S2HyF+EvdHQ@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAGwozwFXvHJY_WOZXjBWhoFTt1rcsLX=1n5p49=S2HyF+EvdHQ@mail.gmail.com>
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



On 12/7/2025 4:05 PM, Antheas Kapenekakis wrote:
> On Sun, 7 Dec 2025 at 20:49, Mario Limonciello (AMD) <superm1@kernel.org> wrote:
>>
>> Set up APUs to follow similar policies as dGPUs in that they can
>> potentially runtime suspend.  If an APU is runtime suspended then
>> prepare it for the matching system state (s0ix or s3) so that steps
>> can be skipped when runtime suspended.
>>
>> The thought with this series is that if the compositor has turned
>> off displays and no other work is running an APU's GPU can enter
>> runtime PM. If the system later enters system suspend the GPU steps
>> can be skipped because the GPU is already in the runtime PM state
>> to match the intended system state.
> 
> The compositor or a game probably has assets on the GPU. If they are
> frozen, would the amdgpu driver be able to suspend?

I'd expect so at least for some workloads.  This is why we're able to 
enter GFXOFF at runtime, the various rings are idle.

And if they're working like I'd expect any sort of GFX work, display 
work, or reading a sensor will wake it back up.

But by all means try the patch and see what happens.

> 
>> It's important to note that default runtime PM policy will prevent
>> entering runtime PM when displays are connected. This can be changed
>> by setting amdgpu.runpm=-2.
>>
>> This series isn't yet tested, I just share it for feedback on
>> the approach. If anyone wants to test it as well, please feel free.
>>
>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>>
>> Mario Limonciello (AMD) (1):
>>    drm/amd: Expand runtime suspend to APUs
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 +++++++++++++++--
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
>>   3 files changed, 22 insertions(+), 2 deletions(-)
>>
>> --
>> 2.43.0
>>
>>
> 

