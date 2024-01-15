Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12BEC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 19:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D3910E389;
	Mon, 15 Jan 2024 19:30:33 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E406B10E389
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 19:30:30 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso44004805e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705347029; x=1705951829; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVydy1iKlJRF/FkaYVVD1lIq0c5dfIbQdNgusGzFOeM=;
 b=LIvhKDV3RWb0D4jXB0WGg4Ddnubi6sa4koueuHE9g4aSkrMPzx6szP0EfZvSgroV+f
 QZSLnSmKJf4UYtoYPnh1XNONc/DxqX7wHK18hSysNdq5UmGIoldookmhhPh/T5sQzXTt
 BXlb+VavE+Smu1e7lhnX0PFRXBbkk6AaQL4cJPs9RhqT1KGq9OBNRsfSE98VcTviPHVq
 SiOoq8QsSr4Gp+YW2fqNc/H185B+vp7UIYUjoZGgaMjNmQb+S6eBNbdEECraddHUpY37
 vApDXhRz0WlMB/l2YZxyxJRhUaV9QsHVGXQYJbNFfdzCwgpLMsRJcF+SXlzrvWbcJ6Nl
 7lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705347029; x=1705951829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVydy1iKlJRF/FkaYVVD1lIq0c5dfIbQdNgusGzFOeM=;
 b=ru1RHtTHOSICcao0YObEVlKLj9Ad5n66p3EwmxHH4sdoNZ/CZRJSJM9mEp1L1hfLQN
 /tfOOGQJwozvUYoGSst3QvT1osTlFDgqC14th6u1hAeb6z+/7WhicvpfXTOf0/AJr83t
 NXZOWKOLb7ycwr0HOQgyW/UuIxPyxd0xFLlQUNidqnaasbADYLLRgQfzdxeALts/1Vj/
 qlE6UINd9/272H0M5qtMpz41YTnvWUbXv7UxwHe5alPw0WsM5dbrasbQVEWRv/qo3VTi
 zFi1CvC9pMpnuB1hzxnTHIYdUIVmwoOU1Wp2SxpLhCXySuvpzPu2iSTtLcSi65RKwQpX
 YsJw==
X-Gm-Message-State: AOJu0YypYLbsh/r4DYkLIxlRrDHQ4xchRYJyZTJZszv7CMZ3HAEv+8bT
 mDeFy8h5g39rk6SJZdkk45TEp58TemGvqQ==
X-Google-Smtp-Source: AGHT+IFsenyTJL96F/wt/z/TfOs5ILg2/MduGWPaTpp65geNY22Mrlblq79N/kDxuVYEUF3GcXtYag==
X-Received: by 2002:a05:600c:84c3:b0:40e:5d36:8bb9 with SMTP id
 er3-20020a05600c84c300b0040e5d368bb9mr2915951wmb.32.1705347029202; 
 Mon, 15 Jan 2024 11:30:29 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 co8-20020a0560000a0800b00336755f15b0sm12724004wrb.68.2024.01.15.11.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 11:30:28 -0800 (PST)
Message-ID: <3e284517-0372-4c75-9902-7039c09b73e9@froggi.es>
Date: Mon, 15 Jan 2024 19:30:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
 <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
 <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
 <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
 <bfe79411-7f77-48ab-8cfd-4727704739e8@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <bfe79411-7f77-48ab-8cfd-4727704739e8@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 19:19, Christian König wrote:
> Am 15.01.24 um 20:13 schrieb Joshua Ashton:
>> On 1/15/24 18:53, Christian König wrote:
>>> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
>>>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>>>>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock 
>>>>> <friedrich.vock@gmx.de <mailto:friedrich.vock@gmx.de>> wrote:
>>>>>
>>>>>     Re-sending as plaintext, sorry about that
>>>>>
>>>>>     On 15.01.24 18:54, Michel Dänzer wrote:
>>>>>      > On 2024-01-15 18:26, Friedrich Vock wrote:
>>>>>      >> [snip]
>>>>>      >> The fundamental problem here is that not telling 
>>>>> applications that
>>>>>      >> something went wrong when you just canceled their work 
>>>>> midway is an
>>>>>      >> out-of-spec hack.
>>>>>      >> When there is a report of real-world apps breaking because of
>>>>>     that hack,
>>>>>      >> reports of different apps working (even if it's convenient 
>>>>> that they
>>>>>      >> work) doesn't justify keeping the broken code.
>>>>>      > If the breaking apps hit multiple soft resets in a row, I've 
>>>>> laid
>>>>>     out a pragmatic solution which covers both cases.
>>>>>     Hitting soft reset every time is the lucky path. Once GPU work is
>>>>>     interrupted out of nowhere, all bets are off and it might as well
>>>>>     trigger a full system hang next time. No hang recovery should 
>>>>> be able to
>>>>>     cause that under any circumstance.
>>>>>
>>>>>
>>>>> I think the more insidious situation is no further hangs but wrong 
>>>>> results because we skipped some work. That we skipped work may e.g. 
>>>>> result in some texture not being uploaded or some GPGPU work not 
>>>>> being done and causing further errors downstream (say if a game is 
>>>>> doing AI/physics on the GPU not to say anything of actual GPGPU 
>>>>> work one might be doing like AI)
>>>>
>>>> Even worse if this is compute on eg. OpenCL for something 
>>>> science/math/whatever related, or training a model.
>>>>
>>>> You could randomly just get invalid/wrong results without even knowing!
>>>
>>> Well on the kernel side we do provide an API to query the result of a 
>>> submission. That includes canceling submissions with a soft recovery.
>>>
>>> What we just doesn't do is to prevent further submissions from this 
>>> application. E.g. enforcing that the application is punished for bad 
>>> behavior.
>>
>> You do prevent future submissions for regular resets though: Those 
>> increase karma which sets ctx->guilty, and if ctx->guilty then 
>> -ECANCELED is returned for a submission.
>>
>> ctx->guilty is never true for soft recovery though, as it doesn't 
>> increase karma, which is the problem this patch is trying to solve.
>>
>> By the submission result query API, I you assume you mean checking the 
>> submission fence error somehow? That doesn't seem very ergonomic for a 
>> Vulkan driver compared to the simple solution which is to just mark it 
>> as guilty with what already exists...
> 
> Well as I said the guilty handling is broken for quite a number of reasons.
> 
> What we can do rather trivially is changing this code in 
> amdgpu_job_prepare_job():
> 
>          /* Ignore soft recovered fences here */
>          r = drm_sched_entity_error(s_entity);
>          if (r && r != -ENODATA)
>                  goto error;
> 
> This will bubble up errors from soft recoveries into the entity as well 
> and makes sure that further submissions are rejected.

That makes sense to do, but at least for GL_EXT_robustness, that will 
not tell the app that it was guilty.

We could always return UNKNOWN_CONTEXT_RESET_EXT in that case, I guess.

I am not super sure what is wrong/egrigious about the ctx->guilty 
handling, is there a previous email thread explaining that?

- Joshie 🐸✨

> 
> Regards,
> Christian.
> 
>>
>> - Joshie 🐸✨
>>
>>>
>>>>
>>>> Now imagine this is VulkanSC displaying something in the car 
>>>> dashboard, or some medical device doing some compute work to show 
>>>> something on a graph...
>>>>
>>>> I am not saying you should be doing any of that with RADV + AMDGPU, 
>>>> but it's just food for thought... :-)
>>>>
>>>> As I have been saying, you simply cannot just violate API contracts 
>>>> like this, it's flatout wrong.
>>>
>>> Yeah, completely agree to that.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> - Joshie 🐸✨
>>>>
>>>>>
>>>>>      >
>>>>>      >
>>>>>      >> If mutter needs to be robust against faults it caused 
>>>>> itself, it
>>>>>     should be robust
>>>>>      >> against GPU resets.
>>>>>      > It's unlikely that the hangs I've seen were caused by mutter
>>>>>     itself, more likely Mesa or amdgpu.
>>>>>      >
>>>>>      > Anyway, this will happen at some point, the reality is it 
>>>>> hasn't
>>>>>     yet though.
>>>>>      >
>>>>>      >
>>>>>
>>>
>>
>> - Joshie 🐸✨
> 
