Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BDBC3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 16:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854B310E358;
	Mon,  5 May 2025 16:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KmON6WUB";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CE910E358
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 16:06:14 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-476af5479feso55115351cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 May 2025 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746461174; x=1747065974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RpbgOjAJX7jbsTpPMUVzdHKBXzfH6jk7JN+cSd5Bb10=;
 b=KmON6WUB/2ZQyg/R3zOkCk9v+LyqZ5ys6GAah6BRG1akqsssz65Elti6pGrtrsr1t5
 UoBxZAsNrnlfZHsKvjygnnvCQo60LMXGJjMgzPZGK8h48vvcOHu4H9zYPh8oRn1lGwv2
 Id8Z6irSYQ8jtmWhQFSzyLAmi4YRxW6oEf3M+CWsuRgbkvYt5E12cIXyfZaidQ0PgQyn
 cQpFwQggb88vgzjm8MNwlP6T8OSGT19zpp+v9ZuoYkN3cZsZlue8P97utcyabA2Mrjhy
 dYA7Hj4fEHEgEaSawp1PJloloOMAnppAgE2p21o2ZZ/NvkY79/6IDeotLfeM7kxAYc+8
 I43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746461174; x=1747065974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RpbgOjAJX7jbsTpPMUVzdHKBXzfH6jk7JN+cSd5Bb10=;
 b=qSHYQAZPUf9gAdCgGLCcCzWQ3L4W0QHVyFi8ESzEVaW3lqUBaPCsWXZ9YUpFft3U12
 Kuf+z6Zzs2OXD9TDWsM+xoy+M9kUJE8eLHSJEAibxiQnmrzgy3Rve4OjmudPAug/IBjW
 bGlb00LbqOH7Pv3Un1ujfvb6263tecrMkLMD8S5nuFuKvEDlif+4jCsef13VcXqyz8vq
 15VK9aAOYXlTPoEcQVN6D/fNmmwJF0d3WXwvEBlGhWXnB6N+FcABbAWJz/VdzbFw0MrQ
 6sH8qx8VyLpaXgZcaDU5i7JFvX0jYT9AN6N0RGJzGWED2weoyUI/3twRuOHvD1ixFDdC
 lWBg==
X-Gm-Message-State: AOJu0YwEcLFglNl2/o6jaKTCmK9yK+EcmZxGj2Eh/RR1WABbX3+kdIwS
 B1OYeTDy5Wlf2KHCGKpeC1ibhHgUNbp4tOIV3jvyZ1O88HKI5eCq
X-Gm-Gg: ASbGncsi53VMUp0R4mVePexTEpqRmeoGWRVRDJiAdLb90GzTgm8TDknUcEqvO+7DNwc
 kJs0Nlz0wKD/n+U2CtgpzIQDhDJ0+mQTfmXjo1ywoUvXpeuAZQEGd3BpfZl/x4XChIbO/JL2a4S
 PqPGJ5Jn+9jr7vpGdgzpUnjDknbU70Udpo/hLxAfPZJD8EvLkXpv71d0gY600md6NnbJBmK2K0z
 uVR+jZKGNlyz5jkNHvSno5BLIlNTfhpTS0ZPMNC7swC/tVbid70jW+1Pe1Zzz+GzyeZuwh7uHAB
 mBJT/Yt3PQY7Jsz2uX6P4ZSvnJBIL/IeEPWMRoxRdkdrPi6TZA==
X-Google-Smtp-Source: AGHT+IGvkPtVjw49uhyTD/i4k9rEvDGGskruYSH8ziIWsYe+FzYMRZ/PmNjLuLymxCA5q1nqIaeoDg==
X-Received: by 2002:a05:6214:2268:b0:6e8:f91a:c5a with SMTP id
 6a1803df08f44-6f528c7e576mr122807216d6.22.1746461173488; 
 Mon, 05 May 2025 09:06:13 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f50f482ae0sm57228666d6.115.2025.05.05.09.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:06:13 -0700 (PDT)
Message-ID: <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
Date: Mon, 5 May 2025 12:06:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
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

On 5/5/25 5:02 AM, Christian König wrote:
>> Simply changing the uvd vcpu bo (and therefore the firmware) to always
>> be allocated in vram does *not* solve #3851.
>>
>> Let me go into a bit of depth about how I arrived at this patch.
>>
>> First, what sort of system configuration changes result in the uvd init
>> failure?  It looks like having a display connected and changing the BAR
>> size have an impact.  Next, which kernel change reliably triggers the
>> issue?  The change is the switch to the buddy allocator.
> 
> Well that is not a resizable BAR, but rather the "VRAM" is just stolen system memory and we completely bypass the BAR to access it.
> 
> But the effect is the same. E.g. you have more memory CPU accessible than otherwise.
> 
>>
>> Now that the issue can be reliably triggered, where does the error code,
>> -110 / -ETIMEDOUT, come from?  It turns out it's in
>> amdgpu_uvd_ring_test_ib(), specifically a timeout while waiting on the
>> ring's fence.
>>
>> With that out of the way, what allocator-related change happens when a
>> display is connected at startup?  The 'stolen_vga_memory' and related
>> bos are created.  Adding a one page dummy bo to the same place in the
>> driver can allow a headless configuration to now pass the uvd ring ib test.
>>
>> Why does having these extra objects allocated result in a change in
>> behavior?  Well, the switch to the buddy allocator drastically changes
>> *where* in vram various objects end up being placed.  What about the BAR
>> size change?  That ends up influencing where the objects are placed too.
>>
>> Which objects related to uvd end up being moved around?  The uvd code
>> has a function to force its objects into a specific segment after all.
>> Well, it turns out the vcpu bo doesn't go through this function and is
>> therefore being moved around.
> 
> That function is there because independent buffers (the message and the feedback for example) needs to be in the same 256MB segment.
> 
>> When the system configuration results in a ring ib timeout, the uvd vcpu
>> bo is pinned *outside* the uvd segment.  When uvd init succeeds, the uvd
>> vcpu bo is pinned *inside* the uvd segment.
>>
>> So, it appears there's a relationship between *where* the vcpu bo ends
>> up and the fence timeout.  But why does the issue manifest as a ring
>> fence timeout while testing the ib?  Unfortunately, I'm unable to find
>> something like a datasheet or developer's guide containing the finer
>> details of uvd.
> 
> 
> Mhm, there must be something wrong with programming bits 28-31 of the VCPU BO base address.
> 
> Forcing the VCPU into the first 256 segment just makes those bits zero and so makes it work on your system.
> 
> The problem is that this is basically just coincident. On other systems the base address can be completely different.
> 
> See function uvd_v4_2_mc_resume() where the mmUVD_LMI_ADDR_EXT and mmUVD_LMI_EXT40_ADDR register is programmed and try to hack those two register writes and see if they really end up in the HW.
> 
> I will try to find a Kaveri system which is still working to reproduce the issue.
> 
> Thanks,
> Christian.
> 

I first saw this issue with a s9150.  I had serious reservations about
reporting the issue because, in its default configuration, the s9150 has
no display output.  I needed to figure out that yes, this is a real
issue, I didn't just shoot myself in the foot by enabling broken display
hardware.

The issue affects all s9150s in a system, occurs in different slots and
numa nodes, still occurs when other hardware is added or removed, and
follows the s9150 from x399 to a significantly newer b650 system.

The Kaveri iGPU, while also impacted, mainly serves to show that yes,
this issue is happening on more than just some dodgy s9150 setup.

Anyway, hopefully these extra configuration details help narrow down the
problem.

Thanks,
John

>>
>> Well, what seems related in the code?  Where is the ring fence located?
>> It's placed inside the vcpu bo by amdgpu_fence_driver_start_ring().
>>
>> So, does this patch provide the correct solution to the problem?  Maybe
>> not.  But the solution seems plausible enough to at least send in the
>> patch for review.
>>
>> Thanks,
>> John

