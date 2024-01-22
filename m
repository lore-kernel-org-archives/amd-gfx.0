Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51379C46CD2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD62810F0A4;
	Mon, 22 Jan 2024 22:40:16 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC57510F0A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 22:40:10 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so47593645e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 14:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705963149; x=1706567949; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXX4PBBgW7CZPJzzjpr5xUI+MQDdiVRDNM50miw4wqI=;
 b=F8N+AV4E5fRyP03X/r7PFzZRFHjcWMIl77WYkDz04FiFIY97q+ahPCw695s3J8RnhN
 8iEFbi5sKVj3TQDMnxkVvfAZsa6ARx4R1+ZnEHAokOhYyV0s0ggVLD4R2LVKMamPyRM9
 B42s9+dwpLluiSi8C25m2EZRmZXHsMop17W+7r4QOG4Q3FP45CHwBMpW96lLpN8Tvob/
 eE9ti2zRJ5xL6vGbFaCK3TrMFXKtd15Of58d/ReFHOxjvLhC3GuW5rCs/i6e0hREYYg4
 1RDvAJr/KyJbCDN1zLFgDjoKicjHWuGj+fQEFg1/vbgAjn3nyVvJM8elht3ZLrr5YqVO
 IUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963149; x=1706567949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXX4PBBgW7CZPJzzjpr5xUI+MQDdiVRDNM50miw4wqI=;
 b=gOVuDzYkUaJuRiA020rl80r1XwlpV467PcpmVu4Vw6L70ak3/yk9zA4y3d5Al2aPza
 BB3i8yWbYUz8m1zP9MSaDBZecJlxjKgiP6QZ4bIZGayjFdAq2PF0hyGOK4MPe3k8l8tm
 4brtQbD0wzMv/KafgUtdnw1FlCPZZ92A+4NauTGinM/p4oYBj1DHITklL1GNfr2AVSVj
 jvhznH/DeLQm5d30R5JXq7vP18/29CwXL3KX4snklr5oyZSZ/IvAw+ejFRwA6n9FU6pt
 gPyT/iUObprySTmO2sZBvc66nSye27jcwNEMU2J2jAXNAWgvBZ28iZQI9docghNcWi6A
 hFqg==
X-Gm-Message-State: AOJu0YybzSTZcAjOpDg4UsUt8yhsDOG/IjAU9sDJq+T0Bpc5lZyOJj0e
 IHbdi7LlNmTyhxm+0X3ABlLh1GPnch58fh75fDPEeCWUXQ+5Uuqj8UNosZ8o/eU=
X-Google-Smtp-Source: AGHT+IHh0oLUq5rxBK9X3KFN6sae8Q5Pl5zzjbet3yZewtSFKqq+pB0+ik1Jbx+8bzC/0bJyfaRkqw==
X-Received: by 2002:a1c:4b0e:0:b0:40e:5560:1ad9 with SMTP id
 y14-20020a1c4b0e000000b0040e55601ad9mr2555615wma.101.1705963148913; 
 Mon, 22 Jan 2024 14:39:08 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040e4733aecbsm40361622wmq.15.2024.01.22.14.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 14:39:08 -0800 (PST)
Message-ID: <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
Date: Mon, 22 Jan 2024 22:39:07 +0000
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
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/22/24 13:35, Christian König wrote:
> Am 22.01.24 um 11:45 schrieb Friedrich Vock:
>> On 22.01.24 11:21, Friedrich Vock wrote:
>>> On 22.01.24 11:10, Christian König wrote:
>>>> Am 19.01.24 um 20:18 schrieb Felix Kuehling:
>>>>> On 2024-01-18 07:07, Christian König wrote:
>>>>>> Am 18.01.24 um 00:44 schrieb Friedrich Vock:
>>>>>>> On 18.01.24 00:00, Alex Deucher wrote:
>>>>>>> [SNIP]
>>>>>>> No, amdgpu.noretry=1 does not change anything.
>>>>>>
>>>>>> Well the good news first the hw engineer answered rather quickly.
>>>>>> The bad news is that the hardware really doesn't work as documented
>>>>>> in multiple ways.
>>>>>>
>>>>>> First of all the CLEAR bit is a level and not a trigger, so the
>>>>>> intention to clear it is indeed correct. For now please modify this
>>>>>> patch so that the CLEAR bit is set and cleared directly after
>>>>>> setting it, this way we should be able to detect further overflows
>>>>>> immediately.
>>>>>>
>>>>>> Then the APU the Steam Deck uses simply doesn't have the filter
>>>>>> function for page faults in the hardware, the really bad news is it
>>>>>> also doesn't have the extra IH rings where we could re-route the
>>>>>> faults to prevent overflows.
>>>>>>
>>>>>> That full explains the behavior you have been seeing, but doesn't
>>>>>> really provide a doable solution to mitigate this problem.
>>>>>>
>>>>>> I'm going to dig deeper into the hw documentation and specification
>>>>>> to see if we can use a different feature to avoid the overflow.
>>>>>
>>>>> If we're not enabling retry faults, then each wave front should
>>>>> generate at most one fault. You should be able to avoid overflows by
>>>>> making the IH ring large enough to accommodate one fault per wave
>>>>> front.
>>>>
>>>> That is the exact same argument our HW engineers came up with when we
>>>> asked why the APU is missing all those nice IH ring overflow avoidance
>>>> features the dGPUs have :)
>>>>
>>> I can reproduce IH overflows on my RX 6700 XT dGPU as well FWIW.
> 
> Interesting data point. We have probably looked to much into the faults 
> on MI* products and never checked Navi.
> 
> Can you try to just setting WPTR_OVERFLOW_ENABLE to 0? At least in 
> theory that should disable IH overflows altogether on Navi without 
> causing loss of IVs.
> 
>>>
>>>> The only problem with this approach is that on Navi when a wave is
>>>> blocked by waiting on a fault you can't kill it using soft recovery
>>>> any more (at least when my understanding is correct).
>>>>
>>> Killing page-faulted waves via soft recovery works. From my testing on
>>> Deck, it seems to take a bit of time, but if you try for long enough
>>> soft recovery eventually succeeds.
> 
> Ok that is massively strange. We had tons of discussions about that 
> shader can't be interrupted while they wait for a fault on Navi.
> 
> Maybe killing them is still possible, need to double check that as well.
> 
>>
>>
>> On second thought, could it be that this is the critical flaw in the "at
>> most one fault per wave" thinking?
> 
> Well completely agree that this. That rational to leave out the new IH 
> features on APUs is rather weak.
> 
>>
>> Most work submissions in practice submit more waves than the number of
>> wave slots the GPU has.
>> As far as I understand soft recovery, the only thing it does is kill all
>> active waves. This frees up the CUs so more waves are launched, which
>> can fault again, and that leads to potentially lots of faults for a
>> single wave slot in the end.
> 
> Exactly that, but killing each wave takes a moment since we do that in a 
> loop with a bit delay in there.
> 
> So the interrupt handler should at least in theory have time to catch up.

I don't think there is any delay in that loop is there?

	while (!dma_fence_is_signaled(fence) &&
	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
		ring->funcs->soft_recovery(ring, vmid);

(soft_recovery function does not have a delay/sleep/whatever either)

FWIW, two other changes we did in SteamOS to make recovery more reliable 
on VANGOGH was:

1) Move the timeout determination after the spinlock setting the fence 
error.

2) Raise the timeout from 0.1s to 1s.

- Joshie 🐸✨


> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Friedrich

