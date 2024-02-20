Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4442C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 08:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DED710E319;
	Wed, 21 Feb 2024 08:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="izFDobbW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D950E10E4BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708442831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHZfEehJ30oQDz8+S3jdQFoPQv8+btekLaY6PoGCP/M=;
 b=izFDobbWbxjv0W66vTZWanp0jJvRJjFrYe4DRAMvWK/g7YG2NwXcvvJ2JcyegQFtQTM/Bs
 /tFcZzC86OIZJR71tRnE32BzmWkuyP/cSGKJCfvZSuzTKGDLSm2wjnBKTkhXvgUsVA0kAV
 yRr7uJJcnAehnDI/5z3UncWohe9hoaU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-X9vQrx0rNeeAezOojbBNAw-1; Tue, 20 Feb 2024 10:27:10 -0500
X-MC-Unique: X9vQrx0rNeeAezOojbBNAw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso400893466b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 07:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708442829; x=1709047629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EHZfEehJ30oQDz8+S3jdQFoPQv8+btekLaY6PoGCP/M=;
 b=BxL2Oe5BDTboG8yKD9iDlTFfLDt5awllq8VKT7LCLzmhUC4i9iEY6Q2yd5xIV8Lww2
 +aT/0tLprY/BLy4U81jKKxloRuDMELRp25f8WnRBWOMvJnp/QGfjlSCHW3lttWVKv3cW
 Tq1SJIUVzkkGCYi2FMDJsCwdgR/9l1u3oH3pMnZcrrwVAkJzrw+KP108gCIAjjF1qdk1
 LlWBn1dPs02CTtsJqw41SC2RsEBBM2E2fADioFGFlEEzZPNsNsjhAKqlCVcLpWEihcuM
 Q+7KEJDrIzRzIM1zrAMSg/t6xY4cQeDrot10N965Eh5KWVPOJfppJaZ4XwhMsAXKndKe
 MCzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXQQT/7yz11daPa6uzrFF0dXQDBa73mdapb+A60/ynRmKK3U1Q3J3JIvkO5GJBUbX8FkN1bGWZff6rPVejuqT2QCg7OEkWKM3h6DidEw==
X-Gm-Message-State: AOJu0YxLqTm+ZAti/3wRid3PETnBmyoNnek21RwArdcROn0h2VOLm24A
 +Zfw1Cw95Ykggl6m9rfQ6+jNmkoRzXCI7DzBtWi4uHfVhabwjPnL5jBGMVJs3HlidO1dzdZJGmU
 tkyg0NRMVMZYBQLHvuEqoMGDt0zJLAlBQyzr77Z8ASSjVPj5nLMGhhNXsz/uUt/E=
X-Received: by 2002:a17:906:371a:b0:a3f:d50:2f81 with SMTP id
 d26-20020a170906371a00b00a3f0d502f81mr1250581ejc.15.1708442829098; 
 Tue, 20 Feb 2024 07:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxHJg4IHLApX94QhcFlCjvnTjdQtWaCi56R2/Zf6yt0BkxydCQja5u2fqYbR1jPT5BW5wx+A==
X-Received: by 2002:a17:906:371a:b0:a3f:d50:2f81 with SMTP id
 d26-20020a170906371a00b00a3f0d502f81mr1250555ejc.15.1708442828692; 
 Tue, 20 Feb 2024 07:27:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 tx12-20020a1709078e8c00b00a3e4673e7dbsm3227736ejc.38.2024.02.20.07.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 07:27:08 -0800 (PST)
Message-ID: <4bc8747a-d87f-423b-b0ce-8891e78ae094@redhat.com>
Date: Tue, 20 Feb 2024 16:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Alex Deucher <alexdeucher@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>, Roman Benes <benes@riadoklan.sk.eu.org>
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
 <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
 <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
 <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Feb 2024 08:14:29 +0000
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

Hi,

On 2/20/24 16:15, Alex Deucher wrote:
> On Tue, Feb 20, 2024 at 10:03 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 20.02.24 15:45, Alex Deucher wrote:
>>> On Mon, Feb 19, 2024 at 9:47 AM Linux regression tracking (Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>
>>>> On 17.02.24 14:30, Greg KH wrote:
>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
>>>>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
>>>>>> even for root. This is not of above apps issue but of the kernel, I read
>>>>>> similar issues from other bug reports of above apps. I downgraded to v6.6.10
>>>>>> kernel and my 115W(under power)cap work again as before.
>>>>>
>>>> For the record and everyone that lands here: the cause is known now
>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
>>>>
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>
>>>> Other mentions:
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>>>>
>>>> Haven't seen any statement from the amdgpu developers (now CCed) yet on
>>>> this there (but might have missed something!). From what I can see I
>>>> assume this will likely be somewhat tricky to handle, as a revert
>>>> overall might be a bad idea here. We'll see I guess.
>>>
>>> The change aligns the driver what has been validated on each board
>>> design.  Windows uses the same limits.  Using values lower than the
>>> validated range can lead to undefined behavior and could potentially
>>> damage your hardware.
>>
>> Thx for the reply! Yeah, I was expecting something along those lines.
>>
>> Nevertheless it afaics still is a regression in the eyes of many users.
>> I'm not sure how Linus feels about this, but I wonder if we can find
>> some solution here so that users that really want to, can continue to do
>> what was possible out-of-the box before. Is that possible to realize or
>> even supported already?
>>
>> And sure, those users would be running their hardware outside of its
>> specifications. But is that different from overclocking (which the
>> driver allows, doesn't it? If not by all means please correct me!)?
> 
> Sure.  The driver has always had upper bound limits for overclocking,
> this change adds lower bounds checking for underclocking as well.
> When the silicon validation teams set the bounding box for a device,
> they set a range of values where it's reasonable to operate based on
> the characteristics of the design.
> 
> If we did want to allow extended underclocking, we need a big warning
> in the logs at the very least.

Requiring a module-option to be set to allow this, as well as a big
warning in the logs sounds like a good solution to me.

Regards,

Hans





>>>> Roman posted something that apparently was meant to go to the list, so
>>>> let me put it here:
>>>>
>>>> """
>>>> UPDATE: User fililip already posted patch, but it need to be merged,
>>>> discussion is on gitlab link below.
>>>>
>>>> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>>>>
>>>>
>>>>> it seems that commit was already found(see user's 'fililip' comment):
>>>>>
>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
>>>>>
>>>>>     drm/amd/pm: Support for getting power1_cap_min value
>>>>>
>>>>>     Support for getting power1_cap_min value on smu13 and smu11.
>>>>>     For other Asics, we still use 0 as the default value.
>>>>>
>>>>>     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>     Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>>>>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>> However, this is not good as it remove under-powering range too far. I
>>>> was getting only about 7% less performance but 90W(!) less consumption
>>>> when set to my 115W before. Also I wonder if we as a OS of options and
>>>> freedom have to stick to such very high reference for min values without
>>>> ability to override them through some sys ctrls. Commit was done by amd
>>>> guy and I wonder if because of maybe this post that I made few months
>>>> ago(business strategy?):
>>>>>
>>>>>
>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/
>>>>>
>>>>> This is not a dangerous OC upwards where I can understand desire to
>>>> protect HW, it is downward, having min cap at 190W when card pull on
>>>> 115W almost same speed is IMO crazy to deny. We don't talk about default
>>>> or reference values here either, just a move to lower the range of
>>>> options for whatever reason.
>>>>>
>>>>> I don't know how much power you guys have over them, but please
>>>> consider either reverting this change, or give us an option to set
>>>> min_cap through say /sys (right now param is readonly, even for root).
>>>>>
>>>>>
>>>>> Thank you in advance for looking into this, with regards:  Romano
>>>> """
>>>>
>>>> And while at it, let me add this issue to the tracking as well
>>>>
>>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>>>> regressions; the text you find below is based on a few templates
>>>> paragraphs you might have encountered already in similar form.
>>>> See link in footer if these mails annoy you.]
>>>>
>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>> tracking bot:
>>>>
>>>> #regzbot introduced 1958946858a62b /
>>>> #regzbot title drm: amdgpu: under-powering broke
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> That page also explains what to do if mails like this annoy you.
>>>
>>>
> 

