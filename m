Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1B7C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 16:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E158110E0FA;
	Mon, 15 Jan 2024 16:46:29 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7504710E313
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 16:46:28 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso7672321f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705337187; x=1705941987; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLV+twPsZXTEZR6YfYxxQqyQilV9msBpaljsEM2PKYM=;
 b=G+WPo/OoX95yWReSp5fYYpO3bsQfju5ztN0Lxm3FJSCMYDoazyCMMsvqHBFZo8v3oZ
 1uOzKu9ZTcbNRqi2CX6/MKmQzM8qpS5PweivQvvMwXPibjAO75SZstpbx4OyPSQJecH6
 XHFLZeyk/zGmfOKTaaNPIVtoqYSxbH/iF3Rw52zoy4uhIBOCmGhFzjP1+TjTwUCSsykB
 09fi04U8gTl5mTQ4ruosky7nheRxeH5hbumQXQPH0cpCOCF35gZ7ABkc+7QKtmEefc9O
 YToxMTtiKWiZYsfI0dYxlZGdR6nxvpEPIv2RqNdDsHJDJF0s5vtPAnnBr2rcqceuo02P
 //cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705337187; x=1705941987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLV+twPsZXTEZR6YfYxxQqyQilV9msBpaljsEM2PKYM=;
 b=aZsYG4yIPhNJ5Ni/PJfNQzsSCWDCVf676GA2+xWpzPeZEBQMOC/Fc2UKd5FZnUBXGM
 JcK7ljpUQ7sbrjs1nECUQbiedUNvEEpFEkh0lAWZyVBQiHySt4m/BffMG5zO6515WZcF
 Vjh0tP/Yo7AVTvylXX3m7C/VvWOP7yPaxHJA4KTL1DNDzvz+RZQFyQQu6eQUpIMCGikA
 CEHj16GsD67AftGbT34ttv3m+Tg0TAQpXn/WLagkn+7bpg0Re3HbwGcPFJEkRIdotAbh
 XmUvYLuLtl3jmJSD4+1CUkR6tg7K0pEJrRlqcS+g5xrpwLifnAWD0E8pdr8+J5j2nZfk
 7G/g==
X-Gm-Message-State: AOJu0YwaZt2trp6BC6DkiDUR+13fNkF8EiHsCd9/YF2PAnVqSCHdFrSU
 wB/hSXRKePbb9Glm5WJ6rBXMa+LbPGoOfg==
X-Google-Smtp-Source: AGHT+IG4LBhBmAqWxl4YrvRJXRxJ2/E1cXrCShcC4o+hXVdWLsH5MjFOm06AXTm4x/n0N0btOItawg==
X-Received: by 2002:a5d:6192:0:b0:336:87a2:ffd3 with SMTP id
 j18-20020a5d6192000000b0033687a2ffd3mr3695920wru.49.1705337186767; 
 Mon, 15 Jan 2024 08:46:26 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a5d6101000000b003374555d88esm12323129wrt.56.2024.01.15.08.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 08:46:26 -0800 (PST)
Message-ID: <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
Date: Mon, 15 Jan 2024 16:46:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
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
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 16:34, Michel Dänzer wrote:
> On 2024-01-15 17:19, Friedrich Vock wrote:
>> On 15.01.24 16:43, Joshua Ashton wrote:
>>> On 1/15/24 15:25, Michel Dänzer wrote:
>>>> On 2024-01-15 14:17, Christian König wrote:
>>>>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>>>>>> On 1/15/24 09:40, Christian König wrote:
>>>>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>>>>>
>>>>>>>> Without this feedback, the application may keep pushing through
>>>>>>>> the soft
>>>>>>>> recoveries, continually hanging the system with jobs that timeout.
>>>>>>>
>>>>>>> Well, that is intentional behavior. Marek is voting for making
>>>>>>> soft recovered errors fatal as well while Michel is voting for
>>>>>>> better ignoring them.
>>>>>>>
>>>>>>> I'm not really sure what to do. If you guys think that soft
>>>>>>> recovered hangs should be fatal as well then we can certainly do
>>>>>>> this.
>>>>
>>>> A possible compromise might be making soft resets fatal if they
>>>> happen repeatedly (within a certain period of time?).
>>>
>>> No, no and no. Aside from introducing issues by side effects not
>>> surfacing and all of the stuff I mentioned about descriptor buffers,
>>> bda, draw indirect and stuff just resulting in more faults and hangs...
>>>
>>> You are proposing we throw out every promise we made to an application
>>> on the API contract level because it "might work". That's just wrong!
>>>
>>> Let me put this in explicit terms: What you are proposing is in direct
>>> violation of the GL and Vulkan specification.
>>>
>>> You can't just chose to break these contracts because you think it
>>> 'might' be a better user experience.
>>
>> Is the original issue that motivated soft resets to be non-fatal even an
>> issue anymore?
>>
>> If I read that old thread correctly, the rationale for that was that
>> assigning guilt to a context was more broken than not doing it, because
>> the compositor/Xwayland process would also crash despite being unrelated
>> to the hang.
>> With Joshua's Mesa fixes, this is not the case anymore, so I don't think
>> keeping soft resets non-fatal provides any benefit to the user experience.
>> The potential detriments to user experience have been outlined multiple
>> times in this thread already.
>>
>> (I suppose if the compositor itself faults it might still bring down a
>> session, but I've literally never seen that, and it's not like a
>> compositor triggering segfaults on CPU stays alive either.)
> 
> That's indeed what happened for me, multiple times. And each time the session continued running fine for days after the soft reset.
> 
> But apparently my experience isn't valid somehow, and I should have been forced to log in again to please the GL gods...
> 
> 
> Conversely, I can't remember hitting a case where an app kept running into soft resets. It's almost as if different people may have different experiences! ;)

Your anecdote of whatever application coincidentally managing to soldier 
through being hung is really not relevant.

The right thing to do is to not break all of our api contracts with the 
application and not egregiously violate the VK and GL specs. :-)

No-one is saying your session should go down.
It looks like Mutter already has some handling for GL robustness anyway...
So this should already just work with these patches if it is not broken?

- Joshie 🐸✨

> 
> Note that I'm not saying that case can't happen. Making soft resets fatal only if they happen repeatedly could address both issues, rather than only one or the other. Seems like a win-win.
> 
> 
