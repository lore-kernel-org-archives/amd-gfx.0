Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F95C5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 15:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF8A10E470;
	Tue, 20 Feb 2024 15:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+fguCbD";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E8310E470
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 15:15:12 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-299e0271294so496051a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708442112; x=1709046912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gce0zDR5Y7zHMVedjBVzVrwCS5HvZS7sVWr8Z6KnA8=;
 b=O+fguCbDksITk9j68UeJUIWlifnqYIrO4/wvPk3APTviuYdG6neNiykUBQSx47o/3O
 sLfuuQGZX4jo02fg3anklnGzIsxxjvhW82x1/iSb603DU9QfcoTJGdN1UAgjWzLvpEzE
 7uQo9p7Cw2oUQhW/FV0x3sE+Dxt1aH2hChrRD4PZ3zqjHj66J2Cnq4PinEYPte9McTU1
 lfLtQ5LdbsAEM62/eEuk87AR0lu8MYjaaKSrz9lHOZoOsJ+ertn/fCNB3xXrlSaV580K
 UXEfwdFYcd69L5+llmQ91e14bWgH/2LPK8ZdOSFuvsC43mX4v4edbvHj9L+u9VVuX1ri
 M8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708442112; x=1709046912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gce0zDR5Y7zHMVedjBVzVrwCS5HvZS7sVWr8Z6KnA8=;
 b=f1YnX7IuFO9zQjA+ehF7E9G7uW/8eQZDlT6dN/UNi2Gt0gLYoyGE7UgBx+pBCb/+H5
 6cbsG9yEjVxftZyuxm+MphTt8Mvbn97wfZqfYrmyn9mH/1XQAwx4REvPG6sfBBD0wOt2
 HwDymljfBIQtehvrARmRW7K5PNEHCiXFVKM2JooX8cyYVMdzYplfg7Nuf15J0/tMFlPN
 MO9unQuDgRGykDByR4XNj1WWlm4+9UYvwoU/q9LHRy344MCCCis9CBjWnik4zWDfqbMG
 78gfVFZ8M/BkaWFf46LvgZXRczPHBD39+jVIBvKaSX9wSE5iF7Kc/Krs4BTMGznLazIO
 eAhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ12RsUb+uZjjlNsroWLkFEBV7+zQbg+TMxSR2OwhaY3my1XCwKv4qMP9qf2wtjV3Nk8NoeYiQNM5+waTAFZa2U0wp+pN6n5Er3ENVEw==
X-Gm-Message-State: AOJu0YwFF+XncBM4f8LBdFeDN2Gqhtm4kevTKDHEnMNyN08TJNLBCiMz
 hKdv2EQUdbUZMYSBSrZex+/pK72P8l73C5rm6iituyeKhcFj6BHaUKLGE0H0ST3OPHAJx+pHGxI
 9/8kM81Lkd36m35U+yI0zfv972r4=
X-Google-Smtp-Source: AGHT+IGUa5eanlV2HVlvfGdfww6nGeKChBa7Yij8tbDir3iMt8GBO1mvj5T87de1T+TYmKBx3YrWg8Xwhzs2Gxstr/s=
X-Received: by 2002:a17:90b:f12:b0:299:5a55:ef3a with SMTP id
 br18-20020a17090b0f1200b002995a55ef3amr5550757pjb.4.1708442111924; Tue, 20
 Feb 2024 07:15:11 -0800 (PST)
MIME-Version: 1.0
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
 <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
 <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
In-Reply-To: <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Feb 2024 10:15:00 -0500
Message-ID: <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Greg KH <gregkh@linuxfoundation.org>, 
 Roman Benes <benes@riadoklan.sk.eu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 20.02.24 15:45, Alex Deucher wrote:
> > On Mon, Feb 19, 2024 at 9:47=E2=80=AFAM Linux regression tracking (Thor=
sten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> On 17.02.24 14:30, Greg KH wrote:
> >>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
> >>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6=
700XT,
> >>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W=
),
> >>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable r=
ead-only
> >>>> even for root. This is not of above apps issue but of the kernel, I =
read
> >>>> similar issues from other bug reports of above apps. I downgraded to=
 v6.6.10
> >>>> kernel and my 115W(under power)cap work again as before.
> >>>
> >> For the record and everyone that lands here: the cause is known now
> >> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
> >> value") [v6.7-rc1]) and the issue afaics tracked here:
> >>
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> >>
> >> Other mentions:
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
> >>
> >> Haven't seen any statement from the amdgpu developers (now CCed) yet o=
n
> >> this there (but might have missed something!). From what I can see I
> >> assume this will likely be somewhat tricky to handle, as a revert
> >> overall might be a bad idea here. We'll see I guess.
> >
> > The change aligns the driver what has been validated on each board
> > design.  Windows uses the same limits.  Using values lower than the
> > validated range can lead to undefined behavior and could potentially
> > damage your hardware.
>
> Thx for the reply! Yeah, I was expecting something along those lines.
>
> Nevertheless it afaics still is a regression in the eyes of many users.
> I'm not sure how Linus feels about this, but I wonder if we can find
> some solution here so that users that really want to, can continue to do
> what was possible out-of-the box before. Is that possible to realize or
> even supported already?
>
> And sure, those users would be running their hardware outside of its
> specifications. But is that different from overclocking (which the
> driver allows, doesn't it? If not by all means please correct me!)?

Sure.  The driver has always had upper bound limits for overclocking,
this change adds lower bounds checking for underclocking as well.
When the silicon validation teams set the bounding box for a device,
they set a range of values where it's reasonable to operate based on
the characteristics of the design.

If we did want to allow extended underclocking, we need a big warning
in the logs at the very least.

Alex

>
> Ciao, Thorsten
>
> >> Roman posted something that apparently was meant to go to the list, so
> >> let me put it here:
> >>
> >> """
> >> UPDATE: User fililip already posted patch, but it need to be merged,
> >> discussion is on gitlab link below.
> >>
> >> (PS: I hope I am replying correctly to "all" now? - using original add=
r.)
> >>
> >>
> >>> it seems that commit was already found(see user's 'fililip' comment):
> >>>
> >>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> >>> commit 1958946858a62b6b5392ed075aa219d199bcae39
> >>> Author: Ma Jun <Jun.Ma2@amd.com>
> >>> Date:   Thu Oct 12 09:33:45 2023 +0800
> >>>
> >>>     drm/amd/pm: Support for getting power1_cap_min value
> >>>
> >>>     Support for getting power1_cap_min value on smu13 and smu11.
> >>>     For other Asics, we still use 0 as the default value.
> >>>
> >>>     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >>>     Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> >>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>
> >>> However, this is not good as it remove under-powering range too far. =
I
> >> was getting only about 7% less performance but 90W(!) less consumption
> >> when set to my 115W before. Also I wonder if we as a OS of options and
> >> freedom have to stick to such very high reference for min values witho=
ut
> >> ability to override them through some sys ctrls. Commit was done by am=
d
> >> guy and I wonder if because of maybe this post that I made few months
> >> ago(business strategy?):
> >>>
> >>>
> >> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_c=
apped_115w_at_only_10/
> >>>
> >>> This is not a dangerous OC upwards where I can understand desire to
> >> protect HW, it is downward, having min cap at 190W when card pull on
> >> 115W almost same speed is IMO crazy to deny. We don't talk about defau=
lt
> >> or reference values here either, just a move to lower the range of
> >> options for whatever reason.
> >>>
> >>> I don't know how much power you guys have over them, but please
> >> consider either reverting this change, or give us an option to set
> >> min_cap through say /sys (right now param is readonly, even for root).
> >>>
> >>>
> >>> Thank you in advance for looking into this, with regards:  Romano
> >> """
> >>
> >> And while at it, let me add this issue to the tracking as well
> >>
> >> [TLDR: I'm adding this report to the list of tracked Linux kernel
> >> regressions; the text you find below is based on a few templates
> >> paragraphs you might have encountered already in similar form.
> >> See link in footer if these mails annoy you.]
> >>
> >> Thanks for the report. To be sure the issue doesn't fall through the
> >> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regressio=
n
> >> tracking bot:
> >>
> >> #regzbot introduced 1958946858a62b /
> >> #regzbot title drm: amdgpu: under-powering broke
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >> --
> >> Everything you wanna know about Linux kernel regression tracking:
> >> https://linux-regtracking.leemhuis.info/about/#tldr
> >> That page also explains what to do if mails like this annoy you.
> >
> >
