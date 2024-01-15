Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8CFC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 19:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B8789D9A;
	Mon, 15 Jan 2024 19:57:15 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C763089D9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 19:57:14 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e779f0253so10842755e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 11:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705348633; x=1705953433; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3RcpvvMD1PQHQSHRHSbAphyZW7eYVJ+lNsvtqOzpPDw=;
 b=UUAnLesOXzcBRx4isoXRK1duqOQEds7MTjqpsWEtt8soXm5soxLTXl2nXdK3kIgSMs
 4M9Y/7W4vt5Z2Rt6zzO5UP0h4MOCG14H9FHPIFEa4IYwX6i4zgev5xJUOJDm/HyBmsAw
 e8fRr0bxOSaR6Jitp+sCfzJ4GvSxmrJ5VI1PRY4UpQ/XKv2auCjvfGt6BPYfDZWNKD6d
 IyhPDw7SNOCpYrg78m/2A6oFHzZcD/9Wpq5ehaFE9164iDkl2a/0AfsEEDwADRYd5CGA
 QLXAib5dJV94drs2hG4CMFQCwPa4+amdASeRyYOw9kfHl/X1k/ih3eSxldy037c7Wu0w
 1nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705348633; x=1705953433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3RcpvvMD1PQHQSHRHSbAphyZW7eYVJ+lNsvtqOzpPDw=;
 b=GUEzvHgc7jb67oESJt+xpMHQn9vHVcqgn9nym8FMR4QkYL1SkuKES0vU4SHSmJdyvV
 VsewY8Ep6tJvkx5/4vbBD4XsZVztY0WoHPyJfxN3Fhzc9Zybsc8/SPffdWi58aon1+P5
 ySVdZDavRUzyta/PKKDF14x6HB//DFigk0P0bV2qcuxMil1XL8x6blBBdQgHj/aqqx7f
 TvGqjgTwg/yAyfw38u5Rn2d+9P9v4sB70+NOYZlgzXX8L1QIwvTcAyN1s4dQfctDf+7N
 AlwPE8/Hjky0ip1uQwBilDmj1WobYFXiw8oRIxQH/NNA9VBpMdOeqSCudfrpdMF/ejXj
 eG1A==
X-Gm-Message-State: AOJu0YybXQKyJ+CY6p0nwCfiU9qhRp7tO3mk+m/BUH3MIOWxFllZa2nq
 OuJTfP9KavdrMW855N5USwY=
X-Google-Smtp-Source: AGHT+IFGUSbnHLNAUIsm2eMTiBcYghuw8eDI8dpXpTYHP/mvwUiQMHQsHMja5c2jsjYSHWk4nI7OAQ==
X-Received: by 2002:a05:600c:4fd0:b0:40d:8810:468b with SMTP id
 o16-20020a05600c4fd000b0040d8810468bmr3369061wmq.88.1705348632932; 
 Mon, 15 Jan 2024 11:57:12 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c359500b0040e3488f16dsm16730057wmq.12.2024.01.15.11.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 11:57:12 -0800 (PST)
Message-ID: <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
Date: Mon, 15 Jan 2024 20:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 <3e284517-0372-4c75-9902-7039c09b73e9@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3e284517-0372-4c75-9902-7039c09b73e9@froggi.es>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 20:30 schrieb Joshua Ashton:
> On 1/15/24 19:19, Christian König wrote:
>> Am 15.01.24 um 20:13 schrieb Joshua Ashton:
>>> On 1/15/24 18:53, Christian König wrote:
>>>> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
>>>>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>>>>>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock 
>>>>>> <friedrich.vock@gmx.de <mailto:friedrich.vock@gmx.de>> wrote:
>>>>>>
>>>>>>     Re-sending as plaintext, sorry about that
>>>>>>
>>>>>>     On 15.01.24 18:54, Michel Dänzer wrote:
>>>>>>      > On 2024-01-15 18:26, Friedrich Vock wrote:
>>>>>>      >> [snip]
>>>>>>      >> The fundamental problem here is that not telling 
>>>>>> applications that
>>>>>>      >> something went wrong when you just canceled their work 
>>>>>> midway is an
>>>>>>      >> out-of-spec hack.
>>>>>>      >> When there is a report of real-world apps breaking 
>>>>>> because of
>>>>>>     that hack,
>>>>>>      >> reports of different apps working (even if it's 
>>>>>> convenient that they
>>>>>>      >> work) doesn't justify keeping the broken code.
>>>>>>      > If the breaking apps hit multiple soft resets in a row, 
>>>>>> I've laid
>>>>>>     out a pragmatic solution which covers both cases.
>>>>>>     Hitting soft reset every time is the lucky path. Once GPU 
>>>>>> work is
>>>>>>     interrupted out of nowhere, all bets are off and it might as 
>>>>>> well
>>>>>>     trigger a full system hang next time. No hang recovery should 
>>>>>> be able to
>>>>>>     cause that under any circumstance.
>>>>>>
>>>>>>
>>>>>> I think the more insidious situation is no further hangs but 
>>>>>> wrong results because we skipped some work. That we skipped work 
>>>>>> may e.g. result in some texture not being uploaded or some GPGPU 
>>>>>> work not being done and causing further errors downstream (say if 
>>>>>> a game is doing AI/physics on the GPU not to say anything of 
>>>>>> actual GPGPU work one might be doing like AI)
>>>>>
>>>>> Even worse if this is compute on eg. OpenCL for something 
>>>>> science/math/whatever related, or training a model.
>>>>>
>>>>> You could randomly just get invalid/wrong results without even 
>>>>> knowing!
>>>>
>>>> Well on the kernel side we do provide an API to query the result of 
>>>> a submission. That includes canceling submissions with a soft 
>>>> recovery.
>>>>
>>>> What we just doesn't do is to prevent further submissions from this 
>>>> application. E.g. enforcing that the application is punished for 
>>>> bad behavior.
>>>
>>> You do prevent future submissions for regular resets though: Those 
>>> increase karma which sets ctx->guilty, and if ctx->guilty then 
>>> -ECANCELED is returned for a submission.
>>>
>>> ctx->guilty is never true for soft recovery though, as it doesn't 
>>> increase karma, which is the problem this patch is trying to solve.
>>>
>>> By the submission result query API, I you assume you mean checking 
>>> the submission fence error somehow? That doesn't seem very ergonomic 
>>> for a Vulkan driver compared to the simple solution which is to just 
>>> mark it as guilty with what already exists...
>>
>> Well as I said the guilty handling is broken for quite a number of 
>> reasons.
>>
>> What we can do rather trivially is changing this code in 
>> amdgpu_job_prepare_job():
>>
>>          /* Ignore soft recovered fences here */
>>          r = drm_sched_entity_error(s_entity);
>>          if (r && r != -ENODATA)
>>                  goto error;
>>
>> This will bubble up errors from soft recoveries into the entity as 
>> well and makes sure that further submissions are rejected.
>
> That makes sense to do, but at least for GL_EXT_robustness, that will 
> not tell the app that it was guilty.

No, it clearly gets that signaled. We should probably replace the guilty 
atomic with a calls to drm_sched_entity_error().

It's just that this isn't what Marek and I had in mind for this, 
basically completely forget about AMDGPU_CTX_OP_QUERY_STATE or 
AMDGPU_CTX_OP_QUERY_STATE2.

Instead just look at the return value of the CS or query fence result IOCTL.

When you get an -ENODATA you have been guilty of causing a soft 
recovery, when you get an -ETIME you are guilty of causing a timeout 
which had to be hard recovered. When you get an -ECANCELED you are an 
innocent victim of a hard recovery somebody else caused.

What we haven't defined yet is an error code for loosing VRAM, but that 
should be trivial to do.

Regards,
Christian.

>
> We could always return UNKNOWN_CONTEXT_RESET_EXT in that case, I guess.
>
> I am not super sure what is wrong/egrigious about the ctx->guilty 
> handling, is there a previous email thread explaining that?
>
> - Joshie 🐸✨
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> - Joshie 🐸✨
>>>
>>>>
>>>>>
>>>>> Now imagine this is VulkanSC displaying something in the car 
>>>>> dashboard, or some medical device doing some compute work to show 
>>>>> something on a graph...
>>>>>
>>>>> I am not saying you should be doing any of that with RADV + 
>>>>> AMDGPU, but it's just food for thought... :-)
>>>>>
>>>>> As I have been saying, you simply cannot just violate API 
>>>>> contracts like this, it's flatout wrong.
>>>>
>>>> Yeah, completely agree to that.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> - Joshie 🐸✨
>>>>>
>>>>>>
>>>>>>      >
>>>>>>      >
>>>>>>      >> If mutter needs to be robust against faults it caused 
>>>>>> itself, it
>>>>>>     should be robust
>>>>>>      >> against GPU resets.
>>>>>>      > It's unlikely that the hangs I've seen were caused by mutter
>>>>>>     itself, more likely Mesa or amdgpu.
>>>>>>      >
>>>>>>      > Anyway, this will happen at some point, the reality is it 
>>>>>> hasn't
>>>>>>     yet though.
>>>>>>      >
>>>>>>      >
>>>>>>
>>>>
>>>
>>> - Joshie 🐸✨
>>

