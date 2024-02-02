Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645FEC4828E
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 11:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87F710F022;
	Fri,  2 Feb 2024 11:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=froggi.es header.i=@froggi.es header.b="Xrhz+Hib";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB14D10F022
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 11:11:29 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-33b1bb47c4fso671462f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Feb 2024 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1706872287; x=1707477087; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WGx34JASRSbDn0vjsFh0ZguKJmvOPqQ2z1rloPdqGI=;
 b=Xrhz+Hibi0LHsMma8OoXt1AemcyjT1u4QF+tq2/JoQK+NPU7/BCM8DIsgMFt6ZiqBU
 HUbp2Ww4kzRUmPNcTB5wJbwBXhZ89N1kD/DXutdj7hNej6um0z1B1H3pe/q5zChFoC/P
 nTdVP0DsXVe44zo+UHN/EHXhgSi146fZJeNZUYcspnaEY7MUsfivzcXin/UIuo8nwfth
 malJzGGSuAi9Usn+StC61MU+R60i+XayPYse8XicMpleYOlc8ZINvjSFhQFNoxr53bSG
 wzCFzaIvsM2bHPkjlIMYVVf/BKXokD6SpFvAYw2Y2I8G1tOXmHEqq2uHL+ezptC0j62r
 Di+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706872287; x=1707477087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+WGx34JASRSbDn0vjsFh0ZguKJmvOPqQ2z1rloPdqGI=;
 b=F/jHt/3khTwojCr8oojcylM4pgR7zwOcJgYfkTHMWYwXRbAt+8DU6CBltQzJlmnjnJ
 0U20nejsMXwchWOGgkUmdKlPXLhUVtqs54aUdMUAHSPqGOtgUSOd3pOf+Ce1L4J1VYS5
 0prd6/MwCTtzuLcuK1VVJrFOvv+n4cvCAJiCitpk+ohMLC+Y5/gBl7yQNPUU7tcBuIGm
 PohmuzZJI9QD4uIO1TBmhosyZpUHuQ1E1qIwvhIoCle4kdjdxjdgSPQ/hNNftCPQ+tmr
 GE/TS/GK2gLrlMtTTpgJF55KJkbkWhBUblbpWCSa0gsQ2Rfny4W+OSkNtkh6mA1RIxOX
 TKSA==
X-Gm-Message-State: AOJu0YzJSsJaDkiul7/r+pNhySRkZsBy73v++jJi1F0ETT7PQY2Bm1FP
 komawlmRahAjeUur8Ez5CDR1C7NXMMByFT76y49ig2FEH+mEEexOSHtKpF4fPg4=
X-Google-Smtp-Source: AGHT+IGT8j6oNg7oyO1qSRkX4pCWf5Tw80E32f4CV9CqxUzC494wSuy4qfcZ747QqT8Aw2WtdYM1zQ==
X-Received: by 2002:adf:a151:0:b0:33b:1f96:5a1c with SMTP id
 r17-20020adfa151000000b0033b1f965a1cmr996730wrr.9.1706872286877; 
 Fri, 02 Feb 2024 03:11:26 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXhwIzbFfd5pFDDexULHR1BbrFyG+NCuKaqbRpJHdOOEHjxorA0y+1JwoPAltB9QixQu871tCz5sffI92YxIFPjjY4LRXTT5+jmNIj05hPIpuHo1hHeM9qAP8PIQOl0cVntpc41TBR2dOOlXPFXz2yf8KuHCn79MTv9m356xZBwoxAnknb/8qjWaY9TVDJFVY5BX+5i49P4KwDgcBdafnngA3zVdoIz9s9SkzjlLlxcsrAfBUSYd1iB5zUlDf5HIkyEnlvOK8QlxuqxZnmq7vQ8mvU=
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z12-20020adfe54c000000b0033ae54cdd97sm1687867wrm.100.2024.02.02.03.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 03:11:26 -0800 (PST)
Message-ID: <17c04323-b645-492e-8df1-7da8c80416f5@froggi.es>
Date: Fri, 2 Feb 2024 11:11:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
 <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
 <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
 <60efdecd-0957-4e06-9f1e-7343dff87a8a@gmx.de>
 <098e975b-2271-4f11-9549-40bc2c444a28@gmx.de>
 <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
 <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
 <2906c98e-47fe-4a39-b32d-9d060d571076@amd.com>
 <e8d1bca4-61f1-4b44-b70b-c66f8b095860@gmx.de>
 <7483cddf-010e-4df0-80ed-468f744449d8@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <7483cddf-010e-4df0-80ed-468f744449d8@amd.com>
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

Hello Christian,

Any update on finding an upstreamable solution for this problem?

Having working hang recovery is really important for us on Steam Deck, 
and it would be nice to have an upstream solution, and not carry a bunch 
of patches you disagree with. :P

Thanks
- Joshie 🐸✨

On 1/23/24 12:49, Christian König wrote:
> Am 23.01.24 um 12:35 schrieb Friedrich Vock:
>> On 23.01.24 10:36, Christian König wrote:
>>>
>>>
>>> Am 22.01.24 um 23:39 schrieb Joshua Ashton:
>>>> [SNIP]
>>>>>>
>>>>>> Most work submissions in practice submit more waves than the 
>>>>>> number of
>>>>>> wave slots the GPU has.
>>>>>> As far as I understand soft recovery, the only thing it does is
>>>>>> kill all
>>>>>> active waves. This frees up the CUs so more waves are launched, which
>>>>>> can fault again, and that leads to potentially lots of faults for a
>>>>>> single wave slot in the end.
>>>>>
>>>>> Exactly that, but killing each wave takes a moment since we do that
>>>>> in a loop with a bit delay in there.
>>>>>
>>>>> So the interrupt handler should at least in theory have time to
>>>>> catch up.
>>>>
>>>> I don't think there is any delay in that loop is there?
>>>
>>> Mhm, looks like I remember that incorrectly.
>>>
>>>>
>>>>     while (!dma_fence_is_signaled(fence) &&
>>>>            ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>>         ring->funcs->soft_recovery(ring, vmid);
>>>>
>>>> (soft_recovery function does not have a delay/sleep/whatever either)
>>>>
>>>> FWIW, two other changes we did in SteamOS to make recovery more
>>>> reliable on VANGOGH was:
>>>>
>>>> 1) Move the timeout determination after the spinlock setting the
>>>> fence error.
>>>
>>> Well that should not really have any effect.
>>>
>>>>
>>>> 2) Raise the timeout from 0.1s to 1s.
>>>
>>> Well that's not necessarily a good idea. If the SQ isn't able to
>>> respond in 100ms then I would really go into a hard reset.
>>>
>>> Waiting one extra second is way to long here.
>>
>> Bumping the timeout seemed to be necessary in order to reliably
>> soft-recover from hangs with page faults. (Being able to soft-recover
>> from these is actually a really good thing, because if e.g. games
>> accidentally trigger faults, it won't kill a user's entire system.)
> 
> I still have an extremely bad feeling about that. From the discussions a 
> wave which waits for a fault resolution can't be preempted nor killed.
> 
> So what most likely happens is that some of the state sticks around in 
> the hw and can only be cleared with a hard recovery.
> 
> For the steam deck it might still be the better option but that is most 
> likely not the best solution for every use case. It could for example be 
> that the system doesn't have the full performance any more.
> 
>>
>> However, the bump I had in mind was more moderate: Currently the timeout
>> is 10ms (=0.01s). Bumping that to 0.1s already improves reliability
>> enough. I agree that waiting a full second before giving up might be a
>> bit too long.
> 
> Well we should never have a timeout longer than we would expect a 
> submission to be. So assuming a minimum of 10fps we should never go over 
> 100ms or so.
> 
> If killing the waves takes longer than the original submission would 
> have then there is most likely some state not correctly cleared in the 
> hw and we really have to do a hard reset to clean up.
> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Friedrich
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> - Joshie 🐸✨
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Friedrich
>>>>
>>>
> 
