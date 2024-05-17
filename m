Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBC1C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 13:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F5010EEC1;
	Fri, 17 May 2024 13:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mH1Y0wB0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3065D10EE13;
 Fri, 17 May 2024 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FK3NFrTqmL6xVJnwLX6zLDv0aAR69KaCPCpyjlw0hJo=; b=mH1Y0wB0Qe5FJP4DjKJ8ZF1sJe
 4PcmAoz3bdpCgCVHWpRG7h4/J0eYiY4Q0oKGAF3/70HyrGIFMOGhIlGs7VguC/evRCH1zPbT+xr+G
 wU9ACvHsi1ufv4WtQLmkOaj8kMy2DlafdCrCzsv8tYLZ2qzp6U+MrUO0SRk2VwDrav9iRyOPe0jSd
 pMQ+5gc/YZrt2GdOu3O8qV8KZvtbz9RMHIy6mBqYNA7IyU4I9ZgULbtjznlLkWoZFb6ifcK+2oVfJ
 8rTamp7ed8L1iGfQoRxqhVUL87lhAzEOjw8A9R0VzL5uYI7IhyZjZ8xRqnW+PjTYtjAuge8tvyMkv
 1+LNlt3g==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s7sDN-009AvW-Ds; Fri, 17 May 2024 09:41:17 +0200
Message-ID: <4cfb94e4-8f15-4b7f-8911-60298da3edb7@igalia.com>
Date: Fri, 17 May 2024 08:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] Discussion around eviction improvements
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>, Tvrtko Ursulin <tursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Friedrich Vock <friedrich.vock@gmx.de>
References: <20240516121822.19036-1-tursulin@igalia.com>
 <CADnq5_PhZ5bqEJKQ+bPQAeXihMfZrFVqLN-+nd69+zZooBT6BA@mail.gmail.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CADnq5_PhZ5bqEJKQ+bPQAeXihMfZrFVqLN-+nd69+zZooBT6BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 13:36:59 +0000
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


On 16/05/2024 20:21, Alex Deucher wrote:
> On Thu, May 16, 2024 at 8:18 AM Tvrtko Ursulin <tursulin@igalia.com> wrote:
>>
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Reduced re-spin of my previous series after Christian corrected a few
>> misconceptions that I had. So lets see if what remains makes sense or is still
>> misguided.
>>
>> To summarise, the series address the following two issues:
>>
>>   * Migration rate limiting does not work, at least not for the common case
>>     where userspace configures VRAM+GTT. It thinks it can stop migration attempts
>>     by playing with bo->allowed_domains vs bo->preferred domains but, both from
>>     the code, and from empirical experiments, I see that not working at all. When
>>     both masks are identical fiddling with them achieves nothing. Even when they
>>     are not identical allowed has a fallback GTT placement which means that when
>>     over the migration budget ttm_bo_validate with bo->allowed_domains can cause
>>     migration from GTT to VRAM.
>>
>>   * Driver thinks it will be re-validating evicted buffers on the next submission
>>     but it does not for the very common case of VRAM+GTT because it only checks
>>     if current placement is *none* of the preferred placements.
> 
> For APUs at least, we should never migrate because GTT and VRAM are
> both system memory so are effectively equal performance-wise.  Maybe

I was curious about this but thought there could be a reason why VRAM 
carve-out is a fix small-ish size. It cannot be made 1:1 with RAM or 
some other solution?

> this regressed when Christian reworked ttm to better handle migrating
> buffers back to VRAM after suspend on dGPUs?

I will leave this to Christian to answer but for what this series is 
concerned I'd say it is orthogonal to that.

Here we have two fixes not limited to APU use cases, just so it happens 
fixing the migration throttling improves things there too. And that even 
despite the first patch which triggering *more* migration attempts. 
Because the second patch then correctly curbs them.

First patch should help with transient overcommit on discrete, allowing 
things get back into VRAM as soon as there is space.

Second patch tries to makes migration throttling work as intended.

Volunteers for testing on discrete? :)

>>
>> These two patches appear to have a positive result for a memory intensive game
>> like Assassin's Creed Valhalla. On an APU like Steam Deck the game has a working
>> set around 5 GiB, while the VRAM is configured to 1 GiB. Correctly respecting
>> the migration budget appears to keep buffer blits at bay and improves the
>> minimum frame rate, ie. makes things smoother.
>>
>>  From the game's built-in benchmark, average of three runs each:
>>
>>                                                  FPS
>>                  migrated KiB    min     avg     max     min-1%  min-0.1%
>>    because          20784781     10.00  37.00   89.67    22.00    12.33
>>    patched           4227688     13.67  37.00   81.33    23.33    15.00

Hmm! s/because/before/ here obviously!

Regards,

Tvrtko

>> Disclaimers that I have is that more runs would be needed to be more confident
>> about the results. And more games. And APU versus discrete.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>
>> Tvrtko Ursulin (2):
>>    drm/amdgpu: Re-validate evicted buffers
>>    drm/amdgpu: Actually respect buffer migration budget
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 112 +++++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  21 ++++-
>>   2 files changed, 103 insertions(+), 30 deletions(-)
>>
>> --
>> 2.44.0
>>
