Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1D1C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 07:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C2D10E3E3;
	Tue, 16 Jan 2024 07:48:07 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F4210E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 07:48:05 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-40e857ce7beso1534385e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705391224; x=1705996024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AMxh5xor5eTj60ZRN87ikpXLZsHHk4NQlHWUnEcY2qc=;
 b=EIDzzpgibGxRV8ecjcLs2ISiSZjFijGiw99OfDLFzTEBA2gw62G05hDvZI3fB0Qg0I
 TStrmOKHq6AmIPoF1iOwvCIXB9vK/pMlon25fG7auI1jhH5oTlnL3n5KDWbBsruvylOq
 3yuJhYBok9X5dIdyAOGfElXgeIOeqvesyZjUk3XR06Pj0jptZcGsavcpxA7zZLowE51S
 ReLK+Nu34VU3pNWawQqhOvmKT0aU0Vbyl1Ns3mvOgVQoXCRQqA3eaZBuzrQ27D2BEA6N
 b0abBWRMh4jeuLCBhaRRzrCApYL/1m77aJzpUvrLxRhwqa2fPJtsrHdmG6Ekvw13lmcU
 Mfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705391224; x=1705996024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMxh5xor5eTj60ZRN87ikpXLZsHHk4NQlHWUnEcY2qc=;
 b=FzuY3s8Ax85iTE1Td9O1VL87AKnjOdS4REX2K67Jv20faCoioMSVhzlOQuyNBEa/mf
 CBJ54uvLR0+BXs3OCXoUoRoz1ixpR/6yRM0eB3WFvfXD1BipfZoGF78cnbIgfUy4irIC
 No047A9TOb/7F0Kgrzx1jKSQo73sZUjs+/ruxiPLHGS2CvSy1dCyhhZ8YiCrux5r48Rz
 c6n1SOm7qVTSeF6zv/J2I9jQjuHmfN2KK/yt5VSODh9M8Uuz/WfYWLE5AdscdTqndCjw
 5YqNyYzGvsahIW0sjk7v90DBVAMB80BPBxgH7B8a2uNJyF7c98M2zKUaJdE1kd6ahouI
 ijLQ==
X-Gm-Message-State: AOJu0YycCaM6RcNPzc5ouJ170+PguuRiVehdzG+i6iS20zj31Lkbkacr
 PBOqpvR+QzBF4AQ/e0Q468A=
X-Google-Smtp-Source: AGHT+IGRamwc4vRzU0jlveFtNcWv7l8pkN6lwQHWE/arcZ4xBO+JePRMyWwclP4W3qNMsaI62TOOHA==
X-Received: by 2002:a05:600c:3585:b0:40e:4556:5870 with SMTP id
 p5-20020a05600c358500b0040e45565870mr3823161wmq.120.1705391224039; 
 Mon, 15 Jan 2024 23:47:04 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c1c9400b0040e54f15d3dsm22101322wms.31.2024.01.15.23.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 23:47:03 -0800 (PST)
Message-ID: <de47a17b-3d19-4c74-b77a-e08b0e94cc69@gmail.com>
Date: Tue, 16 Jan 2024 08:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
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
 <baa54077-cf89-4fb7-b505-a41716e66a23@gmail.com>
 <CAAxE2A5v_RkZ9ex4=7jiBSKVb22_1FAj0AANBcmKtETt5c3gVA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A5v_RkZ9ex4=7jiBSKVb22_1FAj0AANBcmKtETt5c3gVA@mail.gmail.com>
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.01.24 um 01:05 schrieb Marek Olšák:
> On Mon, Jan 15, 2024 at 3:06 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 15.01.24 um 20:30 schrieb Joshua Ashton:
>>> On 1/15/24 19:19, Christian König wrote:
>>>> Am 15.01.24 um 20:13 schrieb Joshua Ashton:
>>>>> On 1/15/24 18:53, Christian König wrote:
>>>>>> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
>>>>>>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>>>>>>>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock
>>>>>>>> <friedrich.vock@gmx.de <mailto:friedrich.vock@gmx.de>> wrote:
>>>>>>>>
>>>>>>>>      Re-sending as plaintext, sorry about that
>>>>>>>>
>>>>>>>>      On 15.01.24 18:54, Michel Dänzer wrote:
>>>>>>>>       > On 2024-01-15 18:26, Friedrich Vock wrote:
>>>>>>>>       >> [snip]
>>>>>>>>       >> The fundamental problem here is that not telling
>>>>>>>> applications that
>>>>>>>>       >> something went wrong when you just canceled their work
>>>>>>>> midway is an
>>>>>>>>       >> out-of-spec hack.
>>>>>>>>       >> When there is a report of real-world apps breaking
>>>>>>>> because of
>>>>>>>>      that hack,
>>>>>>>>       >> reports of different apps working (even if it's
>>>>>>>> convenient that they
>>>>>>>>       >> work) doesn't justify keeping the broken code.
>>>>>>>>       > If the breaking apps hit multiple soft resets in a row,
>>>>>>>> I've laid
>>>>>>>>      out a pragmatic solution which covers both cases.
>>>>>>>>      Hitting soft reset every time is the lucky path. Once GPU
>>>>>>>> work is
>>>>>>>>      interrupted out of nowhere, all bets are off and it might as
>>>>>>>> well
>>>>>>>>      trigger a full system hang next time. No hang recovery should
>>>>>>>> be able to
>>>>>>>>      cause that under any circumstance.
>>>>>>>>
>>>>>>>>
>>>>>>>> I think the more insidious situation is no further hangs but
>>>>>>>> wrong results because we skipped some work. That we skipped work
>>>>>>>> may e.g. result in some texture not being uploaded or some GPGPU
>>>>>>>> work not being done and causing further errors downstream (say if
>>>>>>>> a game is doing AI/physics on the GPU not to say anything of
>>>>>>>> actual GPGPU work one might be doing like AI)
>>>>>>> Even worse if this is compute on eg. OpenCL for something
>>>>>>> science/math/whatever related, or training a model.
>>>>>>>
>>>>>>> You could randomly just get invalid/wrong results without even
>>>>>>> knowing!
>>>>>> Well on the kernel side we do provide an API to query the result of
>>>>>> a submission. That includes canceling submissions with a soft
>>>>>> recovery.
>>>>>>
>>>>>> What we just doesn't do is to prevent further submissions from this
>>>>>> application. E.g. enforcing that the application is punished for
>>>>>> bad behavior.
>>>>> You do prevent future submissions for regular resets though: Those
>>>>> increase karma which sets ctx->guilty, and if ctx->guilty then
>>>>> -ECANCELED is returned for a submission.
>>>>>
>>>>> ctx->guilty is never true for soft recovery though, as it doesn't
>>>>> increase karma, which is the problem this patch is trying to solve.
>>>>>
>>>>> By the submission result query API, I you assume you mean checking
>>>>> the submission fence error somehow? That doesn't seem very ergonomic
>>>>> for a Vulkan driver compared to the simple solution which is to just
>>>>> mark it as guilty with what already exists...
>>>> Well as I said the guilty handling is broken for quite a number of
>>>> reasons.
>>>>
>>>> What we can do rather trivially is changing this code in
>>>> amdgpu_job_prepare_job():
>>>>
>>>>           /* Ignore soft recovered fences here */
>>>>           r = drm_sched_entity_error(s_entity);
>>>>           if (r && r != -ENODATA)
>>>>                   goto error;
>>>>
>>>> This will bubble up errors from soft recoveries into the entity as
>>>> well and makes sure that further submissions are rejected.
>>> That makes sense to do, but at least for GL_EXT_robustness, that will
>>> not tell the app that it was guilty.
>> No, it clearly gets that signaled. We should probably replace the guilty
>> atomic with a calls to drm_sched_entity_error().
>>
>> It's just that this isn't what Marek and I had in mind for this,
>> basically completely forget about AMDGPU_CTX_OP_QUERY_STATE or
>> AMDGPU_CTX_OP_QUERY_STATE2.
>>
>> Instead just look at the return value of the CS or query fence result IOCTL.
>>
>> When you get an -ENODATA you have been guilty of causing a soft
>> recovery, when you get an -ETIME you are guilty of causing a timeout
>> which had to be hard recovered. When you get an -ECANCELED you are an
>> innocent victim of a hard recovery somebody else caused.
>>
>> What we haven't defined yet is an error code for loosing VRAM, but that
>> should be trivial to do.
> So far we have implemented the GPU reset and soft reset, but we
> haven't done anything to have a robust system recovery. Under the
> current system, things can easily keep hanging indefinitely because
> nothing prevents that.
>
> The reset status query should stay. Robust apps will use it to tell
> when they should recreate their context and resources even if they
> don't submit anything. Let's fully trust robust apps here. In the
> future we might change our mind about that, but for now, let's just
> focus on API conformance, and later we can change it as long as we
> stay API conformant.
>
> Non-robust apps must be terminated when they hang or are innocent but
> affected. Their existence is a security and usability problem and a
> source of frustrations for users. 100% guaranteed system recovery is
> impossible if they continue to live.
>
> IBs should be rejected for all guilty and affected innocent contexts
> unconditionally, both robust and non-robust ones, by the kernel.
> Userspace only forwards the reset status to apps for robust contexts
> and doesn't do anything else, but userspace may decide to terminate
> the process if any non-robust context is affected.

Yeah, that absolutely works for me.

Going to adjust the implementation accordingly.

Christian.

>
>
> Marek

