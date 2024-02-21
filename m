Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06340C48BF8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 08:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7224D10E86E;
	Thu, 22 Feb 2024 08:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKNUrwLl";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35EA610E02B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 17:45:41 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso8851872a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708537539; x=1709142339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V3L8kGeK/sc4dOyinBmU2Nba8CtDTeBUIU0r1CO0I7o=;
 b=EKNUrwLlQF2C7lC1rajtzpXuG3qykidRioVrmxfP6aiUSmgsl6g71sDzWY1/uIQ9Hn
 AtNV0EZQ7L8f7N5f6qr7Jc2L1jPz+XCE2VXQotAPshzFoPdhIEthJ/Cb5BKCeYqw4Prs
 TrqE60tuHZ2lMND7wKG8lon6YGkE2gfqx/BPjiU7RL0U5Q8IjpXsYcbmkv1Z3rMUeT6/
 4DnSIfXiMwvoBiJMIj66D9QFF+4iXm6y/pZdHzwooOlRfe3QI4jCfiwdYAIiUIuoTDPx
 ALR7t5XirHfbC869pXtYXbC5frxcH2WFK9i0ea8PDlgR9rrSxaCRqThbDjMQca+W9SmC
 IRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708537539; x=1709142339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V3L8kGeK/sc4dOyinBmU2Nba8CtDTeBUIU0r1CO0I7o=;
 b=auzpYDec7k0wWhb9gFlz7otzvrrLmuUjy/3HApUB18S1q58Zm4viP4nX1sho35VqvU
 FKJOPNX5gkZtB5j+TkNNPZnof/QiwIUbH2oJ7AbRGkDW4t9QngcuF7teSbN5haidxdvO
 aBu9+ErYdjW6vKDi0KJFh8PDZ8qxv3Umqwc06ieRz4lKgH+FSflzrM43FZfb1ftDMGd7
 YIBn3sZ1dtGVQxlGXLYphsunFCxf2qeyibGh9FPu75K9nnFhMdVywJErEsNtKAcL35Da
 rZJykmkS4VgMOl7G5wtYXrNyapNlGkod69W8o+/ZagDS6+ePXdwYN3vU6um1xyq8AlpA
 BFJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1EfpFUvSZix1x+yj6Rn5Gl95BW/S4bk0NNAK294OkvoyWasMP0c++sUi5b4ce0A3X0skl9VzudJvGKfJBrQGaLSdxlbjC2HT+Y5jK1w==
X-Gm-Message-State: AOJu0YxZcWrBBMe2vB+mA0fOrO2r9hmY1/Tl/etDga69BqJC7/XW9zQc
 y9ox57k6uHw7LWLswn+3XkgkzYPG2c3fp2ezK24dsCO6//fBRZ6C
X-Google-Smtp-Source: AGHT+IFkuKvDCwRViD3uR1/CfkHucUTQd52K2rHY9MkVxk/fDf9w2sJhim9aN85sNdVu8p82A7Qs/Q==
X-Received: by 2002:aa7:dd0c:0:b0:564:aa84:caad with SMTP id
 i12-20020aa7dd0c000000b00564aa84caadmr5459331edv.0.1708537538916; 
 Wed, 21 Feb 2024 09:45:38 -0800 (PST)
Received: from [10.0.2.1] (server.riadoklan.sk.eu.org. [195.3.170.77])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a05640208cb00b00564df589590sm1208553edz.37.2024.02.21.09.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:45:38 -0800 (PST)
Message-ID: <a35ee59e-5454-4e7d-aad2-2bbee6c26e89@gmail.com>
Date: Wed, 21 Feb 2024 18:45:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Alex Deucher <alexdeucher@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
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
 <af6291d4-45c3-4eb6-95b8-14a5221e72a1@leemhuis.info>
 <CADnq5_Md1yQVxfxWBju7xrqZcU18KqfaJRGcE3tumCUy_3tHoA@mail.gmail.com>
Content-Language: en-US
From: Romano <romaniox@gmail.com>
In-Reply-To: <CADnq5_Md1yQVxfxWBju7xrqZcU18KqfaJRGcE3tumCUy_3tHoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 08:21:54 +0000
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

He is my proposal:

On boot, read chip values into min_cap, default_cap, max_cap and set 
them, satisfying AMD's requirement.

Do not introduce any new boot flags, keeping things simple.

Keep def_cap and max_cap readonly to protect HW.

Make min_cap readwrite: "echo 1234 > /sys/...min_cap".

No limitation to specific HW, just general.

This way you did your job fulfilling AMD's request. If user change min, 
it was his intention anyway - HW is safe with this option. You won't see 
any false bug reports because this does not introduce instability, 
unlike OC.

As a side note, it seems Windows does not allow lower than vendors min 
as well, even via Afterburner. This may seem like "you see, they too 
follow specs", but I see it more positive for Linux. We already have a 
mesa which is on par, if not better than Nvidia driver. It is generally 
known that AMD is great on Linux. Now if on top of that Windows users 
find that not only can they get better, limitless drivers, but also 
significant - out of charts efficiency and power savings, this make 
Linux only more attractive to Windows users and make an adoption faster.



On 2/21/24 16:39, Alex Deucher wrote:
> On Wed, Feb 21, 2024 at 1:06 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> On 20.02.24 21:18, Alex Deucher wrote:
>>> On Tue, Feb 20, 2024 at 2:41 PM Romano <romaniox@gmail.com> wrote:
>>>> If the increased low range is allowed via boot option, like in proposed
>>>> patch, user clearly made an intentional decision. Undefined, but won't
>>>> fry his hardware for sure. Undefined is also overclocking in that
>>>> matter. You can go out of range with ratio of voltage vs frequency(still
>>>> within vendor's limits) for example and crash the system.
>>> This whole thing reminds me of this:
>>> https://xkcd.com/1172/
>>> The problem is another module parameter is another interface to
>>> maintain and validate.
>> Yup, of course, all that is understood.
>>
>> But we have this "no regressions" rule for a reason. Adhering to it
>> strictly would afaics be counter-productive in this situation, but give
>> users some way to manually do what was possible before out-of-the box
>> IMHO is the minimum we should do.
>>
>> Maybe just allow that parameter only up to a certain recent GPU
>> generation, that way you won't have to deal with that at some point in
>> the future.
> The problem is the cumulative effect of all of these parameters.
> Every time there is some change in the driver someone disagrees with
> there is a push to add a module parameter for it.  The driver already
> has too many module parameters and it's hard to keep them all working
> consistently and in every possible combination.  Moreover, the module
> options are supposed to be mainly for debugging.  The driver sets
> proper defaults for all chips to ensure proper operation, however lots
> of random forums seem to treat them like they are the recipe for some
> special sauce so users are constantly setting various combinations of
> them because they read somewhere on a forum that it would make their
> GPU run faster.  More often than not this leads to problems.
>
> Even if we did make the option only valid for these specific chips,
> there will be an expectation that future chips will support it as
> well, because someone will hack the driver and test it and it may work
> for them and then there will be a push to add it for those chips too.
>
> Alex
>
>>>   Moreover, we've had a number of cases in the
>>> past where users have under or overclocked and reported bugs or
>>> stability issues and it did not come to light that they were doing
>>> that until we'd already spent a good deal of time trying to debug the
>>> issue.
>> Taint the kernel when that module parameter is used? We iirc have a
>> taint bit exactly for this sort of situation. Sure, such reports will
>> still happen, but then you at least have an indicator to spot them.
>>
>> Ciao, Thorsten
>>
>>>   This obviously can still happen if you allow any sort of over
>>> or underclocking, but at least if you stick to the limits you are
>>> staying within the bounding box of the design.
>>>
>>> Alex
>>>
>>>> On 2/20/24 19:09, Alex Deucher wrote:
>>>>> On Tue, Feb 20, 2024 at 11:46 AM Romano <romaniox@gmail.com> wrote:
>>>>>> For Windows, apps like MSI Afterburner is the one to try and what most
>>>>>> people go for. Using it in the past myself, I would be surprised if it
>>>>>> adhered to such a high min power cap. But even if it did, why would we
>>>>>> have to.
>>>>>>
>>>>>> Relying on vendors cap in this case has already proven wrong because
>>>>>> things worked for quite some time already and people reported saving
>>>>>> significant amount of watts, in my case 90W(!) for <10% perf.
>>>>>>
>>>>>> Therefore this talk about safety seems rather strange to me and
>>>>>> especially so when we are talking about min_cap. Or name me a single
>>>>>> case where someone fried his card due to "too low power" set in said
>>>>>> variable. Now there was a report, where by going way too low, driver
>>>>>> goes opposite into max power. That's it. That can be easily
>>>>>> detected(vents going crazy etc.) and reverted. It is a max_cap that
>>>>>> protect HW(also above scenario), not a min_cap. Feel free to adhere to
>>>>>> safety standards with that one.
>>>>> Because operation outside of the design bounding box is undefined.  It
>>>>> might work for some boards but not others.  It's possible some of the
>>>>> logic in the firmware or some of the components used on the board may
>>>>> not work correctly below a certain limit, or the voltage regulators
>>>>> used on a specific board have a minimum requirement that would not be
>>>>> an issue if you stick the bounding box.
>>>>>
>>>>> Alex
>>>>>
>>>>>> As for solution, what some suggested already exist - a patch posted by
>>>>>> fililip on gitlab is probably the way most of you would agree. It
>>>>>> introduce a variable that can be set during boot to override min_cap.
>>>>>> But he did not pull requested it, so please, if any one of you who have
>>>>>> access to code and merge kernel would be kind enough to implement it.
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/20/24 16:46, Alex Deucher wrote:
>>>>>>> On Tue, Feb 20, 2024 at 10:42 AM Linux regression tracking (Thorsten
>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>> On 20.02.24 16:27, Hans de Goede wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 2/20/24 16:15, Alex Deucher wrote:
>>>>>>>>>> On Tue, Feb 20, 2024 at 10:03 AM Linux regression tracking (Thorsten
>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>> On 20.02.24 15:45, Alex Deucher wrote:
>>>>>>>>>>>> On Mon, Feb 19, 2024 at 9:47 AM Linux regression tracking (Thorsten
>>>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>>>> On 17.02.24 14:30, Greg KH wrote:
>>>>>>>>>>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
>>>>>>>>>>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
>>>>>>>>>>>>>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
>>>>>>>>>>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
>>>>>>>>>>>>>>> even for root. This is not of above apps issue but of the kernel, I read
>>>>>>>>>>>>>>> similar issues from other bug reports of above apps. I downgraded to v6.6.10
>>>>>>>>>>>>>>> kernel and my 115W(under power)cap work again as before.
>>>>>>>>>>>>> For the record and everyone that lands here: the cause is known now
>>>>>>>>>>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
>>>>>>>>>>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>>>>>>>>>>
>>>>>>>>>>>>> Other mentions:
>>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
>>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>>>>>>>>>>>>>
>>>>>>>>>>>>> Haven't seen any statement from the amdgpu developers (now CCed) yet on
>>>>>>>>>>>>> this there (but might have missed something!). From what I can see I
>>>>>>>>>>>>> assume this will likely be somewhat tricky to handle, as a revert
>>>>>>>>>>>>> overall might be a bad idea here. We'll see I guess.
>>>>>>>>>>>> The change aligns the driver what has been validated on each board
>>>>>>>>>>>> design.  Windows uses the same limits.  Using values lower than the
>>>>>>>>>>>> validated range can lead to undefined behavior and could potentially
>>>>>>>>>>>> damage your hardware.
>>>>>>>>>>> Thx for the reply! Yeah, I was expecting something along those lines.
>>>>>>>>>>>
>>>>>>>>>>> Nevertheless it afaics still is a regression in the eyes of many users.
>>>>>>>>>>> I'm not sure how Linus feels about this, but I wonder if we can find
>>>>>>>>>>> some solution here so that users that really want to, can continue to do
>>>>>>>>>>> what was possible out-of-the box before. Is that possible to realize or
>>>>>>>>>>> even supported already?
>>>>>>>>>>>
>>>>>>>>>>> And sure, those users would be running their hardware outside of its
>>>>>>>>>>> specifications. But is that different from overclocking (which the
>>>>>>>>>>> driver allows, doesn't it? If not by all means please correct me!)?
>>>>>>>>>> Sure.  The driver has always had upper bound limits for overclocking,
>>>>>>>>>> this change adds lower bounds checking for underclocking as well.
>>>>>>>>>> When the silicon validation teams set the bounding box for a device,
>>>>>>>>>> they set a range of values where it's reasonable to operate based on
>>>>>>>>>> the characteristics of the design.
>>>>>>>>>>
>>>>>>>>>> If we did want to allow extended underclocking, we need a big warning
>>>>>>>>>> in the logs at the very least.
>>>>>>>>> Requiring a module-option to be set to allow this, as well as a big
>>>>>>>>> warning in the logs sounds like a good solution to me.
>>>>>>>> Yeah, especially as it sounds from some of the reports as if some
>>>>>>>> vendors did a really bad job when it came to setting the proper
>>>>>>>> lower-bound limits are now adhered -- and thus higher then what we used
>>>>>>>> out-of-the box before 1958946858a62b was applied.
>>>>>>>>
>>>>>>>> Side note: I assume those "lower bounds checking" is done round about
>>>>>>>> the same way by the Windows driver? Does that one allow users to go
>>>>>>>> lower somehow? Say after modifying the registry or something like that?
>>>>>>>> Or through external tools?
>>>>>>> Windows uses the same limit.  I'm not aware of any way to override the
>>>>>>> limit on windows off hand.
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>
>>>>>>>> Ciao, Thorsten
>>>>>>>>
>>>>>>>>>>>>> Roman posted something that apparently was meant to go to the list, so
>>>>>>>>>>>>> let me put it here:
>>>>>>>>>>>>>
>>>>>>>>>>>>> """
>>>>>>>>>>>>> UPDATE: User fililip already posted patch, but it need to be merged,
>>>>>>>>>>>>> discussion is on gitlab link below.
>>>>>>>>>>>>>
>>>>>>>>>>>>> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> it seems that commit was already found(see user's 'fililip' comment):
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>>>>>>>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
>>>>>>>>>>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>        drm/amd/pm: Support for getting power1_cap_min value
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>        Support for getting power1_cap_min value on smu13 and smu11.
>>>>>>>>>>>>>>        For other Asics, we still use 0 as the default value.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>        Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>>>>        Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>>>>>>>>>>>>>>        Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However, this is not good as it remove under-powering range too far. I
>>>>>>>>>>>>> was getting only about 7% less performance but 90W(!) less consumption
>>>>>>>>>>>>> when set to my 115W before. Also I wonder if we as a OS of options and
>>>>>>>>>>>>> freedom have to stick to such very high reference for min values without
>>>>>>>>>>>>> ability to override them through some sys ctrls. Commit was done by amd
>>>>>>>>>>>>> guy and I wonder if because of maybe this post that I made few months
>>>>>>>>>>>>> ago(business strategy?):
>>>>>>>>>>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/
>>>>>>>>>>>>>> This is not a dangerous OC upwards where I can understand desire to
>>>>>>>>>>>>> protect HW, it is downward, having min cap at 190W when card pull on
>>>>>>>>>>>>> 115W almost same speed is IMO crazy to deny. We don't talk about default
>>>>>>>>>>>>> or reference values here either, just a move to lower the range of
>>>>>>>>>>>>> options for whatever reason.
>>>>>>>>>>>>>> I don't know how much power you guys have over them, but please
>>>>>>>>>>>>> consider either reverting this change, or give us an option to set
>>>>>>>>>>>>> min_cap through say /sys (right now param is readonly, even for root).
>>>>>>>>>>>>>> Thank you in advance for looking into this, with regards:  Romano
>>>>>>>>>>>>> """
>>>>>>>>>>>>>
>>>>>>>>>>>>> And while at it, let me add this issue to the tracking as well
>>>>>>>>>>>>>
>>>>>>>>>>>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>>>>>>>>>>>>> regressions; the text you find below is based on a few templates
>>>>>>>>>>>>> paragraphs you might have encountered already in similar form.
>>>>>>>>>>>>> See link in footer if these mails annoy you.]
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>>>>>>>>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>>>>>>>>>>> tracking bot:
>>>>>>>>>>>>>
>>>>>>>>>>>>> #regzbot introduced 1958946858a62b /
>>>>>>>>>>>>> #regzbot title drm: amdgpu: under-powering broke
>>>>>>>>>>>>>
>>>>>>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>>>>>>>> --
>>>>>>>>>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>>>>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>>>>>>>>>> That page also explains what to do if mails like this annoy you.
>>>
