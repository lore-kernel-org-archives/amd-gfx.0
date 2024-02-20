Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CC8C48BC3
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 18:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CFF10E2AE;
	Tue, 20 Feb 2024 18:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8XHYtGO";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A9B10E2AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 18:14:12 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so4681288a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708452852; x=1709057652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVBaWzeVokqKhdlqG7O+PxMZPUVca0xVdEqixySYpMY=;
 b=m8XHYtGOv2Qwd2mSc3nKOBAwigq/aSuLhgkniGCv/hl3uXKV66fB/Fm0hOFXHX/iQb
 3psM6FrDAlpU5Y32Uevn5ki8Ah75PLQBhjS+9aR7hKBHqxn7z/dwQrxpfEWPeOec4ZQ7
 3MPWvbxW1Qh2uFziTjrumIfTfLqZp5qlxN7JeBXbH/ADlQN4rTYn0cRyIZ4Zgo690hGn
 SShS1d4sNtv0uYR3zyayYFbY/lDCWZI0iLUtT+gCo/frf+a87moi1llqcR20UNGqnbVF
 cwBEhiSb5SYchNzkTqSBfK4BoVbNM50krCm4GrR3A6wlcYahe6RJgajnMN+QBQBRBfQW
 VXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708452852; x=1709057652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVBaWzeVokqKhdlqG7O+PxMZPUVca0xVdEqixySYpMY=;
 b=XLf1HrlBPkWZ8MMLqRHw/bH81T0XUV8ri3zTQK6l86qb9rIwICz50gr9uLdj2rsx1y
 osgA6rJHQ1xdpnvCxTQr2wrUZrxw+MWnW7qa2kmHSyzYS+fEMXiaDLn7A6faq2jKBHTN
 7L7hg/rr+s0ZL6IgvvFF8M5BuR4aWFg9Jo7PCKiQR8iYwpSuqkGkrHSBAEccC6Bo6YW7
 ZD8gPoLek0zUfDA3wE1JTHjKwhrmwUKzt1v9ebH6GnXVsV3FbUIb//GGsX6lE0Sr6D5i
 r01qWO/lBOb1qdinhc9Kq3ZLirieoOULjezmwz0ynHZ7qe96qys72HyBHAAlmXLDI02q
 UKmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyS12CV4YkmUsiB8FEu4GXCFZzdiDUVjfl0LM2jKNC3NN3HoR48cEXdLI91bxrRTENVmqPwGqg2Icu+YMKY+GJdIuFM6dgEYrfKdBaEg==
X-Gm-Message-State: AOJu0YwsJ3Cq4oabZtjQtHlPIMXOECVRNzWOVtMdStPhPK929EDzwpA9
 0MVYUJOwIbo6cjtowC3aipowPqwCPK+gZUN5Tq3pDai6Qha3O9bocvCZT24N02qavpe5om7E/em
 ZHU6nDVuCeCY3W8WmJ/xhWDjiM30=
X-Google-Smtp-Source: AGHT+IH/RMOR9qX0oSMWYPMMmECllCxsv0wpkML/jAYcPPrF65MqxsI7AWcUqmudVx+cZ7O8xbsT1aMkCRLltjMZI8Q=
X-Received: by 2002:a17:90a:d48f:b0:299:519b:7108 with SMTP id
 s15-20020a17090ad48f00b00299519b7108mr7660882pju.9.1708452852307; Tue, 20 Feb
 2024 10:14:12 -0800 (PST)
MIME-Version: 1.0
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
 <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
 <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
 <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
 <4bc8747a-d87f-423b-b0ce-8891e78ae094@redhat.com>
In-Reply-To: <4bc8747a-d87f-423b-b0ce-8891e78ae094@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Feb 2024 13:14:00 -0500
Message-ID: <CADnq5_NQM6phvaBupuAkJ0fX6vK=8yfbSz8-4P76fd8xHgiigg@mail.gmail.com>
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>, 
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

On Tue, Feb 20, 2024 at 10:27=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 2/20/24 16:15, Alex Deucher wrote:
> > On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Linux regression tracking (Tho=
rsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> On 20.02.24 15:45, Alex Deucher wrote:
> >>> On Mon, Feb 19, 2024 at 9:47=E2=80=AFAM Linux regression tracking (Th=
orsten
> >>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>
> >>>> On 17.02.24 14:30, Greg KH wrote:
> >>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
> >>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX=
 6700XT,
> >>>>>> mesa, archlinux) and I cannot get power cap as low as before(to 11=
5W),
> >>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable=
 read-only
> >>>>>> even for root. This is not of above apps issue but of the kernel, =
I read
> >>>>>> similar issues from other bug reports of above apps. I downgraded =
to v6.6.10
> >>>>>> kernel and my 115W(under power)cap work again as before.
> >>>>>
> >>>> For the record and everyone that lands here: the cause is known now
> >>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_mi=
n
> >>>> value") [v6.7-rc1]) and the issue afaics tracked here:
> >>>>
> >>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> >>>>
> >>>> Other mentions:
> >>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
> >>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
> >>>>
> >>>> Haven't seen any statement from the amdgpu developers (now CCed) yet=
 on
> >>>> this there (but might have missed something!). From what I can see I
> >>>> assume this will likely be somewhat tricky to handle, as a revert
> >>>> overall might be a bad idea here. We'll see I guess.
> >>>
> >>> The change aligns the driver what has been validated on each board
> >>> design.  Windows uses the same limits.  Using values lower than the
> >>> validated range can lead to undefined behavior and could potentially
> >>> damage your hardware.
> >>
> >> Thx for the reply! Yeah, I was expecting something along those lines.
> >>
> >> Nevertheless it afaics still is a regression in the eyes of many users=
.
> >> I'm not sure how Linus feels about this, but I wonder if we can find
> >> some solution here so that users that really want to, can continue to =
do
> >> what was possible out-of-the box before. Is that possible to realize o=
r
> >> even supported already?
> >>
> >> And sure, those users would be running their hardware outside of its
> >> specifications. But is that different from overclocking (which the
> >> driver allows, doesn't it? If not by all means please correct me!)?
> >
> > Sure.  The driver has always had upper bound limits for overclocking,
> > this change adds lower bounds checking for underclocking as well.
> > When the silicon validation teams set the bounding box for a device,
> > they set a range of values where it's reasonable to operate based on
> > the characteristics of the design.
> >
> > If we did want to allow extended underclocking, we need a big warning
> > in the logs at the very least.
>
> Requiring a module-option to be set to allow this, as well as a big
> warning in the logs sounds like a good solution to me.

I dunno.  I kind of go back and forth with it.  It's yet another knob
to maintain and when we've done things like this in the past, we get
lots of bug reports or angry users because the kernel is sending
warnings when they set it.

Alex

>
> Regards,
>
> Hans
>
>
>
>
>
> >>>> Roman posted something that apparently was meant to go to the list, =
so
> >>>> let me put it here:
> >>>>
> >>>> """
> >>>> UPDATE: User fililip already posted patch, but it need to be merged,
> >>>> discussion is on gitlab link below.
> >>>>
> >>>> (PS: I hope I am replying correctly to "all" now? - using original a=
ddr.)
> >>>>
> >>>>
> >>>>> it seems that commit was already found(see user's 'fililip' comment=
):
> >>>>>
> >>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> >>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
> >>>>> Author: Ma Jun <Jun.Ma2@amd.com>
> >>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
> >>>>>
> >>>>>     drm/amd/pm: Support for getting power1_cap_min value
> >>>>>
> >>>>>     Support for getting power1_cap_min value on smu13 and smu11.
> >>>>>     For other Asics, we still use 0 as the default value.
> >>>>>
> >>>>>     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >>>>>     Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> >>>>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>
> >>>>> However, this is not good as it remove under-powering range too far=
. I
> >>>> was getting only about 7% less performance but 90W(!) less consumpti=
on
> >>>> when set to my 115W before. Also I wonder if we as a OS of options a=
nd
> >>>> freedom have to stick to such very high reference for min values wit=
hout
> >>>> ability to override them through some sys ctrls. Commit was done by =
amd
> >>>> guy and I wonder if because of maybe this post that I made few month=
s
> >>>> ago(business strategy?):
> >>>>>
> >>>>>
> >>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to=
_capped_115w_at_only_10/
> >>>>>
> >>>>> This is not a dangerous OC upwards where I can understand desire to
> >>>> protect HW, it is downward, having min cap at 190W when card pull on
> >>>> 115W almost same speed is IMO crazy to deny. We don't talk about def=
ault
> >>>> or reference values here either, just a move to lower the range of
> >>>> options for whatever reason.
> >>>>>
> >>>>> I don't know how much power you guys have over them, but please
> >>>> consider either reverting this change, or give us an option to set
> >>>> min_cap through say /sys (right now param is readonly, even for root=
).
> >>>>>
> >>>>>
> >>>>> Thank you in advance for looking into this, with regards:  Romano
> >>>> """
> >>>>
> >>>> And while at it, let me add this issue to the tracking as well
> >>>>
> >>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
> >>>> regressions; the text you find below is based on a few templates
> >>>> paragraphs you might have encountered already in similar form.
> >>>> See link in footer if these mails annoy you.]
> >>>>
> >>>> Thanks for the report. To be sure the issue doesn't fall through the
> >>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regress=
ion
> >>>> tracking bot:
> >>>>
> >>>> #regzbot introduced 1958946858a62b /
> >>>> #regzbot title drm: amdgpu: under-powering broke
> >>>>
> >>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' =
hat)
> >>>> --
> >>>> Everything you wanna know about Linux kernel regression tracking:
> >>>> https://linux-regtracking.leemhuis.info/about/#tldr
> >>>> That page also explains what to do if mails like this annoy you.
> >>>
> >>>
> >
>
