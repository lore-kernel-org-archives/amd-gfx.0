Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3956DC27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 09:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F71D10E6E8;
	Wed,  5 Jun 2024 09:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HkXIBpSu";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9924E10E6E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 09:06:09 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2eacd7e7b38so1001671fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717578367; x=1718183167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YuIWau1TFsfuLLtLolGjBcopMHps6Xq4Wup9yHFf0B8=;
 b=HkXIBpSu45oIEwhUPxImTAJJltzz8rCepSfQa6VcuhL/0HefGFAHWZu98XlKe1kFAm
 SKoV4SpHKWG88gOf2QY3+omVIv+7BrYAx2SH769Yrx8yY7EXNxbW+04v5yBPukUOgxxS
 hfasc8kvUdWaHxeWbNur65eTOnZf+5T/ImBrj5u1CWfrGkNaETrdRWUvl3Id86EtRvhg
 BFB8awzUbtPgqPoWiutl/3Q6T93oiTEGHtCRfnx2+8LdTq8UVf9GEJ2E+1XGxAwGr8F0
 an1MgsPz7ntOmKGMfwZ4KMAjTKGssKBLQmpbjA83z0OoPOiIwMKRl6dZlAE4ZOT4qsZ5
 1Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717578367; x=1718183167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YuIWau1TFsfuLLtLolGjBcopMHps6Xq4Wup9yHFf0B8=;
 b=Cgxlabhpdl9mv1l+G3+usAsQH7OZvOQJv4JVADRhBgNi3+ZeQWKoIh8uCz8tn3j+l7
 J13gavczkvg3c0PpccOjSNduxrOTog3v0IsnFDPUI1LDjkuEA78u2JI7DznwGSFMfQH6
 MsoEWiVjRNBf9bNh1LNUtSU9LZiyaU6ykwImZy1rJ89Q6YI/9AW9gL/cYjVipRMJUYsd
 7Kk7jkDIMKje4uB2labdmF0lFWYcMDw8Mf1CJ1603yR5elmcljxQTmAwi1d0nYIF9aMB
 6yv8cPXANyHyCi1fD5sB80MmEv6kvMp7nFGfAK7FPPS68XVe4Kz/HGgw5oUNM1ZOMOlm
 dEWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+5axeeWn/SjMGoQDgLwHpE8FljPCmgjl7M1K+6/dBRaBRlUxamqpU43EP8HGDK3bv2/g6F9662gT0VQzFXtvRqKpr/iimJLd1EUk57w==
X-Gm-Message-State: AOJu0YxVl5hTiT1bSnI4gZCb6HQP080SeZEjyXeBIMsscsDzCvpVGc5h
 mgtrkvrj3A5C4n1ELlBp5fyjdyTZ1GQ2Cj/VMMiKt0U9zSRZOvEc
X-Google-Smtp-Source: AGHT+IFzPCXQUulmrBJCAOrI2oWQDuLUDgzdSS6hxEx4CCZKaBGFc2go7pWXEwu/S9qUsFJz9mwZAA==
X-Received: by 2002:a2e:94d6:0:b0:2e9:8b00:73f0 with SMTP id
 38308e7fff4ca-2eac7a0f8f7mr11886171fa.28.1717578366958; 
 Wed, 05 Jun 2024 02:06:06 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158149008sm12991605e9.29.2024.06.05.02.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 02:06:06 -0700 (PDT)
Message-ID: <b491e52f-c034-457d-9286-3da1e2ad9e27@gmail.com>
Date: Wed, 5 Jun 2024 11:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use GFP_ATOMIC for bounding box
To: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: George Zhang <george.zhang@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20240604135015.479910-1-alexander.deucher@amd.com>
 <9830fdd9-c738-4b9f-9ecb-2ed83a855243@gmail.com>
 <3d7c938b-208c-4a73-8287-bc9ff598c47b@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3d7c938b-208c-4a73-8287-bc9ff598c47b@app.fastmail.com>
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

Am 04.06.24 um 16:57 schrieb Arnd Bergmann:
> On Tue, Jun 4, 2024, at 16:22, Christian König wrote:
>> Am 04.06.24 um 15:50 schrieb Alex Deucher:
>>> This can be called in atomic context.  Should fix:
>>>
>>> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
>>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
>>> preempt_count: 2, expected: 0
>>> RCU nest depth: 0, expected: 0
>>> Preemption disabled at:
>>> ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
>>> CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
>>> Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
>>> Workqueue: events_unbound async_run_entry_fn
>> That most likely only papers over the real problem and is not a valid fix.
>>
>> The question is why is that an atomic context?  If the function is used
>> under a spinlock then this might indeed be the right fix.
>>
>> If it's because of floating point operation then that here won't work
>> either.
> It looks like there is only one caller, and this turns on
> floating point instructions just for the call:
>
>          if (dc->res_pool->funcs->update_bw_bounding_box) {
>                  DC_FP_START();
>                  dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
>                  DC_FP_END();
>          }
>
> but then they are enabled again inside of the function.
>
> If we can drop the outer DC_FP_START(), that means
> the GFP_KERNEL allocation works. On the other hand if
> we actually have to enabled it before calling into
> the function (e.g. because there is an architecture that
> has incompatible function calling conventions when FP
> is enabled), the inner one is redundant, but we can
> potentially move the kmemdup() into the caller and
> pass the copy by refernence.

Yeah exactly that's the case.

The DC_FP_START() and DC_FP_END() calls need to be outside of the 
function  because the compiler has no idea that it can't move any 
flouting point instructions outside of the critical section between the 
two functions.

So yes the calls to DC_FP_START() and DC_FP_END() from within floating 
point enabled code should be forbidden somehow.

And when that is done the caller should allocate any parameters needed 
and pass them by reference to avoid the GFP_ATOMIC.

Regards,
Christian.

>
>        Arnd

