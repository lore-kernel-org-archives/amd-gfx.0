Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C26BC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 13:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA09112A18;
	Fri,  3 May 2024 13:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="afFPAeHk";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D26B10FB5C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BgSebzIp5z5dFSKU4ESbdPnAazQZ1+CqANvokfHfKRk=; b=afFPAeHkTruBXrjem0Fopi5VBK
 T3TXKLrH2pglhOqZfWHvGZbEMi6tABJ8b/r1ajzugbEBotBtrkIvMoTvtvPugDuuG0cBo/HCgbliy
 4YpLTnxY1hO8huHkkzcNIOE02tgmRxx+E8uIdh3+JK+iGENbpLHJTb88I0Ou/SYqMTQzrOK13k61V
 adr+iOtXGbuahWxqHzDBsMxM7RqPb9zWa4T9FQ145l8LNrg1y4DSi5YgdI6kn/3Jxbm95cYxe/nns
 kjOrkNTj2wRaViajl1CCU06+h/U1xyY5R5aW3uOXuJOz+PWqikzxTqkrC39OmvJQokjEnw6GrXEal
 uB+vJhGg==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s2rQw-0006VQ-LO; Fri, 03 May 2024 13:50:35 +0200
Message-ID: <3030b87c-120b-4ef1-b0f9-9a1a7ef62e70@igalia.com>
Date: Fri, 3 May 2024 12:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] Add capacity key to fdinfo
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20240430172748.61576-1-tursulin@igalia.com>
 <CADnq5_Mzn8gesfqfNncJMWGgawFR3upgcy9MG=UwHw4i5GoZTg@mail.gmail.com>
 <cd9f1e27-2448-4803-ab73-9b71c5482027@igalia.com>
 <eae2f6bb-6c6f-4a85-a0dd-ad1898d638b5@gmail.com>
 <51a28e5c-392f-4093-9782-a81849474034@igalia.com>
 <CADnq5_PYN-QBx1VB7tTgpFsBqgrLKBNsOwGaG7u8TSXw539sjA@mail.gmail.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CADnq5_PYN-QBx1VB7tTgpFsBqgrLKBNsOwGaG7u8TSXw539sjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 May 2024 13:10:22 +0000
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


On 02/05/2024 16:00, Alex Deucher wrote:
> On Thu, May 2, 2024 at 10:43 AM Tvrtko Ursulin
> <tvrtko.ursulin@igalia.com> wrote:
>>
>>
>> On 02/05/2024 14:07, Christian König wrote:
>>> Am 01.05.24 um 15:27 schrieb Tvrtko Ursulin:
>>>>
>>>> Hi Alex,
>>>>
>>>> On 30/04/2024 19:32, Alex Deucher wrote:
>>>>> On Tue, Apr 30, 2024 at 1:27 PM Tvrtko Ursulin <tursulin@igalia.com>
>>>>> wrote:
>>>>>>
>>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>
>>>>>> I have noticed AMD GPUs can have more than one "engine" (ring?) of
>>>>>> the same type
>>>>>> but amdgpu is not reporting that in fdinfo using the capacity engine
>>>>>> tag.
>>>>>>
>>>>>> This series is therefore an attempt to improve that, but only an RFC
>>>>>> since it is
>>>>>> quite likely I got stuff wrong on the first attempt. Or if not wrong
>>>>>> it may not
>>>>>> be very beneficial in AMDs case.
>>>>>>
>>>>>> So I tried to figure out how to count and store the number of
>>>>>> instances of an
>>>>>> "engine" type and spotted that could perhaps be used in more than
>>>>>> one place in
>>>>>> the driver. I was more than a little bit confused by the ip_instance
>>>>>> and uapi
>>>>>> rings, then how rings are selected to context entities internally.
>>>>>> Anyway..
>>>>>> hopefully it is a simple enough series to easily spot any such large
>>>>>> misses.
>>>>>>
>>>>>> End result should be that, assuming two "engine" instances, one
>>>>>> fully loaded and
>>>>>> one idle will only report client using 50% of that engine type.
>>>>>
>>>>> That would only be true if there are multiple instantiations of the IP
>>>>> on the chip which in most cases is not true.  In most cases there is
>>>>> one instance of the IP that can be fed from multiple rings. E.g. for
>>>>> graphics and compute, all of the rings ultimately feed into the same
>>>>> compute units on the chip.  So if you have a gfx ring and a compute
>>>>> rings, you can schedule work to them asynchronously, but ultimately
>>>>> whether they execute serially or in parallel depends on the actual
>>>>> shader code in the command buffers and the extent to which it can
>>>>> utilize the available compute units in the shader cores.
>>>>
>>>> This is the same as with Intel/i915. Fdinfo is not intended to provide
>>>> utilisation of EUs and such, just how busy are the "entities" kernel
>>>> submits to. So doing something like in this series would make the
>>>> reporting more similar between the two drivers.
>>>>
>>>> I think both the 0-800% or 0-100% range (taking 8 ring compute as an
>>>> example) can be misleading for different workloads. Neither <800% in
>>>> the former means one can send more work and same for <100% in the latter.
>>>
>>> Yeah, I think that's what Alex tries to describe. By using 8 compute
>>> rings your 800% load is actually incorrect and quite misleading.
>>>
>>> Background is that those 8 compute rings won't be active all at the same
>>> time, but rather waiting on each other for resources.
>>>
>>> But this "waiting" is unfortunately considered execution time since the
>>> used approach is actually not really capable of separating waiting and
>>> execution time.
>>
>> Right, so 800% is what gputop could be suggesting today, by the virtue 8
>> context/clients can each use 100% if they only use a subset of compute
>> units. I was proposing to expose the capacity in fdinfo so it can be
>> scaled down and then dicussing how both situation have pros and cons.
>>
>>>> There is also a parallel with the CPU world here and hyper threading,
>>>> if not wider, where "What does 100% actually mean?" is also wishy-washy.
>>>>
>>>> Also note that the reporting of actual time based values in fdinfo
>>>> would not changing with this series.
>>>>
>>>> Of if you can guide me towards how to distinguish real vs fake
>>>> parallelism in HW IP blocks I could modify the series to only add
>>>> capacity tags where there are truly independent blocks. That would be
>>>> different from i915 though were I did not bother with that
>>>> distinction. (For reasons that assignment of for instance EUs to
>>>> compute "rings" (command streamers in i915) was supposed to be
>>>> possible to re-configure on the fly. So it did not make sense to try
>>>> and be super smart in fdinfo.)
>>>
>>> Well exactly that's the point we don't really have truly independent
>>> blocks on AMD hardware.
>>>
>>> There are things like independent SDMA instances, but those a meant to
>>> be used like the first instance for uploads and the second for downloads
>>> etc.. When you use both instances for the same job they will pretty much
>>> limit each other because of a single resource.
>>
>> So _never_ multiple instances of the same IP block? No video decode,
>> encode, anything?
> 
> Some chips have multiple encode/decode IP blocks that are actually
> separate instances, however, we load balance between them so userspace
> sees just one engine.  Also in some cases they are asymmetric (e.g.,
> different sets of supported CODECs on each instance).  The driver
> handles this by inspecting the command buffer and scheduling on the
> appropriate instance based on the requested CODEC.  SDMA also supports
> multiple IP blocks that are independent.

Similar to i915 just that we don't inspect buffers but expose the 
instance capabilities and userspace is responsible to set up the load 
balancing engine with the correct physical mask.

Anyway, back to the main point - are you interested at all for me to add 
the capacity flags to at least the IP blocks which are probed to exist 
more than a singleton? And if yes, could you please suggest how to do it.

For instance should I use adev->sdma.num_instances, 
adev->uvd.num_uvd_inst, adev->vcn.num_vcn_inst, 
adev->jpeg.num_jpeg_inst? Or maybe adev->num_ip_blocks and count by 
hw_ip type?

Patch 3/5 interesting or not to skip all the empty array walking (in 
amdgpu_ctx_entity_time mostly)?

Regards,

Tvrtko

> 
> Alex
> 
>>
>>>>> As for the UAPI portion of this, we generally expose a limited number
>>>>> of rings to user space and then we use the GPU scheduler to load
>>>>> balance between all of the available rings of a type to try and
>>>>> extract as much parallelism as we can.
>>>>
>>>> The part I do not understand is the purpose of the ring argument in
>>>> for instance drm_amdgpu_cs_chunk_ib. It appears userspace can create
>>>> up to N scheduling entities using different ring id's, but internally
>>>> they can map to 1:N same scheduler instances (depending on IP type,
>>>> can be that each userspace ring maps to same N hw rings, or for rings
>>>> with no drm sched load balancing userspace ring also does not appear
>>>> to have a relation to the picked drm sched instance.).
>>>>
>>>> So I neither understand how this ring is useful, or how it does not
>>>> create a problem for IP types which use drm_sched_pick_best. It
>>>> appears even if userspace created two scheduling entities with
>>>> different ring ids they could randomly map to same drm sched aka same
>>>> hw ring, no?
>>>
>>> Yeah, that is correct. The multimedia instances have to use a "fixed"
>>> load balancing because of lack of firmware support. That should have
>>> been fixed by now but we never found time to actually validate it.
>>
>> Gotcha.
>>
>>> Regarding the "ring" parameter in CS, that is basically just for
>>> backward compatibility with older userspace. E.g. that we don't map all
>>> SDMA jobs to the same instance when only once context is used.
>>
>> I see. In that sense "limits" for compute in amdgpu_ctx_num_entities are
>> arbitrary, or related to some old userspace expectation?
>>
>> Regards,
>>
>> Tvrtko
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>>
>>>> Tvrtko
>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>>
>>>>>> Tvrtko Ursulin (5):
>>>>>>     drm/amdgpu: Cache number of rings per hw ip type
>>>>>>     drm/amdgpu: Use cached number of rings from the
>>>>>> AMDGPU_INFO_HW_IP_INFO
>>>>>>       ioctl
>>>>>>     drm/amdgpu: Skip not present rings in amdgpu_ctx_mgr_usage
>>>>>>     drm/amdgpu: Show engine capacity in fdinfo
>>>>>>     drm/amdgpu: Only show VRAM in fdinfo if it exists
>>>>>>
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  3 ++
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 39 +++++++++-----
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 62
>>>>>> +++-------------------
>>>>>>    5 files changed, 49 insertions(+), 70 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.44.0
>>>
