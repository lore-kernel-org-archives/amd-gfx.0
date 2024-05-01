Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7122C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 07:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD75F10EE7D;
	Thu,  2 May 2024 07:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="N1UNH22x";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9434F10F062
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C3NPh9sSeUwwr4Bpa6AMKHit2ez04Fx3ZDsMYpiO/Ow=; b=N1UNH22xl+M0wncHI0SuiNOH5v
 s9AZAu6bPNzOLrOKUj/FUiV5Rx23ecOZf2INdTfKc8CjRSBcL5v7GtHCimc/lp3o2VszyA2Y8bESa
 Z/Xd8lyCgGAilTwVVHTHheW6swwK6HZ4f3+lYDYUU/TlxbU3VAtqwBrdRjjGVGAxRY8ocutvId17P
 sBh+6xlD1UK/yIUtVrlPWkW8+pWnFMrp8WYTTwKiwNXR/KZ2TxZKBTGUXbi7b/gZWZ96nfo7iPnwS
 G9iXzTU6dQwpIJO0Z74ig+m8exYScGlpY/WKkelKJc4ulFQWj81XwRo7kLMd514qXhU9+BYkp8/mQ
 uHmsH64A==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s29zU-002a4T-73; Wed, 01 May 2024 15:27:19 +0200
Message-ID: <cd9f1e27-2448-4803-ab73-9b71c5482027@igalia.com>
Date: Wed, 1 May 2024 14:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] Add capacity key to fdinfo
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>, Tvrtko Ursulin <tursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20240430172748.61576-1-tursulin@igalia.com>
 <CADnq5_Mzn8gesfqfNncJMWGgawFR3upgcy9MG=UwHw4i5GoZTg@mail.gmail.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CADnq5_Mzn8gesfqfNncJMWGgawFR3upgcy9MG=UwHw4i5GoZTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 May 2024 07:49:06 +0000
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


Hi Alex,

On 30/04/2024 19:32, Alex Deucher wrote:
> On Tue, Apr 30, 2024 at 1:27 PM Tvrtko Ursulin <tursulin@igalia.com> wrote:
>>
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> I have noticed AMD GPUs can have more than one "engine" (ring?) of the same type
>> but amdgpu is not reporting that in fdinfo using the capacity engine tag.
>>
>> This series is therefore an attempt to improve that, but only an RFC since it is
>> quite likely I got stuff wrong on the first attempt. Or if not wrong it may not
>> be very beneficial in AMDs case.
>>
>> So I tried to figure out how to count and store the number of instances of an
>> "engine" type and spotted that could perhaps be used in more than one place in
>> the driver. I was more than a little bit confused by the ip_instance and uapi
>> rings, then how rings are selected to context entities internally. Anyway..
>> hopefully it is a simple enough series to easily spot any such large misses.
>>
>> End result should be that, assuming two "engine" instances, one fully loaded and
>> one idle will only report client using 50% of that engine type.
> 
> That would only be true if there are multiple instantiations of the IP
> on the chip which in most cases is not true.  In most cases there is
> one instance of the IP that can be fed from multiple rings.  E.g. for
> graphics and compute, all of the rings ultimately feed into the same
> compute units on the chip.  So if you have a gfx ring and a compute
> rings, you can schedule work to them asynchronously, but ultimately
> whether they execute serially or in parallel depends on the actual
> shader code in the command buffers and the extent to which it can
> utilize the available compute units in the shader cores.

This is the same as with Intel/i915. Fdinfo is not intended to provide 
utilisation of EUs and such, just how busy are the "entities" kernel 
submits to. So doing something like in this series would make the 
reporting more similar between the two drivers.

I think both the 0-800% or 0-100% range (taking 8 ring compute as an 
example) can be misleading for different workloads. Neither <800% in the 
former means one can send more work and same for <100% in the latter.

There is also a parallel with the CPU world here and hyper threading, if 
not wider, where "What does 100% actually mean?" is also wishy-washy.

Also note that the reporting of actual time based values in fdinfo would 
not changing with this series.

Of if you can guide me towards how to distinguish real vs fake 
parallelism in HW IP blocks I could modify the series to only add 
capacity tags where there are truly independent blocks. That would be 
different from i915 though were I did not bother with that distinction. 
(For reasons that assignment of for instance EUs to compute "rings" 
(command streamers in i915) was supposed to be possible to re-configure 
on the fly. So it did not make sense to try and be super smart in fdinfo.)

> As for the UAPI portion of this, we generally expose a limited number
> of rings to user space and then we use the GPU scheduler to load
> balance between all of the available rings of a type to try and
> extract as much parallelism as we can.

The part I do not understand is the purpose of the ring argument in for 
instance drm_amdgpu_cs_chunk_ib. It appears userspace can create up to N 
scheduling entities using different ring id's, but internally they can 
map to 1:N same scheduler instances (depending on IP type, can be that 
each userspace ring maps to same N hw rings, or for rings with no drm 
sched load balancing userspace ring also does not appear to have a 
relation to the picked drm sched instance.).

So I neither understand how this ring is useful, or how it does not 
create a problem for IP types which use drm_sched_pick_best. It appears 
even if userspace created two scheduling entities with different ring 
ids they could randomly map to same drm sched aka same hw ring, no?

Regards,

Tvrtko

> Alex
> 
> 
>>
>> Tvrtko Ursulin (5):
>>    drm/amdgpu: Cache number of rings per hw ip type
>>    drm/amdgpu: Use cached number of rings from the AMDGPU_INFO_HW_IP_INFO
>>      ioctl
>>    drm/amdgpu: Skip not present rings in amdgpu_ctx_mgr_usage
>>    drm/amdgpu: Show engine capacity in fdinfo
>>    drm/amdgpu: Only show VRAM in fdinfo if it exists
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 39 +++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 62 +++-------------------
>>   5 files changed, 49 insertions(+), 70 deletions(-)
>>
>> --
>> 2.44.0
