Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3ABC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 18:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781EF10E106;
	Fri, 20 May 2022 18:25:43 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D5310E106
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 18:25:42 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id f9so17200291ejc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=3nKv2ujv2jlyrcvreTWrFm1tfPT1/GnY8U+YLx92yNg=;
 b=gxe51mL3/lpUgzMXVbueg5jfeSf4lK0bzIQdDgphqQKXieao2zHWjCxLItYpQz78yu
 oqw1zXjKRe38g4O5vc/9SgKrNRA4JGyZTGWVJV29idUL2nOFR66ANoS+gQpESG5gc13S
 53vjmC9MbMS3SVtBAVvc6uWk/n20aMcKhZBkGbEU8VLTofLuIzWGcta66ugbVrEhJE5v
 Xlb07gZD0iCbkIFFpd8Ydr+DGoDA/ed7r+YpIlREi2F+fCM9kmIWHY4KQELlW9a2fOkY
 x4B5SY3vp8uoFo0MVreDiHB3MJbGG03jTZava2j6lrRErPyP7duPqDjOUUJcGutkkCgk
 aYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3nKv2ujv2jlyrcvreTWrFm1tfPT1/GnY8U+YLx92yNg=;
 b=TDb99bDL7cFDWjp37ELSgGOCEJKaCAGuSxp2p2o1ejMOxqEwQw28LuWzJ6yth6PHIF
 wtv3qaXNCX1tlWlVem1tBil/nazZykwEsuwbF8gldLtHi7YJ3H3gg+G087i3XsqE80qQ
 JEEgf6BFhmC9g9jSnpCOyFcM+XufXw97aFIykOo1jmzUaD94W1h13gVK+D4G92DGSC3H
 gAmIKwAgDkMXkB1jLdqvbXWd+E8NterWy7VGcUXfLgyl0ATi/6Yn3+FdT6kZtEtYaxlO
 1nRCDs5sN9TjOCvONrW/kK2NXxT9SLtlQzkY4FESLlz9GAc2UQwvCQTBPXj7wDQ85iIw
 C/mA==
X-Gm-Message-State: AOAM533+GaHzO1Rl8paAlwy9EWWDWELqiWCAIAFA4/PQbn0Bx94cp656
 Gnhy1q8KeQONfBNaN5zl8jQ=
X-Google-Smtp-Source: ABdhPJysZes7tf/HqiAFqulVH+8wErJn0hIDQlOE5G0ik2mzjFrr5VzjSJODTZmaE8z4yhXGrRBaxA==
X-Received: by 2002:a17:907:94c8:b0:6fe:7ef5:c6e9 with SMTP id
 dn8-20020a17090794c800b006fe7ef5c6e9mr9807000ejc.183.1653071141299; 
 Fri, 20 May 2022 11:25:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:3071:8530:b5bf:95a9?
 ([2a02:908:1256:79a0:3071:8530:b5bf:95a9])
 by smtp.gmail.com with ESMTPSA id
 jl7-20020a17090775c700b006fea2035036sm1418023ejc.86.2022.05.20.11.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 11:25:40 -0700 (PDT)
Message-ID: <67d39c05-d798-9515-5dec-7a2c4eb534d0@gmail.com>
Date: Fri, 20 May 2022 20:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
 <CAP+8YyHE79regLR47v29G_qmitR-WOfjOQR-R1nNf5aMVVqFbA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAP+8YyHE79regLR47v29G_qmitR-WOfjOQR-R1nNf5aMVVqFbA@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.05.22 um 19:41 schrieb Bas Nieuwenhuizen:
> On Fri, May 20, 2022 at 11:42 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> In theory we should allow much more than that. The problem is just that we can't.
>>
>> We have the following issues:
>> 1. For swapping out stuff we need to make sure that we can allocate temporary pages.
>>      Because of this TTM has a fixed 50% limit where it starts to unmap memory from GPUs.
>>      So currently even with a higher GTT limit you can't actually use this.
>>
>> 2. Apart from the test case of allocating textures with increasing power of two until it fails we also have a bunch of extremely stupid applications.
>>      E.g. stuff like looking at the amount of memory available and trying preallocate everything.
> I hear you but we also have an increasing number of games that don't
> even start with 3 GiB. At some point (which I'd speculate has already
> been reached, I've seen a number of complaints of games that ran on
> deck but not on desktop linux because on deck we set amdgpu.gttsize)
> we have more games broken due to the low limit than there would be
> apps broken due to a high limit.

That's a really good argument, but the issue is that it is fixable. It's 
just that nobody had time to look into all the issues.

If started efforts to fix this years ago, but there was always something 
more important going on.

So we are left with the choice of breaking old applications or new 
applications or getting somebody working on fixing this.

Christian.

>
>> I'm working on this for years, but there aren't easy solutions to those issues. Felix has opted out for adding a separate domain for KFD allocations, but sooner or later we need to find a solution which works for everybody.
>>
>> Christian.
>>
>> Am 20.05.22 um 11:14 schrieb Marek Olšák:
>>
>> Ignore the silly tests. We only need to make sure games work. The current minimum requirement for running modern games is 8GB of GPU memory. Soon it will be 12GB. APUs will need to support that.
>>
>> Marek
>>
>> On Fri., May 20, 2022, 03:52 Christian König, <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 19.05.22 um 16:34 schrieb Alex Deucher:
>>>> The current somewhat strange logic is in place because certain
>>>> GL unit tests for large textures can cause problems with the
>>>> OOM killer since there is no way to link this memory to a
>>>> process.  The problem is this limit is often too low for many
>>>> modern games on systems with more memory so limit the logic to
>>>> systems with less than 8GB of main memory.  For systems with 8
>>>> or more GB of system memory, set the GTT size to 3/4 of system
>>>> memory.
>>> It's unfortunately not only the unit tests, but some games as well.
>>>
>>> 3/4 of total system memory sounds reasonable to be, but I'm 100% sure
>>> that this will break some tests.
>>>
>>> Christian.
>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++-----
>>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 4b9ee6e27f74..daa0babcf869 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>        /* Compute GTT size, either bsaed on 3/4th the size of RAM size
>>>>         * or whatever the user passed on module init */
>>>>        if (amdgpu_gtt_size == -1) {
>>>> +             const u64 eight_GB = 8192ULL * 1024 * 1024;
>>>>                struct sysinfo si;
>>>> +             u64 total_memory, default_gtt_size;
>>>>
>>>>                si_meminfo(&si);
>>>> -             gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>>>> -                            adev->gmc.mc_vram_size),
>>>> -                            ((uint64_t)si.totalram * si.mem_unit * 3/4));
>>>> -     }
>>>> -     else
>>>> +             total_memory = (u64)si.totalram * si.mem_unit;
>>>> +             default_gtt_size = total_memory * 3 / 4;
>>>> +             /* This somewhat strange logic is in place because certain GL unit
>>>> +              * tests for large textures can cause problems with the OOM killer
>>>> +              * since there is no way to link this memory to a process.
>>>> +              * The problem is this limit is often too low for many modern games
>>>> +              * on systems with more memory so limit the logic to systems with
>>>> +              * less than 8GB of main memory.
>>>> +              */
>>>> +             if (total_memory < eight_GB) {
>>>> +                     gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>>>> +                                        adev->gmc.mc_vram_size),
>>>> +                                    default_gtt_size);
>>>> +             } else {
>>>> +                     gtt_size = default_gtt_size;
>>>> +             }
>>>> +     } else {
>>>>                gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>>>> +     }
>>>>
>>>>        /* Initialize GTT memory pool */
>>>>        r = amdgpu_gtt_mgr_init(adev, gtt_size);

