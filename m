Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14407C48BEB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 08:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F63910E890;
	Thu, 22 Feb 2024 08:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="d52HFznt";
	dkim-atps=neutral
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C789710E7BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 In-Reply-To:References; bh=zerlWzqf0KdoX2Ab28Nli7jDCmCfiw1EjBDqQwfhsz4=;
 t=1708530807; x=1708962807; b=d52HFzntr+iQoUn2+iR4eW5Nc9JZhNkFSlNiZ7ZqJB98hzJ
 2sVneDDd4LYHqH7L/Xd8a6EJ2ejf+gt9MX0/aVumEsuP2WfWvqdwUDkfjbkR+fThC5arxGoBRROOV
 Tt1IHaatvmJcOnJHUIpEiHOSbUCWkSjl01/NXwHBnrb6fLvACdQ5JyIgf17jjQU+tJZURlnmRA9qB
 G1uwJxGFRMAdkYb0PfWxSNBLoMlpOhT11GX2egg+k5PFj6Fdico4ZH/jzzsU+lKSFBemjM97W+X/n
 8/NqB0fsLpc5HmdXxX0RMaJ993xj1x72gBfk3lFkARYgMo/K/ryUCM0iUr7HuzmQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1rcouT-0001FX-BX; Wed, 21 Feb 2024 16:53:25 +0100
Message-ID: <521c02b9-d7c6-4c0f-8259-4b66cc6f9e84@leemhuis.info>
Date: Wed, 21 Feb 2024 16:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
Content-Language: en-US, de-DE
To: Alex Deucher <alexdeucher@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Romano <romaniox@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CADnq5_Md1yQVxfxWBju7xrqZcU18KqfaJRGcE3tumCUy_3tHoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1708530807;
 a09c4913; 
X-HE-SMSGID: 1rcouT-0001FX-BX
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 21.02.24 16:39, Alex Deucher wrote:
> On Wed, Feb 21, 2024 at 1:06 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 20.02.24 21:18, Alex Deucher wrote:
>>> On Tue, Feb 20, 2024 at 2:41 PM Romano <romaniox@gmail.com> wrote:
>>>>
>>>> If the increased low range is allowed via boot option, like in proposed
>>>> patch, user clearly made an intentional decision. Undefined, but won't
>>>> fry his hardware for sure. Undefined is also overclocking in that
>>>> matter. You can go out of range with ratio of voltage vs frequency(still
>>>> within vendor's limits) for example and crash the system.
>>>
>>> This whole thing reminds me of this:
>>> https://xkcd.com/1172/
>>> The problem is another module parameter is another interface to
>>> maintain and validate.
>>
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
> 
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

I know, I fully understand this. Sorry for being a PITA. I'm just
arguing for a parameter because I think that's what I should do in this
situation due to the regression aspect and our #1 rule.

Ciao, Thorsten

>>>  Moreover, we've had a number of cases in the
>>> past where users have under or overclocked and reported bugs or
>>> stability issues and it did not come to light that they were doing
>>> that until we'd already spent a good deal of time trying to debug the
>>> issue.
>>
>> Taint the kernel when that module parameter is used? We iirc have a
>> taint bit exactly for this sort of situation. Sure, such reports will
>> still happen, but then you at least have an indicator to spot them.
>>
>> Ciao, Thorsten
>>
>>>  This obviously can still happen if you allow any sort of over
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
>>>>>>>>
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
>>>>>>>>>>>>>>       drm/amd/pm: Support for getting power1_cap_min value
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>       Support for getting power1_cap_min value on smu13 and smu11.
>>>>>>>>>>>>>>       For other Asics, we still use 0 as the default value.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>       Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>>>>>>>>>>       Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>>>>>>>>>>>>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
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
>>>>>>>>>
>>>
>>>
> 
> 
