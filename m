Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F5AC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 11:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E45010E18F;
	Wed,  7 May 2025 11:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RN2tGvHL";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5BB10E18F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 11:31:30 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c54a9d3fcaso725707385a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 May 2025 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746617489; x=1747222289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d7XhJzLl+MDLnzwhXCLzpU7DgZt77aIWs57ZY9lpXQA=;
 b=RN2tGvHL9fUyTkhSpH4eY+pSbTZDzff73xwuHvU/Grh4veQ/mqLTKkBXBTwqVDGAQx
 I1ZcoCX4RiUzuNVcite0Dz53Zi6iiGnuXqxtKZMD6rCyIJOtdhjJ+m+3ZcsBXY8x9ZPZ
 kMvhKMgCE5wy0yHwzmSjrcdzRGYNd8MBkpwhrN6pVCMt1dnlgOlLRSpWkyGhnggbA95w
 DYs0aCKcdtRIXVvhdG/KO4y2DnO3N/SttOnfXj8oji9HKdVaip3CO9rOCowi6v3pKpX9
 r8WMyWeZZYpGZ0cFN7J91M2A0TqJh5ao5sI5Hpbb+AK8aUB3xj0JZVD9xV6kUCa926aT
 HUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746617489; x=1747222289;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7XhJzLl+MDLnzwhXCLzpU7DgZt77aIWs57ZY9lpXQA=;
 b=cUQo9CT8mCc1A9QY3gQg906zNvmL+fGC4MrHbVLhB8Pn5tlVg4+DL4uUgijw1AdqFX
 WHWSuoI2SoXg97X58wVwbNbxlQYRgQvwrD51iDcccBZN7U7nzautMoS8vd/fztYrxqXx
 46HqcE1MaqR3UPLSnBthsFmFCicTVIgMVUtHYl6jJHxcvdyUjs9jbIUJDtv541quoY+P
 NuhEyOtCSYf9WHK0EcvDff0eAmPgq+6sjOedvrB3i+YJNYhWR8tzUH/0WrSFXR2/YGj9
 /Y3qzAVAiQVcMNkdbJmudfk8UZOBolgbmnn0J/YAUW6z26YXpE+5CY7kNb8k0YcP+aJJ
 A5ZQ==
X-Gm-Message-State: AOJu0YyFpwPv+//wSMEXZazrD4+bHx8+E9FwvA2e9DE22NFlSayCcjBr
 PDfzoB3HtGGgLh8CbR1QbLGo1HOuk65t3ipCaOS44nnrq6YSWj9WFjQk7bZE
X-Gm-Gg: ASbGncuNVuiT+0VmQwlIpcjvAtQVeHmee1mot6jyaxDHHCgJcQXptqP1WWrNTnEDezc
 6rE6RFZOtvcw6O1lMz6eyn7rrmTH98bVFsKjiic47qaomZTl8Q8HCvb5z+IzgBwLFjkKCDUbTBi
 WNowlLRcxhQHfgMwkYM+hoOiyD8Kw7smwepbnl1JXOPAq2+p+r3NBGJAqL12ZuXQWGPTlcDxSC9
 ZwIg08/SNxDQF61N/H78pcBKItAbLpVsWoQQJI6Z+WmXPF5pHdWXkihjYxsBWNeTYX3la82//fk
 cvnDi6QoKDTtmUQ4j9JBBxdJbGCQdGXhSUC36c7b9bNUXFWLqw==
X-Google-Smtp-Source: AGHT+IGaJ8BdxeTyzJCoMbKgPuaoMkD4r78nZQNKje2oZETTk38mnYud3/YjMXx6jxHQaD3K6/3gtg==
X-Received: by 2002:a05:620a:2894:b0:7c5:3da2:fc75 with SMTP id
 af79cd13be357-7caf7387f36mr385120485a.24.1746617478544; 
 Wed, 07 May 2025 04:31:18 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-7caf75ca831sm140031485a.94.2025.05.07.04.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:31:18 -0700 (PDT)
Message-ID: <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
Date: Wed, 7 May 2025 07:31:17 -0400
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
Content-Language: en-US
In-Reply-To: <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
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

On 5/5/25 12:06 PM, John Olender wrote:
> On 5/5/25 5:02 AM, Christian König wrote:
>>> Simply changing the uvd vcpu bo (and therefore the firmware) to always
>>> be allocated in vram does *not* solve #3851.
>>>
>>> Let me go into a bit of depth about how I arrived at this patch.
>>>
>>> First, what sort of system configuration changes result in the uvd init
>>> failure?  It looks like having a display connected and changing the BAR
>>> size have an impact.  Next, which kernel change reliably triggers the
>>> issue?  The change is the switch to the buddy allocator.
>>
>> Well that is not a resizable BAR, but rather the "VRAM" is just stolen system memory and we completely bypass the BAR to access it.
>>
>> But the effect is the same. E.g. you have more memory CPU accessible than otherwise.
>>
>>>
>>> Now that the issue can be reliably triggered, where does the error code,
>>> -110 / -ETIMEDOUT, come from?  It turns out it's in
>>> amdgpu_uvd_ring_test_ib(), specifically a timeout while waiting on the
>>> ring's fence.
>>>
>>> With that out of the way, what allocator-related change happens when a
>>> display is connected at startup?  The 'stolen_vga_memory' and related
>>> bos are created.  Adding a one page dummy bo to the same place in the
>>> driver can allow a headless configuration to now pass the uvd ring ib test.
>>>
>>> Why does having these extra objects allocated result in a change in
>>> behavior?  Well, the switch to the buddy allocator drastically changes
>>> *where* in vram various objects end up being placed.  What about the BAR
>>> size change?  That ends up influencing where the objects are placed too.
>>>
>>> Which objects related to uvd end up being moved around?  The uvd code
>>> has a function to force its objects into a specific segment after all.
>>> Well, it turns out the vcpu bo doesn't go through this function and is
>>> therefore being moved around.
>>
>> That function is there because independent buffers (the message and the feedback for example) needs to be in the same 256MB segment.
>>
>>> When the system configuration results in a ring ib timeout, the uvd vcpu
>>> bo is pinned *outside* the uvd segment.  When uvd init succeeds, the uvd
>>> vcpu bo is pinned *inside* the uvd segment.
>>>
>>> So, it appears there's a relationship between *where* the vcpu bo ends
>>> up and the fence timeout.  But why does the issue manifest as a ring
>>> fence timeout while testing the ib?  Unfortunately, I'm unable to find
>>> something like a datasheet or developer's guide containing the finer
>>> details of uvd.
>>
>>
>> Mhm, there must be something wrong with programming bits 28-31 of the VCPU BO base address.
>>
>> Forcing the VCPU into the first 256 segment just makes those bits zero and so makes it work on your system.
>>
>> The problem is that this is basically just coincident. On other systems the base address can be completely different.
>>
>> See function uvd_v4_2_mc_resume() where the mmUVD_LMI_ADDR_EXT and mmUVD_LMI_EXT40_ADDR register is programmed and try to hack those two register writes and see if they really end up in the HW.

Okay, I did a read and compare after each write.

Both writes seem to go through on both the Kaveri and s9150:

Kaveri (512MB UMA Buffer):
amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF41FA00000, addr=0x00000001, wrote 0x00001001, read 0x00001001 [same]
amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF41FA00000, addr=0x000000F4, wrote 0x800900F4, read 0x800900F4 [same]

s9150:
amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF7FFA00000, addr=0x0000000F, wrote 0x0000F00F, read 0x0000F00F [same]
amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF7FFA00000, addr=0x000000F7, wrote 0x800900F7, read 0x800900F7 [same]

Thanks,
John

>>
>> I will try to find a Kaveri system which is still working to reproduce the issue.
>>
>> Thanks,
>> Christian.
>>
> 
> I first saw this issue with a s9150.  I had serious reservations about
> reporting the issue because, in its default configuration, the s9150 has
> no display output.  I needed to figure out that yes, this is a real
> issue, I didn't just shoot myself in the foot by enabling broken display
> hardware.
> 
> The issue affects all s9150s in a system, occurs in different slots and
> numa nodes, still occurs when other hardware is added or removed, and
> follows the s9150 from x399 to a significantly newer b650 system.
> 
> The Kaveri iGPU, while also impacted, mainly serves to show that yes,
> this issue is happening on more than just some dodgy s9150 setup.
> 
> Anyway, hopefully these extra configuration details help narrow down the
> problem.
> 
> Thanks,
> John
> 
>>>
>>> Well, what seems related in the code?  Where is the ring fence located?
>>> It's placed inside the vcpu bo by amdgpu_fence_driver_start_ring().
>>>
>>> So, does this patch provide the correct solution to the problem?  Maybe
>>> not.  But the solution seems plausible enough to at least send in the
>>> patch for review.
>>>
>>> Thanks,
>>> John
> 

