Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DE5C5478A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 08:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B25A10E669;
	Wed, 21 Feb 2024 08:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VjQm/Xq0";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B20E10E4CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 21:30:57 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-33d509c5706so1580145f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 13:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708464656; x=1709069456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2e8Ca3XMMtWEk/SuzxxUVYBpBm/SMXEBNM1qnmPkVa0=;
 b=VjQm/Xq0anXOYoddDwL3mjd35USM5Bef7mtMklQxLatOMIeqE4cmsFrA5CuSR2X72q
 dukMTz9mQ1M1VVio/ZM9gIUs+ztzrg7LeEKFc//f0diVIwKnDCOVTmfbKYBD+cguiwEh
 Tez8DJvp+xCZoBKWHwAAa+Kmn8wCmZAXcefRYsdSuyrYiuDQv+C/BZEMtuUl47poqfRa
 INqAgklLVwAHSW17BtYjgIapBYV+HIrV44kKPIFF1MiBM+RYa0JAVVmZD2mOTqnUYEZZ
 Hu0WQ8H8IEZZvO0Euk340dF6HfUJpQ1JmR7GtA6EYc1byfVSzwf+HJwzEiqjTl8Tg2Y0
 DLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708464656; x=1709069456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2e8Ca3XMMtWEk/SuzxxUVYBpBm/SMXEBNM1qnmPkVa0=;
 b=T4EyqcQkCsfShjp9YbqypJ72luIvyR9D1mKCDfRvug39uv6H3T/rDiSC7aqm0DxMkh
 UnPHPYvCnEMBWlNDjcNuxxfsq256FhN6tMyKh81yJ7+CuzbxglS/YJHJKl0cOnKsbc3U
 HRCKCwXTcSxx1ffdN1sogAGL0XFxDVAfacH9yd0uA48cJjq2K9HWtNoJFC6JQEoyC+uY
 L61raj5YYCRC9GhIF8Q4BdMwvBkeAh0Jj54MYQ9QZuzozCXlS/y3W0lO3LyVv7MzFBbM
 4BIG32FzOGToQXB6Y8exzNL/KwLi/1RbkSY4udsAzeRxbnywE88H90GEuyhCpkQGcqQd
 ijXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkkN66grbZC/1nBYCOJFe6lsApS8J3Qt8/PtzYMdZ7s/Wha6vsWeVMQvLUfQM8fvFssp476RbyOsNe3wm2fgn6kILsUfr8HggqYtfyFQ==
X-Gm-Message-State: AOJu0YxjibRYvo3hE5BrWcLhS8yPkKF22aRRt9gpRfDSO60rf/AQ886e
 Mwn1gSz2B0wt7PndoEtJbtva2t5mV63xAUUBfBc5+n6n/eMZpDzf
X-Google-Smtp-Source: AGHT+IGJfcO5veRZilkrg25JpXjm+WrghRCTZbOVYu/efBiREcrwr6k2zwxxQGvGcbeAa9r5dkgYsw==
X-Received: by 2002:adf:ffc5:0:b0:33d:3f21:c38b with SMTP id
 x5-20020adfffc5000000b0033d3f21c38bmr4769329wrs.25.1708464655422; 
 Tue, 20 Feb 2024 13:30:55 -0800 (PST)
Received: from [10.0.2.1] (server.riadoklan.sk.eu.org. [195.3.170.77])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a056000000700b0033ce214a97csm14626342wrx.17.2024.02.20.13.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 13:30:54 -0800 (PST)
Message-ID: <c0226a21-75d9-461b-a200-de6a616076e8@gmail.com>
Date: Tue, 20 Feb 2024 22:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Hans de Goede <hdegoede@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
 <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
 <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
 <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
 <4bc8747a-d87f-423b-b0ce-8891e78ae094@redhat.com>
 <a6243c3b-d773-4693-88e9-033995616f12@leemhuis.info>
 <CADnq5_MHmz=HdGA22U-bk2b+4un70bmLzpbDyc3+tjzoRAnCeA@mail.gmail.com>
 <1aa3830d-ceb7-4eb1-b5bb-d6043684507f@gmail.com>
 <CADnq5_Nc+eEfXwaXfaTz75C9ww6ETVm_adCSfGsdD6OzguUQ6Q@mail.gmail.com>
 <3e077b5f-0684-4a07-9b74-ab242bb01975@gmail.com>
 <CADnq5_NszWGKVZZomTojAm_u7O-04M6x_ox4KXQC79OuGA9ARA@mail.gmail.com>
Content-Language: en-US
From: Romano <romaniox@gmail.com>
In-Reply-To: <CADnq5_NszWGKVZZomTojAm_u7O-04M6x_ox4KXQC79OuGA9ARA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

This setting does not introduce stability problems or bugs. 
Voltage/frequency ratio is dynamic relative to power cap, GPU auto 
adjust to it. This is not like lowering voltage alone. By lowering GPU 
power, it simply auto-adjust its frequency and voltage on the fly and 
remain stable without crashes. If you lower power way too far, GPU flip 
to maximum power usage on its own, as reported. So both lower than 
vendors are not as undefined as it seems and safety checks are done 
outside vendors range as well.

As for maintenance, patch is literally single "if" switch and a boot 
option.

Idea that you spare yourself extra trouble from reports by not 
implementing this is also false. If this patch is not implemented, I can 
say with confidence that people will end up patching their kernels(I 
know I would) due to how much power can this option save. It is way too 
important. You will still end up with reports, only this time without 
even be aware of the patch because it will be unofficial, "in-house" 
made. And probably forget this thing even existed later on. You also 
introduce extra work to the users, it will not be simple "pacman -Syu" 
anymore, but hassle of whole kernel setup, patching and recompilation on 
the user's side.



On 2/20/24 21:18, Alex Deucher wrote:
> On Tue, Feb 20, 2024 at 2:41 PM Romano <romaniox@gmail.com> wrote:
>> If the increased low range is allowed via boot option, like in proposed
>> patch, user clearly made an intentional decision. Undefined, but won't
>> fry his hardware for sure. Undefined is also overclocking in that
>> matter. You can go out of range with ratio of voltage vs frequency(still
>> within vendor's limits) for example and crash the system.
> This whole thing reminds me of this:
> https://xkcd.com/1172/
> The problem is another module parameter is another interface to
> maintain and validate.  Moreover, we've had a number of cases in the
> past where users have under or overclocked and reported bugs or
> stability issues and it did not come to light that they were doing
> that until we'd already spent a good deal of time trying to debug the
> issue.  This obviously can still happen if you allow any sort of over
> or underclocking, but at least if you stick to the limits you are
> staying within the bounding box of the design.
>
> Alex
>
>>
>>
>> On 2/20/24 19:09, Alex Deucher wrote:
>>> On Tue, Feb 20, 2024 at 11:46 AM Romano <romaniox@gmail.com> wrote:
>>>> For Windows, apps like MSI Afterburner is the one to try and what most
>>>> people go for. Using it in the past myself, I would be surprised if it
>>>> adhered to such a high min power cap. But even if it did, why would we
>>>> have to.
>>>>
>>>> Relying on vendors cap in this case has already proven wrong because
>>>> things worked for quite some time already and people reported saving
>>>> significant amount of watts, in my case 90W(!) for <10% perf.
>>>>
>>>> Therefore this talk about safety seems rather strange to me and
>>>> especially so when we are talking about min_cap. Or name me a single
>>>> case where someone fried his card due to "too low power" set in said
>>>> variable. Now there was a report, where by going way too low, driver
>>>> goes opposite into max power. That's it. That can be easily
>>>> detected(vents going crazy etc.) and reverted. It is a max_cap that
>>>> protect HW(also above scenario), not a min_cap. Feel free to adhere to
>>>> safety standards with that one.
>>> Because operation outside of the design bounding box is undefined.  It
>>> might work for some boards but not others.  It's possible some of the
>>> logic in the firmware or some of the components used on the board may
>>> not work correctly below a certain limit, or the voltage regulators
>>> used on a specific board have a minimum requirement that would not be
>>> an issue if you stick the bounding box.
>>>
>>> Alex
>>>
>>>> As for solution, what some suggested already exist - a patch posted by
>>>> fililip on gitlab is probably the way most of you would agree. It
>>>> introduce a variable that can be set during boot to override min_cap.
>>>> But he did not pull requested it, so please, if any one of you who have
>>>> access to code and merge kernel would be kind enough to implement it.
>>>>
>>>>
>>>>
>>>> On 2/20/24 16:46, Alex Deucher wrote:
>>>>> On Tue, Feb 20, 2024 at 10:42 AM Linux regression tracking (Thorsten
>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>> On 20.02.24 16:27, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 2/20/24 16:15, Alex Deucher wrote:
>>>>>>>> On Tue, Feb 20, 2024 at 10:03 AM Linux regression tracking (Thorsten
>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>> On 20.02.24 15:45, Alex Deucher wrote:
>>>>>>>>>> On Mon, Feb 19, 2024 at 9:47 AM Linux regression tracking (Thorsten
>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>> On 17.02.24 14:30, Greg KH wrote:
>>>>>>>>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
>>>>>>>>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
>>>>>>>>>>>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
>>>>>>>>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
>>>>>>>>>>>>> even for root. This is not of above apps issue but of the kernel, I read
>>>>>>>>>>>>> similar issues from other bug reports of above apps. I downgraded to v6.6.10
>>>>>>>>>>>>> kernel and my 115W(under power)cap work again as before.
>>>>>>>>>>> For the record and everyone that lands here: the cause is known now
>>>>>>>>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
>>>>>>>>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
>>>>>>>>>>>
>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>>>>>>>>
>>>>>>>>>>> Other mentions:
>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>>>>>>>>>>>
>>>>>>>>>>> Haven't seen any statement from the amdgpu developers (now CCed) yet on
>>>>>>>>>>> this there (but might have missed something!). From what I can see I
>>>>>>>>>>> assume this will likely be somewhat tricky to handle, as a revert
>>>>>>>>>>> overall might be a bad idea here. We'll see I guess.
>>>>>>>>>> The change aligns the driver what has been validated on each board
>>>>>>>>>> design.  Windows uses the same limits.  Using values lower than the
>>>>>>>>>> validated range can lead to undefined behavior and could potentially
>>>>>>>>>> damage your hardware.
>>>>>>>>> Thx for the reply! Yeah, I was expecting something along those lines.
>>>>>>>>>
>>>>>>>>> Nevertheless it afaics still is a regression in the eyes of many users.
>>>>>>>>> I'm not sure how Linus feels about this, but I wonder if we can find
>>>>>>>>> some solution here so that users that really want to, can continue to do
>>>>>>>>> what was possible out-of-the box before. Is that possible to realize or
>>>>>>>>> even supported already?
>>>>>>>>>
>>>>>>>>> And sure, those users would be running their hardware outside of its
>>>>>>>>> specifications. But is that different from overclocking (which the
>>>>>>>>> driver allows, doesn't it? If not by all means please correct me!)?
>>>>>>>> Sure.  The driver has always had upper bound limits for overclocking,
>>>>>>>> this change adds lower bounds checking for underclocking as well.
>>>>>>>> When the silicon validation teams set the bounding box for a device,
>>>>>>>> they set a range of values where it's reasonable to operate based on
>>>>>>>> the characteristics of the design.
>>>>>>>>
>>>>>>>> If we did want to allow extended underclocking, we need a big warning
>>>>>>>> in the logs at the very least.
>>>>>>> Requiring a module-option to be set to allow this, as well as a big
>>>>>>> warning in the logs sounds like a good solution to me.
>>>>>> Yeah, especially as it sounds from some of the reports as if some
>>>>>> vendors did a really bad job when it came to setting the proper
>>>>>> lower-bound limits are now adhered -- and thus higher then what we used
>>>>>> out-of-the box before 1958946858a62b was applied.
>>>>>>
>>>>>> Side note: I assume those "lower bounds checking" is done round about
>>>>>> the same way by the Windows driver? Does that one allow users to go
>>>>>> lower somehow? Say after modifying the registry or something like that?
>>>>>> Or through external tools?
>>>>> Windows uses the same limit.  I'm not aware of any way to override the
>>>>> limit on windows off hand.
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>> Ciao, Thorsten
>>>>>>
>>>>>>>>>>> Roman posted something that apparently was meant to go to the list, so
>>>>>>>>>>> let me put it here:
>>>>>>>>>>>
>>>>>>>>>>> """
>>>>>>>>>>> UPDATE: User fililip already posted patch, but it need to be merged,
>>>>>>>>>>> discussion is on gitlab link below.
>>>>>>>>>>>
>>>>>>>>>>> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> it seems that commit was already found(see user's 'fililip' comment):
>>>>>>>>>>>>
>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>>>>>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
>>>>>>>>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
>>>>>>>>>>>>
>>>>>>>>>>>>        drm/amd/pm: Support for getting power1_cap_min value
>>>>>>>>>>>>
>>>>>>>>>>>>        Support for getting power1_cap_min value on smu13 and smu11.
>>>>>>>>>>>>        For other Asics, we still use 0 as the default value.
>>>>>>>>>>>>
>>>>>>>>>>>>        Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>>        Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>>>>>>>>>>>>        Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>
>>>>>>>>>>>> However, this is not good as it remove under-powering range too far. I
>>>>>>>>>>> was getting only about 7% less performance but 90W(!) less consumption
>>>>>>>>>>> when set to my 115W before. Also I wonder if we as a OS of options and
>>>>>>>>>>> freedom have to stick to such very high reference for min values without
>>>>>>>>>>> ability to override them through some sys ctrls. Commit was done by amd
>>>>>>>>>>> guy and I wonder if because of maybe this post that I made few months
>>>>>>>>>>> ago(business strategy?):
>>>>>>>>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/
>>>>>>>>>>>> This is not a dangerous OC upwards where I can understand desire to
>>>>>>>>>>> protect HW, it is downward, having min cap at 190W when card pull on
>>>>>>>>>>> 115W almost same speed is IMO crazy to deny. We don't talk about default
>>>>>>>>>>> or reference values here either, just a move to lower the range of
>>>>>>>>>>> options for whatever reason.
>>>>>>>>>>>> I don't know how much power you guys have over them, but please
>>>>>>>>>>> consider either reverting this change, or give us an option to set
>>>>>>>>>>> min_cap through say /sys (right now param is readonly, even for root).
>>>>>>>>>>>> Thank you in advance for looking into this, with regards:  Romano
>>>>>>>>>>> """
>>>>>>>>>>>
>>>>>>>>>>> And while at it, let me add this issue to the tracking as well
>>>>>>>>>>>
>>>>>>>>>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>>>>>>>>>>> regressions; the text you find below is based on a few templates
>>>>>>>>>>> paragraphs you might have encountered already in similar form.
>>>>>>>>>>> See link in footer if these mails annoy you.]
>>>>>>>>>>>
>>>>>>>>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>>>>>>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>>>>>>>>> tracking bot:
>>>>>>>>>>>
>>>>>>>>>>> #regzbot introduced 1958946858a62b /
>>>>>>>>>>> #regzbot title drm: amdgpu: under-powering broke
>>>>>>>>>>>
>>>>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>>>>>> --
>>>>>>>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>>>>>>>> That page also explains what to do if mails like this annoy you.
