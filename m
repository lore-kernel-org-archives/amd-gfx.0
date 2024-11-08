Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9D8D5C0CF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 14:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20F810E256;
	Fri,  8 Nov 2024 14:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQTQER0S";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE0110E256
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 14:09:00 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-539fe76e802so2401282e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2024 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731074938; x=1731679738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n8xVguKYrVOQFCYqTea3MyXY/XCxqcem26WbDNHK5IU=;
 b=YQTQER0SSb3EEevYtwj9y1ChQCuMqvV4R36Aybipb+uR3/Br6LrBzvUk40T98NmdNN
 Amd6QFmd9A4IOUAR5hISd2UPIWKcGFgF67KQaoDda7fKWmK8J76I+00/SHm/81/x+zjj
 EqBZ+6zXINjGmoq4L3PduxnnhJ5G5+te4WGioqdaNJob/Jc3MJ6SSaKjfcQ9dxH/0HEY
 6+d2VfTQm9FY94YUJcuP9rinncga746hP2vMvxqTvthlCRB9TclG/mnhJcgngHAiLtrq
 Kj+PPTKQme8uvjVVA2+L5YKlQDCY0A2iAaLNKvQOtQx/PiJvv8GdfvOC9vfk15sAHA4k
 3dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731074938; x=1731679738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8xVguKYrVOQFCYqTea3MyXY/XCxqcem26WbDNHK5IU=;
 b=oF4I5EBpw6wj9vc2RFIQwQdKKROAMLbRD2cAdnPuJF4oleXFhdH/dlfV2n68hDjXeu
 5FAowVv4AVqriIa84PLw9Q+3Zrq6T2H3KwnXUGDXb+rhfZfE5i35x03l9TNeCHYZMxvO
 EJwfWyyXj6Jk+UbbH0gBKOiytOPM5u0L6VjLYzV5VPSfXBLEH30aaWipRdvtmC8EsKbU
 wzRU4D3pp+XGJj2tHRbTUF9gZrSeocVNhJpI02cFW2HtX7v3Qu271JC2Sttewu5YrJgR
 iqzggwEtih/gwH/s1Z7z5gQlm+76O0L3EuchyVJyAiWyMLuJFByC2w+ZB/hUM2vsz5Wg
 jfLA==
X-Gm-Message-State: AOJu0YwHMIWgSUhSDX2+6cG55GmqKItUcGU5AiQ6zTGJi7XpnpKhUSle
 RTX52EmiS7hbRJNucL7jjHqNR9GS/Jr5H654EzWlo493nCnotvPt
X-Google-Smtp-Source: AGHT+IEAIe/cvJiCszIq1oCZ+C37/I+YC1ZVXAmwqtwcj/NrWaNxJR2NYi5AreE+jdjYC2NAJ221hg==
X-Received: by 2002:a05:6512:3d2a:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-53d862e2c0bmr1914862e87.25.1731074937600; 
 Fri, 08 Nov 2024 06:08:57 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9719easm5077138f8f.9.2024.11.08.06.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 06:08:57 -0800 (PST)
Message-ID: <67758e2c-489e-46e9-be94-161aaa6da57b@gmail.com>
Date: Fri, 8 Nov 2024 15:08:53 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
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

Am 08.11.24 um 12:26 schrieb Lazar, Lijo:
> On 11/8/2024 4:29 PM, Liu, Monk wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> To be clear for the mb() approach: Even if we insert mb() in prior to amdgpu_ring_set_wptr(ring), GPU might still fetch stalled data from PQ due to USWC attributes.
>>
> Inserting an mb() doesn't cause WC buffer flush is a wrong assumption.
>
> All prior loads/stores are supposed to be globally visible. Hence mb()
> followed by a write pointer update also should guarantee the same (From
> Arch manual).
>
> 	The MFENCE instruction establishes a memory fence for both loads and
> stores. The processor ensures that no load
> or store after MFENCE will become globally visible *until all loads and
> stores before MFENCE are globally visible.*
>
>
> Ignoring the amdgpu driver part of it - if mb() is not working as
> expected as you claim that means something is wrong with the system.
>
> USWC or WB for ring type may still be a separate discussion.

Yeah completely agree. Additional to that the combine behavior between 
USWC and WB is the same, so the argumentation is clearly not correct.

What happens instead is that the broken KVM patch applies the guest 
caching attributes to the ring buffer instead of the host ones.

Making an educated guess I would say that the root of the problem is 
that the guest is using some incorrect caching attributes for some 
reason, which is exactly the same reason why that KVM patch was revert 
upstream as well.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> The issue here is not the re-ordering but the stalled PQ.
>>
>> Monk Liu | Cloud GPU & Virtualization | AMD
>>
>>
>>
>> -----Original Message-----
>> From: Liu, Monk
>> Sent: Friday, November 8, 2024 6:22 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
>>
>> Christian/Lijo
>>
>> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
>>
>> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
>> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
>>
>> This is why only cache plus snoop memory can get rid of inconsistence issues.
>>
>> Besides, do you know what's the rational to keep all GFX KCQ cache+snoop but only HIQ/KIQ from KFD configured to USWC ?
>>
>> For performance concern that looks to me always the second priority compared to "correct" especially under the case HIQ contributes very little to ROCM performance when switching to cache mapping.
>>
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
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, November 7, 2024 7:57 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
>>
>> Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
>>> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>>>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>>>> From: Monk Liu <Monk.Liu@amd.com>
>>>>>
>>>>> As cache GTT buffer is snooped, this way the coherence between CPU
>>>>> write and GPU fetch is guaranteed, but original code uses WC +
>>>>> unsnooped for HIQ PQ(ring buffer) which introduces coherency issues:
>>>>> MEC fetches a stall data from PQ and leads to MEC hang.
>>>> Can you elaborate on this?  I can see CPU reads being slower because
>>>> the memory is uncached, but the ring buffer is mostly writes anyway.
>>>> IIRC, the driver uses USWC for most if not all of the other ring
>>>> buffers managed by the kernel.  Why aren't those a problem?
>>> We have this on other rings -
>>>           mb();
>>>           amdgpu_ring_set_wptr(ring);
>>>
>>> I think the solution should be to use barrier before write pointer
>>> updates rather than relying on PCIe snooping.
>> Yeah, completely agree as well. The barrier also takes care of preventing the compiler from re-ordering writes.
>>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Alex
>>>>
>>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>           if (amdgpu_amdkfd_alloc_gtt_mem(
>>>>>                           kfd->adev, size, &kfd->gtt_mem,
>>>>>                           &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>>>> -                       false, true)) {
>>>>> +                       false, false)) {
>>>>>                   dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>>>                   goto alloc_gtt_mem_failure;
>>>>>           }
>>>>> --
>>>>> 2.34.1
>>>>>

