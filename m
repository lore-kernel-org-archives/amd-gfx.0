Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF39AC48BC4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 20:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FE410E097;
	Tue, 20 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SU87Qa2x";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8CA10E097
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 20:19:11 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso5519113a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 12:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708460351; x=1709065151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7YC8fGEicIHkV9aDCwTa9axbQlb7lkTnq+sSaoXAXI=;
 b=SU87Qa2xmD1LlQmr+GQTm9KYNwbpLarZpmosg2tTcTgyaBzcZ8pYlBKQ+cc2kOP4xy
 np/Pu65ChGw+Qe3EOmjelhoGh4WO8U/IGW8L352UKZZYFOGB9J16lxuLXVZXm8prjpta
 Nq0AuKlQxsc4VJ9A/qaAO+7FJWeerBFhy8QFRTO49ygtlx6CwAdtYXQWWUipSmuxbzn7
 jLyA438Xmst5mLE2h56ddBNryJF+pMehDeW61MBy+w/ZBium5ofh5MPtus0EcbvBaegz
 QInNdBuFbCNO9nurpRwg7s/3IwjEQ4dNStSNrvxCHKbIJynjrxbbr4U05ZHzXc5L6T1v
 wQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708460351; x=1709065151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7YC8fGEicIHkV9aDCwTa9axbQlb7lkTnq+sSaoXAXI=;
 b=ZkJA+BLNgsUAKLyH8xJyUIa/cpDurU3e/khJA4JeXf0zIIrkeDj0UDA1NOq810ni9r
 TEXWhBcIaPN5zglb9imJw9jQlkp2al35wtjUFzNxUnVtDoe69/Ndi7RYwMYuQ+VX61Io
 iIWC9F6ycD+ARnKWaPSk5uaB6kBL/73WE6pvrauz1iNioJtTEjIsQddLVVQZu33r+oja
 kGUBAB3oooWtiAiSPdG+aMmm4m7SF7WW9j/DDqn4ubiz3wXk5VJOe4h1f4QC8cdqC/Jb
 V6JVH4lCq5Xr0UnFD+sV5JP/EqFghgHXcmYl+fEGAHxa1vnbeWiLHGaBAXtv0wI9CFzJ
 YerQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsKW5N2ZvNEC8HCNSlrpT0kAzCua9dozpcyOJ9sLDMM2+VjTLg4ptvZg+1YEtMT7bWqBQzdIGNl89xEy/NJHvLaTR6AQ98hLYmfBciGQ==
X-Gm-Message-State: AOJu0YzCXl29wvhEmjdNpgraBV+NeGOZnI6gHIwf8rtEhRdFMkaNFQZ+
 8FBsPh5FnwoGRVrw/8wlCy2/uaJ6qC+ak3FIpNkR5vMK1IsbKH3UMEQ5k+hnlsc4ppVjgv45Hf2
 aT806O6/diJGxVC2+8dfHwRvVBVI=
X-Google-Smtp-Source: AGHT+IG0wzqy2Tfjkemwpj3sDMv4npRLTuC3pKMMStySLPiZAhhhchsirVZDiGyTPc9qthY/+uUo9us/gp0lMkLtZNM=
X-Received: by 2002:a17:90a:e645:b0:299:11ae:d507 with SMTP id
 ep5-20020a17090ae64500b0029911aed507mr11611099pjb.1.1708460351148; Tue, 20
 Feb 2024 12:19:11 -0800 (PST)
MIME-Version: 1.0
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
In-Reply-To: <3e077b5f-0684-4a07-9b74-ab242bb01975@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Feb 2024 15:18:58 -0500
Message-ID: <CADnq5_NszWGKVZZomTojAm_u7O-04M6x_ox4KXQC79OuGA9ARA@mail.gmail.com>
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Romano <romaniox@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Hans de Goede <hdegoede@redhat.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Greg KH <gregkh@linuxfoundation.org>
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

On Tue, Feb 20, 2024 at 2:41=E2=80=AFPM Romano <romaniox@gmail.com> wrote:
>
> If the increased low range is allowed via boot option, like in proposed
> patch, user clearly made an intentional decision. Undefined, but won't
> fry his hardware for sure. Undefined is also overclocking in that
> matter. You can go out of range with ratio of voltage vs frequency(still
> within vendor's limits) for example and crash the system.

This whole thing reminds me of this:
https://xkcd.com/1172/
The problem is another module parameter is another interface to
maintain and validate.  Moreover, we've had a number of cases in the
past where users have under or overclocked and reported bugs or
stability issues and it did not come to light that they were doing
that until we'd already spent a good deal of time trying to debug the
issue.  This obviously can still happen if you allow any sort of over
or underclocking, but at least if you stick to the limits you are
staying within the bounding box of the design.

Alex

>
>
>
> On 2/20/24 19:09, Alex Deucher wrote:
> > On Tue, Feb 20, 2024 at 11:46=E2=80=AFAM Romano <romaniox@gmail.com> wr=
ote:
> >> For Windows, apps like MSI Afterburner is the one to try and what most
> >> people go for. Using it in the past myself, I would be surprised if it
> >> adhered to such a high min power cap. But even if it did, why would we
> >> have to.
> >>
> >> Relying on vendors cap in this case has already proven wrong because
> >> things worked for quite some time already and people reported saving
> >> significant amount of watts, in my case 90W(!) for <10% perf.
> >>
> >> Therefore this talk about safety seems rather strange to me and
> >> especially so when we are talking about min_cap. Or name me a single
> >> case where someone fried his card due to "too low power" set in said
> >> variable. Now there was a report, where by going way too low, driver
> >> goes opposite into max power. That's it. That can be easily
> >> detected(vents going crazy etc.) and reverted. It is a max_cap that
> >> protect HW(also above scenario), not a min_cap. Feel free to adhere to
> >> safety standards with that one.
> > Because operation outside of the design bounding box is undefined.  It
> > might work for some boards but not others.  It's possible some of the
> > logic in the firmware or some of the components used on the board may
> > not work correctly below a certain limit, or the voltage regulators
> > used on a specific board have a minimum requirement that would not be
> > an issue if you stick the bounding box.
> >
> > Alex
> >
> >> As for solution, what some suggested already exist - a patch posted by
> >> fililip on gitlab is probably the way most of you would agree. It
> >> introduce a variable that can be set during boot to override min_cap.
> >> But he did not pull requested it, so please, if any one of you who hav=
e
> >> access to code and merge kernel would be kind enough to implement it.
> >>
> >>
> >>
> >> On 2/20/24 16:46, Alex Deucher wrote:
> >>> On Tue, Feb 20, 2024 at 10:42=E2=80=AFAM Linux regression tracking (T=
horsten
> >>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>
> >>>> On 20.02.24 16:27, Hans de Goede wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 2/20/24 16:15, Alex Deucher wrote:
> >>>>>> On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Linux regression tracking=
 (Thorsten
> >>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>>>> On 20.02.24 15:45, Alex Deucher wrote:
> >>>>>>>> On Mon, Feb 19, 2024 at 9:47=E2=80=AFAM Linux regression trackin=
g (Thorsten
> >>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>>>>>> On 17.02.24 14:30, Greg KH wrote:
> >>>>>>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
> >>>>>>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GP=
U (RX 6700XT,
> >>>>>>>>>>> mesa, archlinux) and I cannot get power cap as low as before(=
to 115W),
> >>>>>>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a var=
iable read-only
> >>>>>>>>>>> even for root. This is not of above apps issue but of the ker=
nel, I read
> >>>>>>>>>>> similar issues from other bug reports of above apps. I downgr=
aded to v6.6.10
> >>>>>>>>>>> kernel and my 115W(under power)cap work again as before.
> >>>>>>>>> For the record and everyone that lands here: the cause is known=
 now
> >>>>>>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_c=
ap_min
> >>>>>>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
> >>>>>>>>>
> >>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> >>>>>>>>>
> >>>>>>>>> Other mentions:
> >>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
> >>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
> >>>>>>>>>
> >>>>>>>>> Haven't seen any statement from the amdgpu developers (now CCed=
) yet on
> >>>>>>>>> this there (but might have missed something!). From what I can =
see I
> >>>>>>>>> assume this will likely be somewhat tricky to handle, as a reve=
rt
> >>>>>>>>> overall might be a bad idea here. We'll see I guess.
> >>>>>>>> The change aligns the driver what has been validated on each boa=
rd
> >>>>>>>> design.  Windows uses the same limits.  Using values lower than =
the
> >>>>>>>> validated range can lead to undefined behavior and could potenti=
ally
> >>>>>>>> damage your hardware.
> >>>>>>> Thx for the reply! Yeah, I was expecting something along those li=
nes.
> >>>>>>>
> >>>>>>> Nevertheless it afaics still is a regression in the eyes of many =
users.
> >>>>>>> I'm not sure how Linus feels about this, but I wonder if we can f=
ind
> >>>>>>> some solution here so that users that really want to, can continu=
e to do
> >>>>>>> what was possible out-of-the box before. Is that possible to real=
ize or
> >>>>>>> even supported already?
> >>>>>>>
> >>>>>>> And sure, those users would be running their hardware outside of =
its
> >>>>>>> specifications. But is that different from overclocking (which th=
e
> >>>>>>> driver allows, doesn't it? If not by all means please correct me!=
)?
> >>>>>> Sure.  The driver has always had upper bound limits for overclocki=
ng,
> >>>>>> this change adds lower bounds checking for underclocking as well.
> >>>>>> When the silicon validation teams set the bounding box for a devic=
e,
> >>>>>> they set a range of values where it's reasonable to operate based =
on
> >>>>>> the characteristics of the design.
> >>>>>>
> >>>>>> If we did want to allow extended underclocking, we need a big warn=
ing
> >>>>>> in the logs at the very least.
> >>>>> Requiring a module-option to be set to allow this, as well as a big
> >>>>> warning in the logs sounds like a good solution to me.
> >>>> Yeah, especially as it sounds from some of the reports as if some
> >>>> vendors did a really bad job when it came to setting the proper
> >>>> lower-bound limits are now adhered -- and thus higher then what we u=
sed
> >>>> out-of-the box before 1958946858a62b was applied.
> >>>>
> >>>> Side note: I assume those "lower bounds checking" is done round abou=
t
> >>>> the same way by the Windows driver? Does that one allow users to go
> >>>> lower somehow? Say after modifying the registry or something like th=
at?
> >>>> Or through external tools?
> >>> Windows uses the same limit.  I'm not aware of any way to override th=
e
> >>> limit on windows off hand.
> >>>
> >>> Alex
> >>>
> >>>
> >>>> Ciao, Thorsten
> >>>>
> >>>>>>>>> Roman posted something that apparently was meant to go to the l=
ist, so
> >>>>>>>>> let me put it here:
> >>>>>>>>>
> >>>>>>>>> """
> >>>>>>>>> UPDATE: User fililip already posted patch, but it need to be me=
rged,
> >>>>>>>>> discussion is on gitlab link below.
> >>>>>>>>>
> >>>>>>>>> (PS: I hope I am replying correctly to "all" now? - using origi=
nal addr.)
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> it seems that commit was already found(see user's 'fililip' co=
mment):
> >>>>>>>>>>
> >>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> >>>>>>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
> >>>>>>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
> >>>>>>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
> >>>>>>>>>>
> >>>>>>>>>>       drm/amd/pm: Support for getting power1_cap_min value
> >>>>>>>>>>
> >>>>>>>>>>       Support for getting power1_cap_min value on smu13 and sm=
u11.
> >>>>>>>>>>       For other Asics, we still use 0 as the default value.
> >>>>>>>>>>
> >>>>>>>>>>       Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >>>>>>>>>>       Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> >>>>>>>>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>>
> >>>>>>>>>> However, this is not good as it remove under-powering range to=
o far. I
> >>>>>>>>> was getting only about 7% less performance but 90W(!) less cons=
umption
> >>>>>>>>> when set to my 115W before. Also I wonder if we as a OS of opti=
ons and
> >>>>>>>>> freedom have to stick to such very high reference for min value=
s without
> >>>>>>>>> ability to override them through some sys ctrls. Commit was don=
e by amd
> >>>>>>>>> guy and I wonder if because of maybe this post that I made few =
months
> >>>>>>>>> ago(business strategy?):
> >>>>>>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_23=
0w_to_capped_115w_at_only_10/
> >>>>>>>>>> This is not a dangerous OC upwards where I can understand desi=
re to
> >>>>>>>>> protect HW, it is downward, having min cap at 190W when card pu=
ll on
> >>>>>>>>> 115W almost same speed is IMO crazy to deny. We don't talk abou=
t default
> >>>>>>>>> or reference values here either, just a move to lower the range=
 of
> >>>>>>>>> options for whatever reason.
> >>>>>>>>>> I don't know how much power you guys have over them, but pleas=
e
> >>>>>>>>> consider either reverting this change, or give us an option to =
set
> >>>>>>>>> min_cap through say /sys (right now param is readonly, even for=
 root).
> >>>>>>>>>> Thank you in advance for looking into this, with regards:  Rom=
ano
> >>>>>>>>> """
> >>>>>>>>>
> >>>>>>>>> And while at it, let me add this issue to the tracking as well
> >>>>>>>>>
> >>>>>>>>> [TLDR: I'm adding this report to the list of tracked Linux kern=
el
> >>>>>>>>> regressions; the text you find below is based on a few template=
s
> >>>>>>>>> paragraphs you might have encountered already in similar form.
> >>>>>>>>> See link in footer if these mails annoy you.]
> >>>>>>>>>
> >>>>>>>>> Thanks for the report. To be sure the issue doesn't fall throug=
h the
> >>>>>>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel re=
gression
> >>>>>>>>> tracking bot:
> >>>>>>>>>
> >>>>>>>>> #regzbot introduced 1958946858a62b /
> >>>>>>>>> #regzbot title drm: amdgpu: under-powering broke
> >>>>>>>>>
> >>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression trac=
ker' hat)
> >>>>>>>>> --
> >>>>>>>>> Everything you wanna know about Linux kernel regression trackin=
g:
> >>>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
> >>>>>>>>> That page also explains what to do if mails like this annoy you=
.
> >>>>>
