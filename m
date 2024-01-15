Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDFEC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 19:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6847810E385;
	Mon, 15 Jan 2024 19:13:15 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3153C10E385
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 19:13:14 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e78238db9so12082835e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705345992; x=1705950792; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AT42IZM1mCc00W22sVAda77bN1md4nTSKQv+ZPhZkr0=;
 b=N05t3XJ827bF1ejmkH2YVb18FDzSWxyvWZxz/9tb5FZyEwiAEbpJE4olUwS74vgvWi
 qv+ZVMbNswLgqsj1L7CCqBxu0CRhXNRMo4ZWLHJ7YdGQjBzSJAC+Rrn3kHKCiuVXmQXd
 7u4167CnDmaub7frjIGKoiG2IUIyVIKhZO/+mEcGh+WSQ640OC44barma3FYhFakA9Ev
 o2h8rBx++U1Cvtty3VvlLqFgZFMbx6OCmZ/qT0HsuHNBDXJyFY5cEjo7mkwdNaihesto
 1mXsJNYrvL3mMvVnl68Ah5d8eXnWPn/wZvkHHNbWI25bQ9qFDVCRUq+slUz861uz+wwA
 Rr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705345992; x=1705950792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AT42IZM1mCc00W22sVAda77bN1md4nTSKQv+ZPhZkr0=;
 b=JLWs96d0txszNlN4csEeK1Vu/cfI9oJxYtln5Gu0P5ePv9639W8ae37ZLewqbQpnBi
 bbreV2+XV8oPj1nCY+KefPDLDTdfbMW753HAveM6OsSW2+2z3AMnzCAmvuTQnVRCXrFU
 znSt5eFT4M5dPA7PsdtiDsvfSDy3saPV6fYMN9/80vQ6MSbBAeFM1jiZvuyi541cnZbS
 cznSZzwvJF0iZj5Dw+6YihRjwbiaLly2FKOOjegCVm6oGtafZnAfVZPBQgM5f26WxfpY
 MuE2HiIn40JF8X4tcariCxEqBkaR+SmaAUOT/MhBCEvGzISFpRqckzTCK+YxjoUWB+SA
 1UmQ==
X-Gm-Message-State: AOJu0Yyb/q0nyf5ZiR9+Na2tzHmN54NbCaCDleNNf6qmsFFpB1zJtvnW
 /1ATTKClClBIjY0PUTLlIGhldlnQTe1S3w==
X-Google-Smtp-Source: AGHT+IGkHsFx4W4+Pd9CZtRz5Gxj0jZrsPHubXSX2kWATVrJog9fZFILy2I3zm4bBTfjIytUWn5Q6g==
X-Received: by 2002:a05:600c:6a0b:b0:40d:2921:2a55 with SMTP id
 jj11-20020a05600c6a0b00b0040d29212a55mr3397212wmb.21.1705345992453; 
 Mon, 15 Jan 2024 11:13:12 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a05600c45c400b0040e6ff60057sm8116243wmo.48.2024.01.15.11.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 11:13:12 -0800 (PST)
Message-ID: <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
Date: Mon, 15 Jan 2024 19:13:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
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
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
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



On 1/15/24 18:53, Christian König wrote:
> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock <friedrich.vock@gmx.de 
>>> <mailto:friedrich.vock@gmx.de>> wrote:
>>>
>>>     Re-sending as plaintext, sorry about that
>>>
>>>     On 15.01.24 18:54, Michel Dänzer wrote:
>>>      > On 2024-01-15 18:26, Friedrich Vock wrote:
>>>      >> [snip]
>>>      >> The fundamental problem here is that not telling applications 
>>> that
>>>      >> something went wrong when you just canceled their work midway 
>>> is an
>>>      >> out-of-spec hack.
>>>      >> When there is a report of real-world apps breaking because of
>>>     that hack,
>>>      >> reports of different apps working (even if it's convenient 
>>> that they
>>>      >> work) doesn't justify keeping the broken code.
>>>      > If the breaking apps hit multiple soft resets in a row, I've laid
>>>     out a pragmatic solution which covers both cases.
>>>     Hitting soft reset every time is the lucky path. Once GPU work is
>>>     interrupted out of nowhere, all bets are off and it might as well
>>>     trigger a full system hang next time. No hang recovery should be 
>>> able to
>>>     cause that under any circumstance.
>>>
>>>
>>> I think the more insidious situation is no further hangs but wrong 
>>> results because we skipped some work. That we skipped work may e.g. 
>>> result in some texture not being uploaded or some GPGPU work not 
>>> being done and causing further errors downstream (say if a game is 
>>> doing AI/physics on the GPU not to say anything of actual GPGPU work 
>>> one might be doing like AI)
>>
>> Even worse if this is compute on eg. OpenCL for something 
>> science/math/whatever related, or training a model.
>>
>> You could randomly just get invalid/wrong results without even knowing!
> 
> Well on the kernel side we do provide an API to query the result of a 
> submission. That includes canceling submissions with a soft recovery.
> 
> What we just doesn't do is to prevent further submissions from this 
> application. E.g. enforcing that the application is punished for bad 
> behavior.

You do prevent future submissions for regular resets though: Those 
increase karma which sets ctx->guilty, and if ctx->guilty then 
-ECANCELED is returned for a submission.

ctx->guilty is never true for soft recovery though, as it doesn't 
increase karma, which is the problem this patch is trying to solve.

By the submission result query API, I you assume you mean checking the 
submission fence error somehow? That doesn't seem very ergonomic for a 
Vulkan driver compared to the simple solution which is to just mark it 
as guilty with what already exists...

- Joshie 🐸✨

> 
>>
>> Now imagine this is VulkanSC displaying something in the car 
>> dashboard, or some medical device doing some compute work to show 
>> something on a graph...
>>
>> I am not saying you should be doing any of that with RADV + AMDGPU, 
>> but it's just food for thought... :-)
>>
>> As I have been saying, you simply cannot just violate API contracts 
>> like this, it's flatout wrong.
> 
> Yeah, completely agree to that.
> 
> Regards,
> Christian.
> 
>>
>> - Joshie 🐸✨
>>
>>>
>>>      >
>>>      >
>>>      >> If mutter needs to be robust against faults it caused itself, it
>>>     should be robust
>>>      >> against GPU resets.
>>>      > It's unlikely that the hangs I've seen were caused by mutter
>>>     itself, more likely Mesa or amdgpu.
>>>      >
>>>      > Anyway, this will happen at some point, the reality is it hasn't
>>>     yet though.
>>>      >
>>>      >
>>>
> 

- Joshie 🐸✨
