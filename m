Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCB4C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 15:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C2110E685;
	Wed, 21 Feb 2024 15:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DzJVv83h";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5EB10E685
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 15:15:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so371944f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708528545; x=1709133345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKnZJdmZsuc7Pq8eY4HSG3Q3zdkQX/U+ua875MKuvrU=;
 b=DzJVv83h804H83er7N//X+3GHjIOEbdE9Rmx1smYO1Hcrvzx6CeQrmHJyH9MAFy5rL
 0AECkVbc63X7P2fhuZaPDC43CygmOoGGcOUSiCUCJas9gOa4IRQZWn7TcZjrm8HrCM5C
 tdQb+MXjp9oB+nXW4inlvDkYjvS/1T32M14aGhZelAJlzpBX/2CQjT6a1fHjO3/2d96l
 jihZz2khZ/u4qkOY9+s7TaG+Sv6bjcGw/v5qbnt+ds8zzO6TgFr6k3bpxRabDGGJGtg2
 IyzDNcHHzNDE/r+fnxnorbu4jE9VUlvjilMR86qJXGVxS6POmFMYytcVIh6XT5CNgLhe
 Ipcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708528545; x=1709133345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKnZJdmZsuc7Pq8eY4HSG3Q3zdkQX/U+ua875MKuvrU=;
 b=PUKNDp5o4VJRtuGtjb/+YGnVmY8LppC0ctJqKhAX9Dnn+W6eRuXJyzrND9pG2e6kMZ
 //D58s1vb8IDGcdDzFxdJkAJcnjvlSGMIJoYPAIMvfyCLQgn2+La6Oh07O3OYt5/vX6D
 kM8XXe40M+65rZILZ7nQ0Bol8d3sHZ35uNI6pYn6Q9FDs5uuEkVDwZ3DJgnAD73RcbhO
 ziycPWWHzuhjWDS1r1ssnPGqTCU3l42LRWFpnLgmwf6Qko3PJlizrzLQMuX29pDgL6d/
 HCe0Xz5J38qA3ZuacDYhvjStFozwRwvIJYg0Co4U39W4a3bqWkUc1z+VA2pQAOJ1a7Qb
 ATLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPYMCDTaKtev4cQeEIqEeEwExkltabrcRv/RIHyIXzat80Z0RswntKTHcY3Qd1HkzHcwMARasM1mb/Svl+zmKECqPE6fO0+BdhDTtOgw==
X-Gm-Message-State: AOJu0YxEGF3SBU+8gL2WtunYy0jobX4PfYOLkm+W7MfSvF9CqEnZe3Q+
 B/vgU63QQ5b1sJypGOCPxYlfYikmEnLFJO/W85NRbqgDikq2+zA+
X-Google-Smtp-Source: AGHT+IGxqkK6ET3EYw9sOp2J83BFqjQ3AwVa6kP/2GfY/nu+COxEIjSeiDjG/pcoCFzRJ5RVI1JaiQ==
X-Received: by 2002:a5d:6da2:0:b0:33d:4fca:b7dc with SMTP id
 u2-20020a5d6da2000000b0033d4fcab7dcmr7289485wrs.62.1708528545212; 
 Wed, 21 Feb 2024 07:15:45 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t17-20020adfe111000000b0033d56d43fbesm8822115wrz.115.2024.02.21.07.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:15:44 -0800 (PST)
Message-ID: <2ae0f677-a3b7-4cad-8b37-beb0ae502da8@gmail.com>
Date: Wed, 21 Feb 2024 16:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Alex Deucher <alexdeucher@gmail.com>, Romano <romaniox@gmail.com>
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
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <af6291d4-45c3-4eb6-95b8-14a5221e72a1@leemhuis.info>
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

Am 21.02.24 um 07:06 schrieb Linux regression tracking (Thorsten Leemhuis):
> On 20.02.24 21:18, Alex Deucher wrote:
>> On Tue, Feb 20, 2024 at 2:41 PM Romano <romaniox@gmail.com> wrote:
>>> If the increased low range is allowed via boot option, like in proposed
>>> patch, user clearly made an intentional decision. Undefined, but won't
>>> fry his hardware for sure. Undefined is also overclocking in that
>>> matter. You can go out of range with ratio of voltage vs frequency(still
>>> within vendor's limits) for example and crash the system.
>> This whole thing reminds me of this:
>> https://xkcd.com/1172/
>> The problem is another module parameter is another interface to
>> maintain and validate.
> Yup, of course, all that is understood.
>
> But we have this "no regressions" rule for a reason. Adhering to it
> strictly would afaics be counter-productive in this situation, but give
> users some way to manually do what was possible before out-of-the box
> IMHO is the minimum we should do.
>
> Maybe just allow that parameter only up to a certain recent GPU
> generation, that way you won't have to deal with that at some point in
> the future.
>
>>   Moreover, we've had a number of cases in the
>> past where users have under or overclocked and reported bugs or
>> stability issues and it did not come to light that they were doing
>> that until we'd already spent a good deal of time trying to debug the
>> issue.
> Taint the kernel when that module parameter is used? We iirc have a
> taint bit exactly for this sort of situation. Sure, such reports will
> still happen, but then you at least have an indicator to spot them.

Let me recap what happened here:

1. AMD is the GPU manufacturer, but apart from a few exceptions doesn't 
assemble boards.

2. Vendors take AMDs GPUs and assemble them together with power 
regulators, memory and a bunch of other components into PCIe board.

3. AMD provides a vendor agnostic driver and for this to work vendors 
describe to the min/max voltage their power regulators can do in some 
flash memory.

4. Hardware engineers point out that AMDs open source drivers are not 
respecting the min value.

5. In response a patch was applied to respect that value and not use 
something outside of the hardware specification the vendor provided.

I'm not sure about it but I think AMD need to respect the min/max values 
simply by contract and it's not really an option to not do that.

If someone really want to run your hardware outside the vendor 
recommended values that person can still patch the driver to ignore the 
limits. It's just that then AMD is not responsible for any damage 
resulting from that.

So as far as I can see the request to make that a module option is a 
no-go, especially since hardware engineers have explicitly pointed out 
that we have to do this in the software stack.

Regards,
Christian.

>
> Ciao, Thorsten
>
>>   This obviously can still happen if you allow any sort of over
>> or underclocking, but at least if you stick to the limits you are
>> staying within the bounding box of the design.
>>
>> Alex
>>
>>> On 2/20/24 19:09, Alex Deucher wrote:
>>>> On Tue, Feb 20, 2024 at 11:46 AM Romano <romaniox@gmail.com> wrote:
>>>>> For Windows, apps like MSI Afterburner is the one to try and what most
>>>>> people go for. Using it in the past myself, I would be surprised if it
>>>>> adhered to such a high min power cap. But even if it did, why would we
>>>>> have to.
>>>>>
>>>>> Relying on vendors cap in this case has already proven wrong because
>>>>> things worked for quite some time already and people reported saving
>>>>> significant amount of watts, in my case 90W(!) for <10% perf.
>>>>>
>>>>> Therefore this talk about safety seems rather strange to me and
>>>>> especially so when we are talking about min_cap. Or name me a single
>>>>> case where someone fried his card due to "too low power" set in said
>>>>> variable. Now there was a report, where by going way too low, driver
>>>>> goes opposite into max power. That's it. That can be easily
>>>>> detected(vents going crazy etc.) and reverted. It is a max_cap that
>>>>> protect HW(also above scenario), not a min_cap. Feel free to adhere to
>>>>> safety standards with that one.
>>>> Because operation outside of the design bounding box is undefined.  It
>>>> might work for some boards but not others.  It's possible some of the
>>>> logic in the firmware or some of the components used on the board may
>>>> not work correctly below a certain limit, or the voltage regulators
>>>> used on a specific board have a minimum requirement that would not be
>>>> an issue if you stick the bounding box.
>>>>
>>>> Alex
>>>>
>>>>> As for solution, what some suggested already exist - a patch posted by
>>>>> fililip on gitlab is probably the way most of you would agree. It
>>>>> introduce a variable that can be set during boot to override min_cap.
>>>>> But he did not pull requested it, so please, if any one of you who have
>>>>> access to code and merge kernel would be kind enough to implement it.
>>>>>
>>>>>
>>>>>
>>>>> On 2/20/24 16:46, Alex Deucher wrote:
>>>>>> On Tue, Feb 20, 2024 at 10:42 AM Linux regression tracking (Thorsten
>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>> On 20.02.24 16:27, Hans de Goede wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 2/20/24 16:15, Alex Deucher wrote:
>>>>>>>>> On Tue, Feb 20, 2024 at 10:03 AM Linux regression tracking (Thorsten
>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>> On 20.02.24 15:45, Alex Deucher wrote:
>>>>>>>>>>> On Mon, Feb 19, 2024 at 9:47 AM Linux regression tracking (Thorsten
>>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>>> On 17.02.24 14:30, Greg KH wrote:
>>>>>>>>>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
>>>>>>>>>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
>>>>>>>>>>>>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
>>>>>>>>>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
>>>>>>>>>>>>>> even for root. This is not of above apps issue but of the kernel, I read
>>>>>>>>>>>>>> similar issues from other bug reports of above apps. I downgraded to v6.6.10
>>>>>>>>>>>>>> kernel and my 115W(under power)cap work again as before.
>>>>>>>>>>>> For the record and everyone that lands here: the cause is known now
>>>>>>>>>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
>>>>>>>>>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
>>>>>>>>>>>>
>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>>>>>>>>>
>>>>>>>>>>>> Other mentions:
>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>>>>>>>>>>>>
>>>>>>>>>>>> Haven't seen any statement from the amdgpu developers (now CCed) yet on
>>>>>>>>>>>> this there (but might have missed something!). From what I can see I
>>>>>>>>>>>> assume this will likely be somewhat tricky to handle, as a revert
>>>>>>>>>>>> overall might be a bad idea here. We'll see I guess.
>>>>>>>>>>> The change aligns the driver what has been validated on each board
>>>>>>>>>>> design.  Windows uses the same limits.  Using values lower than the
>>>>>>>>>>> validated range can lead to undefined behavior and could potentially
>>>>>>>>>>> damage your hardware.
>>>>>>>>>> Thx for the reply! Yeah, I was expecting something along those lines.
>>>>>>>>>>
>>>>>>>>>> Nevertheless it afaics still is a regression in the eyes of many users.
>>>>>>>>>> I'm not sure how Linus feels about this, but I wonder if we can find
>>>>>>>>>> some solution here so that users that really want to, can continue to do
>>>>>>>>>> what was possible out-of-the box before. Is that possible to realize or
>>>>>>>>>> even supported already?
>>>>>>>>>>
>>>>>>>>>> And sure, those users would be running their hardware outside of its
>>>>>>>>>> specifications. But is that different from overclocking (which the
>>>>>>>>>> driver allows, doesn't it? If not by all means please correct me!)?
>>>>>>>>> Sure.  The driver has always had upper bound limits for overclocking,
>>>>>>>>> this change adds lower bounds checking for underclocking as well.
>>>>>>>>> When the silicon validation teams set the bounding box for a device,
>>>>>>>>> they set a range of values where it's reasonable to operate based on
>>>>>>>>> the characteristics of the design.
>>>>>>>>>
>>>>>>>>> If we did want to allow extended underclocking, we need a big warning
>>>>>>>>> in the logs at the very least.
>>>>>>>> Requiring a module-option to be set to allow this, as well as a big
>>>>>>>> warning in the logs sounds like a good solution to me.
>>>>>>> Yeah, especially as it sounds from some of the reports as if some
>>>>>>> vendors did a really bad job when it came to setting the proper
>>>>>>> lower-bound limits are now adhered -- and thus higher then what we used
>>>>>>> out-of-the box before 1958946858a62b was applied.
>>>>>>>
>>>>>>> Side note: I assume those "lower bounds checking" is done round about
>>>>>>> the same way by the Windows driver? Does that one allow users to go
>>>>>>> lower somehow? Say after modifying the registry or something like that?
>>>>>>> Or through external tools?
>>>>>> Windows uses the same limit.  I'm not aware of any way to override the
>>>>>> limit on windows off hand.
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>
>>>>>>> Ciao, Thorsten
>>>>>>>
>>>>>>>>>>>> Roman posted something that apparently was meant to go to the list, so
>>>>>>>>>>>> let me put it here:
>>>>>>>>>>>>
>>>>>>>>>>>> """
>>>>>>>>>>>> UPDATE: User fililip already posted patch, but it need to be merged,
>>>>>>>>>>>> discussion is on gitlab link below.
>>>>>>>>>>>>
>>>>>>>>>>>> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> it seems that commit was already found(see user's 'fililip' comment):
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>>>>>>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
>>>>>>>>>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
>>>>>>>>>>>>>
>>>>>>>>>>>>>        drm/amd/pm: Support for getting power1_cap_min value
>>>>>>>>>>>>>
>>>>>>>>>>>>>        Support for getting power1_cap_min value on smu13 and smu11.
>>>>>>>>>>>>>        For other Asics, we still use 0 as the default value.
>>>>>>>>>>>>>
>>>>>>>>>>>>>        Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>>>        Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>>>>>>>>>>>>>        Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> However, this is not good as it remove under-powering range too far. I
>>>>>>>>>>>> was getting only about 7% less performance but 90W(!) less consumption
>>>>>>>>>>>> when set to my 115W before. Also I wonder if we as a OS of options and
>>>>>>>>>>>> freedom have to stick to such very high reference for min values without
>>>>>>>>>>>> ability to override them through some sys ctrls. Commit was done by amd
>>>>>>>>>>>> guy and I wonder if because of maybe this post that I made few months
>>>>>>>>>>>> ago(business strategy?):
>>>>>>>>>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/
>>>>>>>>>>>>> This is not a dangerous OC upwards where I can understand desire to
>>>>>>>>>>>> protect HW, it is downward, having min cap at 190W when card pull on
>>>>>>>>>>>> 115W almost same speed is IMO crazy to deny. We don't talk about default
>>>>>>>>>>>> or reference values here either, just a move to lower the range of
>>>>>>>>>>>> options for whatever reason.
>>>>>>>>>>>>> I don't know how much power you guys have over them, but please
>>>>>>>>>>>> consider either reverting this change, or give us an option to set
>>>>>>>>>>>> min_cap through say /sys (right now param is readonly, even for root).
>>>>>>>>>>>>> Thank you in advance for looking into this, with regards:  Romano
>>>>>>>>>>>> """
>>>>>>>>>>>>
>>>>>>>>>>>> And while at it, let me add this issue to the tracking as well
>>>>>>>>>>>>
>>>>>>>>>>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>>>>>>>>>>>> regressions; the text you find below is based on a few templates
>>>>>>>>>>>> paragraphs you might have encountered already in similar form.
>>>>>>>>>>>> See link in footer if these mails annoy you.]
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>>>>>>>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>>>>>>>>>> tracking bot:
>>>>>>>>>>>>
>>>>>>>>>>>> #regzbot introduced 1958946858a62b /
>>>>>>>>>>>> #regzbot title drm: amdgpu: under-powering broke
>>>>>>>>>>>>
>>>>>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>>>>>>> --
>>>>>>>>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>>>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>>>>>>>>> That page also explains what to do if mails like this annoy you.
>>

