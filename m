Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06613C5B552
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 23:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9851110E78B;
	Thu, 29 May 2025 23:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMEfyBVq";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D561510E78A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 23:15:29 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7cad6a4fae4so198359885a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748560529; x=1749165329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8l7vemGUZ574l69z+32uB5k9oEcoRqR/M99RYa2aiRk=;
 b=cMEfyBVqi6E1tleA7vjNLxMo6pdk6NJChD/LTD72Qb7Mfa6wTjgl5HcODH2i3pUxt/
 yHeD4U9pWE8F1CAMMPph+8KZHnnUUlslKKkNErT3/6J6oo3AVdyi5ru8vJhkuSBDeTPa
 thqOUh8y12S4edYs1//uBzeeB28YcTG40YgtWOyR0TSoukxUHdjxQwaatqUacxsamrlI
 UqRPa4pkY2ufVjo8Adr3kvpdXKvBk6Ik/UkjM8DifTYrML896EdkRdrqWe4zMXK5jOrt
 8iY3QhIQ7xhq9TcL8iAzS9wDsnaJOdAu0MttpGSh0u+EynDgx9gxE22JH/j5AXsy+i8y
 54YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748560529; x=1749165329;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8l7vemGUZ574l69z+32uB5k9oEcoRqR/M99RYa2aiRk=;
 b=MvP0u6Td75jIVVzLNzGtKAQ861v5CWqXsCZjXecQGIIpissh9mtHbEeCFmPK9cnO9l
 m4XWd10172RLb9u6Bm83xfg6x+fFmRUddjj67W03oIDAmds+/5tCyrK6+o3S1w5UIZfF
 OybNP+ksyY5TUwuPVeQZ/DP/KYcz7Nsae07GX8GDnZUF9lM9Jjed5A1UhJ6KPO2Cdn4Y
 ksFz0YQEqA4pVZbedbXBdAzmIZkAJn0nEiXIw9j1+WyUyb/fM+gbVpr9k6/yRBEjFLdg
 Spir4jREIpQ1NHbkbdEe6E0gm+Yl4UCYLHbNkP0rjk8L/IdpvRZTZrEX8+6DwO8uotr9
 F98A==
X-Gm-Message-State: AOJu0Yygb5wlYXyv6C5OHky/dRDatvlg/0616hqHWsj1+85aF+m5ouR3
 rv98O6hwg3nPi0MCFbktRmWkD+XiXtGtRvqjMnCiqlEVfmxcX0quCJSl
X-Gm-Gg: ASbGnctS7WAoWNTCI3v+jI7xYrBW9CYEXbZy7CFyRRMZ+FeuygZ5TSiiniuRW8KHHyu
 LGAxQEaAUdKbavosQr/wp1UJp/uuM06Ny7H063jYpd0HnJhuaLRViGyOGPC+UkRd+RMRRzawXAJ
 E4vWNey2Ngij9Gmuyr6L4Ep51rQFuG+McS5XvsfzQjJkr+YWYiYxK8lNMmCCk9YIqVkp1r7OP/8
 ziUwvZQ/xuS+7y7+L0TophqA/5TDIIloOZ70kRTdwLd1lEvrtvr0cdQmnEk3H+fvtJsLrTnKKCU
 oGBEAydotcSwTTLDrixP50213MDsSOXWHe/1LQXTqVZdPyXnokZO2Dr7XMuh
X-Google-Smtp-Source: AGHT+IEPupEH9oRmYE13Q92wf4sAemT9OVoIDjiQAb0G3Qumm9lx+/WlZSEcOZlMsiaxEtH7SWWZvQ==
X-Received: by 2002:a05:620a:4509:b0:7ce:d95e:8d9a with SMTP id
 af79cd13be357-7d0a4e394e6mr9677885a.28.1748560528523; 
 Thu, 29 May 2025 16:15:28 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6fac6d5b144sm14579916d6.55.2025.05.29.16.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 16:15:28 -0700 (PDT)
Message-ID: <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
Date: Thu, 29 May 2025 19:15:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
From: John Olender <john.olender@gmail.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
 <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
 <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
Content-Language: en-US
In-Reply-To: <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Ping.

On 5/7/25 7:31 AM, John Olender wrote:
> On 5/5/25 12:06 PM, John Olender wrote:
>> On 5/5/25 5:02 AM, Christian König wrote:
>>>> Simply changing the uvd vcpu bo (and therefore the firmware) to always
>>>> be allocated in vram does *not* solve #3851.
>>>>
>>>> Let me go into a bit of depth about how I arrived at this patch.
>>>>
>>>> First, what sort of system configuration changes result in the uvd init
>>>> failure?  It looks like having a display connected and changing the BAR
>>>> size have an impact.  Next, which kernel change reliably triggers the
>>>> issue?  The change is the switch to the buddy allocator.
>>>
>>> Well that is not a resizable BAR, but rather the "VRAM" is just stolen system memory and we completely bypass the BAR to access it.
>>>
>>> But the effect is the same. E.g. you have more memory CPU accessible than otherwise.
>>>
>>>>
>>>> Now that the issue can be reliably triggered, where does the error code,
>>>> -110 / -ETIMEDOUT, come from?  It turns out it's in
>>>> amdgpu_uvd_ring_test_ib(), specifically a timeout while waiting on the
>>>> ring's fence.
>>>>
>>>> With that out of the way, what allocator-related change happens when a
>>>> display is connected at startup?  The 'stolen_vga_memory' and related
>>>> bos are created.  Adding a one page dummy bo to the same place in the
>>>> driver can allow a headless configuration to now pass the uvd ring ib test.
>>>>
>>>> Why does having these extra objects allocated result in a change in
>>>> behavior?  Well, the switch to the buddy allocator drastically changes
>>>> *where* in vram various objects end up being placed.  What about the BAR
>>>> size change?  That ends up influencing where the objects are placed too.
>>>>
>>>> Which objects related to uvd end up being moved around?  The uvd code
>>>> has a function to force its objects into a specific segment after all.
>>>> Well, it turns out the vcpu bo doesn't go through this function and is
>>>> therefore being moved around.
>>>
>>> That function is there because independent buffers (the message and the feedback for example) needs to be in the same 256MB segment.
>>>
>>>> When the system configuration results in a ring ib timeout, the uvd vcpu
>>>> bo is pinned *outside* the uvd segment.  When uvd init succeeds, the uvd
>>>> vcpu bo is pinned *inside* the uvd segment.
>>>>
>>>> So, it appears there's a relationship between *where* the vcpu bo ends
>>>> up and the fence timeout.  But why does the issue manifest as a ring
>>>> fence timeout while testing the ib?  Unfortunately, I'm unable to find
>>>> something like a datasheet or developer's guide containing the finer
>>>> details of uvd.
>>>
>>>
>>> Mhm, there must be something wrong with programming bits 28-31 of the VCPU BO base address.
>>>
>>> Forcing the VCPU into the first 256 segment just makes those bits zero and so makes it work on your system.
>>>
>>> The problem is that this is basically just coincident. On other systems the base address can be completely different.
>>>
>>> See function uvd_v4_2_mc_resume() where the mmUVD_LMI_ADDR_EXT and mmUVD_LMI_EXT40_ADDR register is programmed and try to hack those two register writes and see if they really end up in the HW.
> 
> Okay, I did a read and compare after each write.
> 
> Both writes seem to go through on both the Kaveri and s9150:
> 
> Kaveri (512MB UMA Buffer):
> amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF41FA00000, addr=0x00000001, wrote 0x00001001, read 0x00001001 [same]
> amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF41FA00000, addr=0x000000F4, wrote 0x800900F4, read 0x800900F4 [same]
> 
> s9150:
> amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF7FFA00000, addr=0x0000000F, wrote 0x0000F00F, read 0x0000F00F [same]
> amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF7FFA00000, addr=0x000000F7, wrote 0x800900F7, read 0x800900F7 [same]
> 

I've also confirmed the patch works fine when segments other than
[0, 256M) are used.
 
E.g.: Both init and VA-API playback work fine with a UVD segment of
[1792M, 2048M) on Kaveri with a 2G UMA buffer.

> Thanks,
> John
> 
>>>
>>> I will try to find a Kaveri system which is still working to reproduce the issue.
>>>
>>> Thanks,
>>> Christian.
>>>
>>
>> I first saw this issue with a s9150.  I had serious reservations about
>> reporting the issue because, in its default configuration, the s9150 has
>> no display output.  I needed to figure out that yes, this is a real
>> issue, I didn't just shoot myself in the foot by enabling broken display
>> hardware.
>>
>> The issue affects all s9150s in a system, occurs in different slots and
>> numa nodes, still occurs when other hardware is added or removed, and
>> follows the s9150 from x399 to a significantly newer b650 system.
>>
>> The Kaveri iGPU, while also impacted, mainly serves to show that yes,
>> this issue is happening on more than just some dodgy s9150 setup.
>>
>> Anyway, hopefully these extra configuration details help narrow down the
>> problem.
>>
>> Thanks,
>> John
>>
>>>>
>>>> Well, what seems related in the code?  Where is the ring fence located?
>>>> It's placed inside the vcpu bo by amdgpu_fence_driver_start_ring().
>>>>
>>>> So, does this patch provide the correct solution to the problem?  Maybe
>>>> not.  But the solution seems plausible enough to at least send in the
>>>> patch for review.
>>>>
>>>> Thanks,
>>>> John
>>
> 

