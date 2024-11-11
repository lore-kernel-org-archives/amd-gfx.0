Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D1BD2E9E4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 12:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BB810E49B;
	Mon, 11 Nov 2024 12:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jwqDbyph";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259C110E49B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 12:39:56 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-43193678216so42556805e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731328794; x=1731933594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aQcIR/E4d7Qm0YavwRa9/1ArNkpzzCQrOar4Wmd3omk=;
 b=jwqDbyphjibPpkCCS16qTHSLX9Z824fhw7FAPiYt0Ga8KumMfXDcXyiZWifLbve4OS
 LAacsuybG35letOcys9oLkhNLAc4TQSQSJkb3R7KFuFY7hOgUxRccibBFURky/qEg7xR
 UNTlMpyb7qsoJBSo/yezj/nuGe4MZI1JhDlxCmleboezCh4FThme6Un08wO70J0ENLPC
 FFhf03IHkW9XEb8k2E/p9V1ksvZX6TR1/60JWD1AOpl34gkQvTQ+sqonyktOgKNF2olH
 MdnrIZCW96xHIF4pIEFSkWaHASeSv0lS5/ux3OEDfzgdplIonMhRXe0BfwJLGOIgaXS8
 US1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731328794; x=1731933594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQcIR/E4d7Qm0YavwRa9/1ArNkpzzCQrOar4Wmd3omk=;
 b=NnWyp5RJdTVaI/oAAOhU/cLdKeXMgGB+yQUL//euW+57/RAi2v2amQruDt6mwMD2yE
 xWIdphGYavZy5ZB5y44hOResqRVswMm5kwY46w1vLST0HK+kLU7SKEDAiWodarLZ8oXc
 IxyE3tC/EaQ+vIIGhQyVjo3VF8ho1Xuz/hu/qAP3fdaZmTziDiOPfjSGVyZo+hSAYGtH
 97Wkqfjm+vvK9vHnhUPg075b4GbicbeYbIxTlluItWBfVN355P7/ZbK32S+JzuT41TyR
 Mnrfnb6LarQ7FHNbCYitJ5oK4WEHZYsYnUF+BmQXhHXTdbpySfaanRCXzkSix+ljZGEU
 rw6g==
X-Gm-Message-State: AOJu0YwfpTyxz4utGUKkdGK5GknWXQmeNN3CtX1jYvUxuspPCh5T1Bp5
 rOHrOc2NsD/U0qLB5CVylRlMzBzNe3MNBrSqTA/ote+nr/LYae3d
X-Google-Smtp-Source: AGHT+IHNeIzMiXLCHsjKXnCJI067Pdr4bXds0MzqJRO3BdS18p2Yh8UEdY0gaQoPRCxUChUMKS++pg==
X-Received: by 2002:a05:6000:71b:b0:37d:3bad:a503 with SMTP id
 ffacd0b85a97d-381f18854e7mr10176889f8f.40.1731328793926; 
 Mon, 11 Nov 2024 04:39:53 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed999e0csm12711159f8f.59.2024.11.11.04.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 04:39:53 -0800 (PST)
Message-ID: <bef834a5-b7ae-4ef0-bd75-55003d38f4ac@gmail.com>
Date: Mon, 11 Nov 2024 13:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
 <BL1PR12MB5269AC1E12A48107FA87A03084582@BL1PR12MB5269.namprd12.prod.outlook.com>
 <6950b5e1-c283-4029-84e8-7dcc42b16912@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <6950b5e1-c283-4029-84e8-7dcc42b16912@amd.com>
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

Hi guys,

trying to merge multiple responses back into one mail thread.

Lijo, you're completely right, but there is one really strong argument 
you are missing:

The patch here doesn't change the write combine behavior, it changes the 
caching behavior!

So when the patch works and fixes the issue, then the issue is 100% 
certain not a write combine issue but rather an incorrectly applied 
caching :)

>  From what I heard there was a KVM patch to correct the mapping behavior -- previously the mapping is forced to cache mode even guest KMD maps the buffer with "WC".
> But after the patch the buffer will be really "WC" if guest maps it with WC"... and this reveals the bug and hit our issue.

Yeah, exactly that's the problem. The guest doesn't know if WB, USWC or 
uncached should be used!

The guest sees driver exposed memory as "emulated" MMIO BAR of a PCIe 
device, that's just how QEMU is designed. Because of this the guest maps 
the memory USWC or uncached. But in reality the memory can as well be 
GTT memory which is cached.

So forcing the cache mode even if the guest KMD maps the buffer with 
"WC" is intentional behavior, that's the correct approach.

The upstream people realized that as well. That's one major reason why 
the patch was reverted.

> Can you explain why USWC for ring buffer is safe, why it will not hit coherence issue, why you don't make all ring buffers with USWC even for amdgpu side if you really believe USWC is innocent ...

We already tried this, but there is simply no benefit for it.

Regards,
Christian.


Am 11.11.24 um 06:58 schrieb Lazar, Lijo:
>
> On 11/11/2024 7:00 AM, Liu, Monk wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi Lijo
>>
>> This is the patch we verified before:
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> index 4843dcb9a5f7..39553c7648eb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> @@ -308,10 +308,12 @@ int kq_submit_packet(struct kernel_queue *kq)
>>
>>          if (kq->dev->kfd->device_info.doorbell_size == 8) {
>>                  *kq->wptr64_kernel = kq->pending_wptr64;
>> +               mb();
>>                  write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>>                                          kq->pending_wptr64);
>>          } else {
>>                  *kq->wptr_kernel = kq->pending_wptr;
>> +               mb();
>>                  write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>>                                          kq->pending_wptr);
>>          }
>>
>>
>> This mb() doesn't resolve the problem during customer's testing, I also thought of MB() first in beginning like you and Christian ...
>> The mb() here shall resolve the re-ordering between WPTR and doorbell kicking so GPU won't fetch stalled data from WPTR polling once it receives notification from doorbell kicking.
>> (in SR-IOV we set doorbell mode to force GPU still fetch from WPTR polling area, doorbell kicking is just to notify GPU)
>>
>> And by your theory: mb() shall flush the WC storage buffer to memory, thus, this mb() shall also make sure that the ring buffer is not holding stalled data anymore, right ?
> This is not my theory. All the quotes in my earlier mails are from
> "Intel® 64 and IA-32 Architectures Software Developer’s Manual".
>
> Yet another one -
>
> <snip>
>
> Writes may be delayed and combined in the write combining buffer (WC
> buffer) to reduce memory accesses.
>
> "If the WC buffer is partially filled, the writes may be delayed until
> the next occurrence of a serializing event; such as an
> SFENCE or MFENCE instruction, CPUID or other serializing instruction, a
> read or write to uncached memory, an
> interrupt occurrence, or an execution of a LOCK instruction (including
> one with an XACQUIRE or XRELEASE
> prefix)."
>
> </snip>
>
>
>> But we still hit hang and get stalled data from dump.
>>
>> Maybe we need to put mb() in another place ? can you proposal if you insist the cache mapping is not acceptable to you and we can ask customer to verify again.
>>
> There are a couple of things which are still working strangely, they
> will need some explanation as well -
>
> 	Even though write pointer allocations are also to WC region, and are
> correctly seen by CP every time. Since it needs to get wptr updates from
> memory rather than doorbell value, don't know how your snooping theory
> works for this. Also, it is weird that WC writes to those pass MQD
> buffer writes even with fence.
>
> 	MQD allocation for user queues are still from USWC as per your latest
> patch and they still work correctly.
>
> For debug -
> 	Is the WPTR reg value correctly reflecting the memory value? Have you
> tried initializing MQD to a known pattern (memset32/64) like a series of
> 0xcafedead and verified what is seen at the CP side?
>
> Thanks,
> Lijo
>
>> Thanks
>>
>> Monk Liu | Cloud GPU & Virtualization | AMD
>>
>>
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, November 8, 2024 7:26 PM
>> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
>>
>>
>>
>> On 11/8/2024 4:29 PM, Liu, Monk wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> To be clear for the mb() approach: Even if we insert mb() in prior to amdgpu_ring_set_wptr(ring), GPU might still fetch stalled data from PQ due to USWC attributes.
>>>
>> Inserting an mb() doesn't cause WC buffer flush is a wrong assumption.
>>
>> All prior loads/stores are supposed to be globally visible. Hence mb() followed by a write pointer update also should guarantee the same (From Arch manual).
>>
>>          The MFENCE instruction establishes a memory fence for both loads and stores. The processor ensures that no load or store after MFENCE will become globally visible *until all loads and stores before MFENCE are globally visible.*
>>
>>
>> Ignoring the amdgpu driver part of it - if mb() is not working as expected as you claim that means something is wrong with the system.
>>
>> USWC or WB for ring type may still be a separate discussion.
>>
>> Thanks,
>> Lijo
>>
>>> The issue here is not the re-ordering but the stalled PQ.
>>>
>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Liu, Monk
>>> Sent: Friday, November 8, 2024 6:22 PM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>>> <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao,
>>> Victor <Victor.Zhao@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>;
>>> Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>>> wb pool
>>>
>>> Christian/Lijo
>>>
>>> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
>>>
>>> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
>>> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
>>>
>>> This is why only cache plus snoop memory can get rid of inconsistence issues.
>>>
>>> Besides, do you know what's the rational to keep all GFX KCQ cache+snoop but only HIQ/KIQ from KFD configured to USWC ?
>>>
>>> For performance concern that looks to me always the second priority compared to "correct" especially under the case HIQ contributes very little to ROCM performance when switching to cache mapping.
>>>
>>>
>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Thursday, November 7, 2024 7:57 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>>> <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Yang,
>>> Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>>> wb pool
>>>
>>> Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
>>>> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>>>>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>>>>> From: Monk Liu <Monk.Liu@amd.com>
>>>>>>
>>>>>> As cache GTT buffer is snooped, this way the coherence between CPU
>>>>>> write and GPU fetch is guaranteed, but original code uses WC +
>>>>>> unsnooped for HIQ PQ(ring buffer) which introduces coherency issues:
>>>>>> MEC fetches a stall data from PQ and leads to MEC hang.
>>>>> Can you elaborate on this?  I can see CPU reads being slower because
>>>>> the memory is uncached, but the ring buffer is mostly writes anyway.
>>>>> IIRC, the driver uses USWC for most if not all of the other ring
>>>>> buffers managed by the kernel.  Why aren't those a problem?
>>>> We have this on other rings -
>>>>           mb();
>>>>           amdgpu_ring_set_wptr(ring);
>>>>
>>>> I think the solution should be to use barrier before write pointer
>>>> updates rather than relying on PCIe snooping.
>>> Yeah, completely agree as well. The barrier also takes care of preventing the compiler from re-ordering writes.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Alex
>>>>>
>>>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>           if (amdgpu_amdkfd_alloc_gtt_mem(
>>>>>>                           kfd->adev, size, &kfd->gtt_mem,
>>>>>>                           &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>>>>> -                       false, true)) {
>>>>>> +                       false, false)) {
>>>>>>                   dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>>>>                   goto alloc_gtt_mem_failure;
>>>>>>           }
>>>>>> --
>>>>>> 2.34.1
>>>>>>

