Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FEDC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 14:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AD210E9AB;
	Wed, 28 Sep 2022 14:47:05 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447B510E9CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 14:46:59 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id lh5so27638760ejb.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=jh1W0rVtbzibuA/R7gVDik2bSX8lVE96Mfw3a9PLXhM=;
 b=OqasurebgWUDHwiVlCH65xsp8vDY6f6QdbNiyDQ/Y7jxP5CmMoL4HjYK5shY9wKbi8
 I/lIj8Bum4lzp6pE6F7JAPLB2Hj9V6kresf78zXp/jQI0yrqZLz0gcjLYkWEqaqRpmHI
 sUrb5syyqr3abyYSOcZ513jXpmioYsCeRd0L8UTVV4ppVc3fq0cshqCX0GMcBBSTTCHb
 cNcP+roKIxU4F26+5OwxLiWOVSQ1TNe3TdRdV8sY4tCvKxwrVq0c1mlVgVzgV5wswUWa
 Q4ILPD7Cz85URhiww79IMIkncmWhjoXO/P8T3HhI35+ABgXKBFiyNxhJHQZuf4Gx6SXG
 wQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=jh1W0rVtbzibuA/R7gVDik2bSX8lVE96Mfw3a9PLXhM=;
 b=NJi4ElHEuBZZ15lJxIx96XNjGcf2NJAVy1Uhctx+EOaQlrl58TUADW9qsO+KbHgPIB
 YZG3qYjRXm8iclOLB4M9xdGnYvxzQRK6JRkEEuTZt6pSVDN2zEOzL2EX+wSpqd0B9ilM
 UMgGSygyVtMRXV16xISOjySTV/mrf3/QhebuKyxn70yiHIHuKEkQBV7Omm++DLQed7hr
 OEE8C08enjOObbNczpo9dC1d8sFF5Qt1mFdgUTR50tO+QApqrA1PZ6SAxs7/iIhorkLs
 HjtmVXISaRKovlr1srIIuykK5q4zvBGgv+h6YGyvzGHHsY3W4uNesGjPCfcNjnYq7sjn
 yfCA==
X-Gm-Message-State: ACrzQf3MmgZDtMvt2BBJwodaEQPe5XPzLk47vMYR6Ph+ENn4Kh6y6x0D
 /DwpYs/xT8dUK/YqtsHpqSc=
X-Google-Smtp-Source: AMsMyM6RRH9d0J/S1AU1tF+uZ4FxbWk5Dn17D/N2h4rfw85F91bE7Kj1tBzhogif8YzJKJoDsykr3A==
X-Received: by 2002:a17:907:7e9d:b0:782:3601:7d01 with SMTP id
 qb29-20020a1709077e9d00b0078236017d01mr27395522ejc.361.1664376417688; 
 Wed, 28 Sep 2022 07:46:57 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fe7b:c1da:17d4:a63a?
 ([2a02:908:1256:79a0:fe7b:c1da:17d4:a63a])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a50ab0c000000b004580b26e32esm39821edc.81.2022.09.28.07.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Sep 2022 07:46:57 -0700 (PDT)
Message-ID: <849a8d68-c752-ace3-3823-26ff247896c8@gmail.com>
Date: Wed, 28 Sep 2022 16:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] drm/amdgpu: MCBP based on DRM scheduler (v6)
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20220923131630.1260501-1-jiadong.zhu@amd.com>
 <20220923131630.1260501-4-jiadong.zhu@amd.com>
 <3d88b423-1d14-2954-e3ce-0c50887cf621@gmail.com>
 <DS7PR12MB633336F275D92829CA93BF2CF4559@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fad25aa5-3f0a-0135-e580-1c96bfc37120@amd.com>
 <6a8623f8-941f-4fa4-b0e4-0beb9b4715b3@daenzer.net>
 <4c9c09b3-abbd-1dff-33f6-e9478e8a137c@amd.com>
 <DS7PR12MB633351087443795FA98B47F6F4549@DS7PR12MB6333.namprd12.prod.outlook.com>
 <d1967e64-8561-163a-fe93-be3e0b827f50@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d1967e64-8561-163a-fe93-be3e0b827f50@daenzer.net>
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.22 um 15:52 schrieb Michel Dänzer:
> On 2022-09-28 03:01, Zhu, Jiadong wrote:>
>> Please make sure umd is calling the libdrm function to create context with different priories,
>> amdgpu_cs_ctx_create2(device_handle, AMDGPU_CTX_PRIORITY_HIGH, &context_handle).
> Yes, I double-checked that, and that it returns success.
>
>
>> Here is the behavior we could see:
>> 1. After modprobe amdgpu, two software rings named gfx_high/gfx_low(in previous patch named gfx_sw) is visible in UMR. We could check the wptr/ptr to see if it is being used.
>> 2. MCBP happens while the two different priority ibs are submitted at the same time. We could check fence info as below:
>> Last signaled trailing fence++  when the mcbp triggers by kmd. Last preempted may not increase as the mcbp is not triggered from CP.
>>
>> --- ring 0 (gfx) ---
>> Last signaled fence          0x00000001
>> Last emitted                 0x00000001
>> Last signaled trailing fence 0x0022eb84
>> Last emitted                 0x0022eb84
>> Last preempted               0x00000000
>> Last reset                   0x00000000
> I've now tested on this Picasso (GFX9) laptop as well. The "Last signaled trailing fence" line is changing here (seems to always match the "Last emitted" line).
>
> However, mutter's frame rate still cannot exceed that of GPU-limited clients. BTW, you can test with a GNOME Wayland session, even without my MR referenced below. Preemption will just be less effective without that MR. mutter has used a high priority context when possible for a long time.
>
> I'm also seeing intermittent freezes, where not even the mouse cursor moves for up to around one second, e.g. when interacting with the GNOME top bar. I'm not sure yet if these are related to this patch series, but I never noticed it before. I wonder if the freezes might occur when GPU preemption is attempted.

Keep in mind that this doesn't have the same fine granularity as the 
separate hw ring buffer found on gfx10.

With MCBP we can only preempt on draw command boundary, while the 
separate hw ring solution can preempt as soon as a CU is available.

>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>
>>> This work is solely for gfx9 (e.g. Vega) and older.
>>>
>>> Navi has a completely separate high priority gfx queue we can use for this.
> Right, but 4c7631800e6b ("drm/amd/amdgpu: add pipe1 hardware support") was for Sienna Cichlid only, and turned out to be unstable, so it had to reverted.
>
> It would be nice to make the SW ring solution take effect by default whenever there is no separate high priority HW gfx queue available (and any other requirements are met).

I don't think that this will be a good idea. The hw ring buffer or even 
hw scheduler have much nicer properties and we should focus on getting 
that working when available.

Regards,
Christian.

>
>
>> Am 27.09.22 um 19:49 schrieb Michel Dänzer:
>>> On 2022-09-27 08:06, Christian König wrote:
>>>> Hey Michel,
>>>>
>>>> JIadong is working on exposing high/low priority gfx queues for gfx9 and older hw generations by using mid command buffer preemption.
>>> Yeah, I've been keeping an eye on these patches. I'm looking forward to this working.
>>>
>>>
>>>> I know that you have been working on Gnome Mutter to make use from userspace for this. Do you have time to run some tests with that?
>>> I just tested the v8 series (first without amdgpu.mcbp=1 on the kernel command line, then with it, since I wasn't sure if it's needed) with https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.gnome.org%2FGNOME%2Fmutter%2F-%2Fmerge_requests%2F1880&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cc6345d9230004549ba4d08daa0b0abcd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637998977913548768%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=P1Qo2AwDmfmPrxJe2SxTFsVjdJ9vjabK8s84ZVz%2Beh8%3D&amp;reserved=0 on Navi 14.
>>>
>>> Unfortunately, I'm not seeing any change in behaviour. Even though mutter uses a high priority context via the EGL_IMG_context_priority extension, it's unable to reach a higher frame rate than a GPU-limited client[0]. The "Last preempted" line of /sys/kernel/debug/dri/0/amdgpu_fence_info remains at 0x00000000.
>>>
>>> Did I miss a step?
>>>
>>>
>>> [0] I used the GpuTest pixmark piano & plot3d benchmarks. With an Intel iGPU, mutter can achieve a higher frame rate than plot3d, though not than pixmark piano (presumably due to limited GPU preemption granularity).
>

