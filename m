Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAACDC47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 12:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA9310E4C8;
	Tue, 16 Jan 2024 12:25:36 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1832D10E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 12:25:30 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-40e76626170so21757345e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705407869; x=1706012669; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pwXABFOvRBPzESNTSetN4pdlSIrSPtPHl6I6jKGTq0A=;
 b=BZb9LCRe9TUBkqlfrbMElyQrsFJ+kSTAPPSnyl6uYNL3stNThJXheiZKApunmvkSKk
 1oWBFZ41xlGi5XigU4LDQzNnkZMjWMryQGVfc926kTTp2JTgMiXdk03BdNaMM5hC+mFE
 oqMFZ1WGczFWodNiK9GKrB2S+QXx5T8YZRqn+7ITw4KVdp1nxWoOIS9yaWIu8tbbfrwg
 3mA+b9b1Mk+ZnK8cKVCIls7y/SSopucuoUT7GVjHtDHTiku2REgYl17CbRjJdu66z2C2
 /73jG4ORpTTquZk4tiHu4zcJMvWdPYr1fskPLS6+GLyIcaoEgBwc1hb4us9HMCXMEjqu
 mOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705407869; x=1706012669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pwXABFOvRBPzESNTSetN4pdlSIrSPtPHl6I6jKGTq0A=;
 b=XRn8ngN8HedWYR01K/z/PoZGWKvzntpfbXIyHo4ri8TsaKccCOEqC8oxfekgMz69LL
 emtVKdSyez+StdiyrZ0n5cbJTjwSuyo14Xb1h1Bol3iOAs82Pkj3lQafp8E1KSnWBgal
 JvRx7EHxUQ6eddEOrmaDfO9VOWlC5evit+mjmC9VsnK7apWo4gFstGV5xumVWL1L3PrH
 ZsUcsQEpyvCwv532/D9f4MlUo/vZzJf2rjWhFILNFkiQmTpWH+IsGJDrFLzHrOmSauBu
 T+li94qNe3bQ59KYG6k53XCS2+7HNlDxKkEdRw5gie6BODejCrXwYP32y0xfngwBvfMX
 9eXw==
X-Gm-Message-State: AOJu0YzXoUyWYZTVKA4pXNZx3iShlWxNWPePFhRKhHs67OpJzlTCgol0
 ER8OyPcGZLCiuV7dM1mF74YHqWGunho0Qg==
X-Google-Smtp-Source: AGHT+IEC2to/fQoWmDZH+shAB90O0o7GIvjRyxe3zWk4WjTC40wU6SjER2i+9vpv/OKdSF2A15vbJg==
X-Received: by 2002:a05:600c:247:b0:40e:69da:f5f9 with SMTP id
 7-20020a05600c024700b0040e69daf5f9mr2709734wmj.33.1705407868570; 
 Tue, 16 Jan 2024 04:24:28 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a5d474c000000b00336aac53e75sm14470437wrs.97.2024.01.16.04.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 04:24:28 -0800 (PST)
Message-ID: <2a9a1a92-a074-456e-8190-3ba0a30d3f30@froggi.es>
Date: Tue, 16 Jan 2024 12:24:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
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
 <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
 <CAAxE2A5v_RkZ9ex4=7jiBSKVb22_1FAj0AANBcmKtETt5c3gVA@mail.gmail.com>
 <de47a17b-3d19-4c74-b77a-e08b0e94cc69@gmail.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <de47a17b-3d19-4c74-b77a-e08b0e94cc69@gmail.com>
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
 Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/16/24 07:47, Christian König wrote:
> Am 16.01.24 um 01:05 schrieb Marek Olšák:
>> On Mon, Jan 15, 2024 at 3:06 PM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 15.01.24 um 20:30 schrieb Joshua Ashton:
>>>> On 1/15/24 19:19, Christian König wrote:
>>>>> Am 15.01.24 um 20:13 schrieb Joshua Ashton:
>>>>>> On 1/15/24 18:53, Christian König wrote:
>>>>>>> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
>>>>>>>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>>>>>>>>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock
>>>>>>>>> <friedrich.vock@gmx.de <mailto:friedrich.vock@gmx.de>> wrote:
>>>>>>>>>
>>>>>>>>>      Re-sending as plaintext, sorry about that
>>>>>>>>>
>>>>>>>>>      On 15.01.24 18:54, Michel Dänzer wrote:
>>>>>>>>>       > On 2024-01-15 18:26, Friedrich Vock wrote:
>>>>>>>>>       >> [snip]
>>>>>>>>>       >> The fundamental problem here is that not telling
>>>>>>>>> applications that
>>>>>>>>>       >> something went wrong when you just canceled their work
>>>>>>>>> midway is an
>>>>>>>>>       >> out-of-spec hack.
>>>>>>>>>       >> When there is a report of real-world apps breaking
>>>>>>>>> because of
>>>>>>>>>      that hack,
>>>>>>>>>       >> reports of different apps working (even if it's
>>>>>>>>> convenient that they
>>>>>>>>>       >> work) doesn't justify keeping the broken code.
>>>>>>>>>       > If the breaking apps hit multiple soft resets in a row,
>>>>>>>>> I've laid
>>>>>>>>>      out a pragmatic solution which covers both cases.
>>>>>>>>>      Hitting soft reset every time is the lucky path. Once GPU
>>>>>>>>> work is
>>>>>>>>>      interrupted out of nowhere, all bets are off and it might as
>>>>>>>>> well
>>>>>>>>>      trigger a full system hang next time. No hang recovery should
>>>>>>>>> be able to
>>>>>>>>>      cause that under any circumstance.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think the more insidious situation is no further hangs but
>>>>>>>>> wrong results because we skipped some work. That we skipped work
>>>>>>>>> may e.g. result in some texture not being uploaded or some GPGPU
>>>>>>>>> work not being done and causing further errors downstream (say if
>>>>>>>>> a game is doing AI/physics on the GPU not to say anything of
>>>>>>>>> actual GPGPU work one might be doing like AI)
>>>>>>>> Even worse if this is compute on eg. OpenCL for something
>>>>>>>> science/math/whatever related, or training a model.
>>>>>>>>
>>>>>>>> You could randomly just get invalid/wrong results without even
>>>>>>>> knowing!
>>>>>>> Well on the kernel side we do provide an API to query the result of
>>>>>>> a submission. That includes canceling submissions with a soft
>>>>>>> recovery.
>>>>>>>
>>>>>>> What we just doesn't do is to prevent further submissions from this
>>>>>>> application. E.g. enforcing that the application is punished for
>>>>>>> bad behavior.
>>>>>> You do prevent future submissions for regular resets though: Those
>>>>>> increase karma which sets ctx->guilty, and if ctx->guilty then
>>>>>> -ECANCELED is returned for a submission.
>>>>>>
>>>>>> ctx->guilty is never true for soft recovery though, as it doesn't
>>>>>> increase karma, which is the problem this patch is trying to solve.
>>>>>>
>>>>>> By the submission result query API, I you assume you mean checking
>>>>>> the submission fence error somehow? That doesn't seem very ergonomic
>>>>>> for a Vulkan driver compared to the simple solution which is to just
>>>>>> mark it as guilty with what already exists...
>>>>> Well as I said the guilty handling is broken for quite a number of
>>>>> reasons.
>>>>>
>>>>> What we can do rather trivially is changing this code in
>>>>> amdgpu_job_prepare_job():
>>>>>
>>>>>           /* Ignore soft recovered fences here */
>>>>>           r = drm_sched_entity_error(s_entity);
>>>>>           if (r && r != -ENODATA)
>>>>>                   goto error;
>>>>>
>>>>> This will bubble up errors from soft recoveries into the entity as
>>>>> well and makes sure that further submissions are rejected.
>>>> That makes sense to do, but at least for GL_EXT_robustness, that will
>>>> not tell the app that it was guilty.
>>> No, it clearly gets that signaled. We should probably replace the guilty
>>> atomic with a calls to drm_sched_entity_error().
>>>
>>> It's just that this isn't what Marek and I had in mind for this,
>>> basically completely forget about AMDGPU_CTX_OP_QUERY_STATE or
>>> AMDGPU_CTX_OP_QUERY_STATE2.
>>>
>>> Instead just look at the return value of the CS or query fence result 
>>> IOCTL.
>>>
>>> When you get an -ENODATA you have been guilty of causing a soft
>>> recovery, when you get an -ETIME you are guilty of causing a timeout
>>> which had to be hard recovered. When you get an -ECANCELED you are an
>>> innocent victim of a hard recovery somebody else caused.
>>>
>>> What we haven't defined yet is an error code for loosing VRAM, but that
>>> should be trivial to do.
>> So far we have implemented the GPU reset and soft reset, but we
>> haven't done anything to have a robust system recovery. Under the
>> current system, things can easily keep hanging indefinitely because
>> nothing prevents that.
>>
>> The reset status query should stay. Robust apps will use it to tell
>> when they should recreate their context and resources even if they
>> don't submit anything. Let's fully trust robust apps here. In the
>> future we might change our mind about that, but for now, let's just
>> focus on API conformance, and later we can change it as long as we
>> stay API conformant.
>>
>> Non-robust apps must be terminated when they hang or are innocent but
>> affected. Their existence is a security and usability problem and a
>> source of frustrations for users. 100% guaranteed system recovery is
>> impossible if they continue to live.
>>
>> IBs should be rejected for all guilty and affected innocent contexts
>> unconditionally, both robust and non-robust ones, by the kernel.
>> Userspace only forwards the reset status to apps for robust contexts
>> and doesn't do anything else, but userspace may decide to terminate
>> the process if any non-robust context is affected.
> 
> Yeah, that absolutely works for me.
> 
> Going to adjust the implementation accordingly.

Awesome, please CC me know when you have something.

In the short-term I have changed if (r && r != -ENODATA) to if (r) and 
that seems to work nicely for me.

- Joshie 🐸✨

> 
> Christian.
> 
>>
>>
>> Marek
> 

