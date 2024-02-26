Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5023C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 13:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB3410E72E;
	Mon, 26 Feb 2024 13:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="aRFQbSGW";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DAC10E733
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 13:04:28 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-214309bbbf0so395338fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 05:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1708952668; x=1709557468; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX7VUDy6C8EqUlEHVYy/DntJMXyLNvjPfTsZZUF+a3o=;
 b=aRFQbSGWK+IVn4r8MvTi4eNBTP85EyoJLJ326M2m7ms+WHLB72mItk1eJORKNORUTu
 ut5AnoB/hDGoh9JnzBgujPpfCikUbiM6bWUc7PRKTnPw18Od6H7TbCRh+TXnQSdYFD1T
 UwDv78bM6PhVk65Iw3OZSPglkuZZCF3AGr5vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708952668; x=1709557468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX7VUDy6C8EqUlEHVYy/DntJMXyLNvjPfTsZZUF+a3o=;
 b=wjXC0TXJKhHgx0mlYoH9VpofntsIJAZQNsbm3Z00CdIqpKRJ2xqR2SBNNg2JaRgIz/
 XJwA3T1itJP3MrYT+ZyJqr5921JL4yiyEEV6JnxApoqmqqF75K2gi/sa40d3rW/b3CqX
 mB7XhdczEXPN8YVFdANdpV5OJM+44QRUpkUHyAfbu4EW3B7W9GmKfiBR94rjiywo7tuu
 dxXlWKMJ8ImF9j70tIbjFp4oK6wwTuXRmK5VaEWoofvtmPRye8t4gRoxNupYi+v+mI/V
 hskQJWheaUxbkf0qeztlniPjks8V8COZZwLuyjlbhHuSi3YIpsx1GniKv3AVfbjRI9ej
 Rq/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMq370jcrt1S2HWPNxGX9y6uRE+BVABEC3TYORGrmhv5U2mwtf9QVmfJInWke7AaNclUG78kkIrHfKrzVkK6O59laQGfDQvHtXxphUIQ==
X-Gm-Message-State: AOJu0YxPHdGyvZQ2Ta0FAP/90baSzq4q6nSm7fH8auuZm4qjg9BuEB7s
 x35vmshOIAuDyn60k9HeoCG/FxfNtgT0xIqI9TB08iTxl7ytX8wnjS4vjtl2bZFswUGMMvsL+pp
 EYEgbI/e5avQsb/p4dJ7iXAjUj4ezvj/aR0Qhyw==
X-Google-Smtp-Source: AGHT+IG1nnNuy+E0eS0NAoVZPn9o777FRDea7L08AWRJtt8D9XvSZBUHx7tYiBcNHwVvYJHG0SBtUG9WcmsjVKZyGyM=
X-Received: by 2002:a05:6870:a2c8:b0:21a:83fa:a5dd with SMTP id
 w8-20020a056870a2c800b0021a83faa5ddmr7193976oak.3.1708952667536; Mon, 26 Feb
 2024 05:04:27 -0800 (PST)
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
 <CADnq5_NszWGKVZZomTojAm_u7O-04M6x_ox4KXQC79OuGA9ARA@mail.gmail.com>
 <af6291d4-45c3-4eb6-95b8-14a5221e72a1@leemhuis.info>
 <CADnq5_Md1yQVxfxWBju7xrqZcU18KqfaJRGcE3tumCUy_3tHoA@mail.gmail.com>
In-Reply-To: <CADnq5_Md1yQVxfxWBju7xrqZcU18KqfaJRGcE3tumCUy_3tHoA@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 26 Feb 2024 14:04:16 +0100
Message-ID: <CAKMK7uGuh7E3rYX-Lirme2gD8tdSNVe-C1wLx21_GYLQCMY8qw@mail.gmail.com>
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Romano <romaniox@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
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

Back from vacations ...

On Wed, 21 Feb 2024 at 16:39, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Feb 21, 2024 at 1:06=E2=80=AFAM Linux regression tracking (Thorst=
en
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > On 20.02.24 21:18, Alex Deucher wrote:
> > > On Tue, Feb 20, 2024 at 2:41=E2=80=AFPM Romano <romaniox@gmail.com> w=
rote:
> > >>
> > >> If the increased low range is allowed via boot option, like in propo=
sed
> > >> patch, user clearly made an intentional decision. Undefined, but won=
't
> > >> fry his hardware for sure. Undefined is also overclocking in that
> > >> matter. You can go out of range with ratio of voltage vs frequency(s=
till
> > >> within vendor's limits) for example and crash the system.
> > >
> > > This whole thing reminds me of this:
> > > https://xkcd.com/1172/
> > > The problem is another module parameter is another interface to
> > > maintain and validate.
> >
> > Yup, of course, all that is understood.
> >
> > But we have this "no regressions" rule for a reason. Adhering to it
> > strictly would afaics be counter-productive in this situation, but give
> > users some way to manually do what was possible before out-of-the box
> > IMHO is the minimum we should do.
> >
> > Maybe just allow that parameter only up to a certain recent GPU
> > generation, that way you won't have to deal with that at some point in
> > the future.
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

Chiming in here ...

tldr; yes

gpu drivers are ridiculously hard to get right, combinatorial
explosion is a real issue and concern, it's not some hiding behind
corporate rules - drm folks added module_param*unsafe to discourage
users from playing around with options we need for debugging for very,
very real reasons. We have aggressively removed tuning knobs in the
past, and those we have in various drivers are causing endless amounts
of pain.

Also, the "no regression" rules is not ironclad, especially on
power/perf regressions, or all the security fixes would be impossible
to merge. First make it correct (even if the bug has gone unnoticed
for forever), then make it fast/power efficient/pretty/whatever people
fancy. Yes there's some exceptions like "my desktop is crawling like a
slide-show and absolutely unusable" kind of regressions, but my
understanding is this isn't the case here.

So unless Dave or Linus are screaming and overruling Alex here, "do
nothing" is my take here too.

Cheers, Sima

>
> Alex
>
> > >  Moreover, we've had a number of cases in the
> > > past where users have under or overclocked and reported bugs or
> > > stability issues and it did not come to light that they were doing
> > > that until we'd already spent a good deal of time trying to debug the
> > > issue.
> >
> > Taint the kernel when that module parameter is used? We iirc have a
> > taint bit exactly for this sort of situation. Sure, such reports will
> > still happen, but then you at least have an indicator to spot them.
> >
> > Ciao, Thorsten
> >
> > >  This obviously can still happen if you allow any sort of over
> > > or underclocking, but at least if you stick to the limits you are
> > > staying within the bounding box of the design.
> > >
> > > Alex
> > >
> > >> On 2/20/24 19:09, Alex Deucher wrote:
> > >>> On Tue, Feb 20, 2024 at 11:46=E2=80=AFAM Romano <romaniox@gmail.com=
> wrote:
> > >>>> For Windows, apps like MSI Afterburner is the one to try and what =
most
> > >>>> people go for. Using it in the past myself, I would be surprised i=
f it
> > >>>> adhered to such a high min power cap. But even if it did, why woul=
d we
> > >>>> have to.
> > >>>>
> > >>>> Relying on vendors cap in this case has already proven wrong becau=
se
> > >>>> things worked for quite some time already and people reported savi=
ng
> > >>>> significant amount of watts, in my case 90W(!) for <10% perf.
> > >>>>
> > >>>> Therefore this talk about safety seems rather strange to me and
> > >>>> especially so when we are talking about min_cap. Or name me a sing=
le
> > >>>> case where someone fried his card due to "too low power" set in sa=
id
> > >>>> variable. Now there was a report, where by going way too low, driv=
er
> > >>>> goes opposite into max power. That's it. That can be easily
> > >>>> detected(vents going crazy etc.) and reverted. It is a max_cap tha=
t
> > >>>> protect HW(also above scenario), not a min_cap. Feel free to adher=
e to
> > >>>> safety standards with that one.
> > >>> Because operation outside of the design bounding box is undefined. =
 It
> > >>> might work for some boards but not others.  It's possible some of t=
he
> > >>> logic in the firmware or some of the components used on the board m=
ay
> > >>> not work correctly below a certain limit, or the voltage regulators
> > >>> used on a specific board have a minimum requirement that would not =
be
> > >>> an issue if you stick the bounding box.
> > >>>
> > >>> Alex
> > >>>
> > >>>> As for solution, what some suggested already exist - a patch poste=
d by
> > >>>> fililip on gitlab is probably the way most of you would agree. It
> > >>>> introduce a variable that can be set during boot to override min_c=
ap.
> > >>>> But he did not pull requested it, so please, if any one of you who=
 have
> > >>>> access to code and merge kernel would be kind enough to implement =
it.
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 2/20/24 16:46, Alex Deucher wrote:
> > >>>>> On Tue, Feb 20, 2024 at 10:42=E2=80=AFAM Linux regression trackin=
g (Thorsten
> > >>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> > >>>>>>
> > >>>>>> On 20.02.24 16:27, Hans de Goede wrote:
> > >>>>>>> Hi,
> > >>>>>>>
> > >>>>>>> On 2/20/24 16:15, Alex Deucher wrote:
> > >>>>>>>> On Tue, Feb 20, 2024 at 10:03=E2=80=AFAM Linux regression trac=
king (Thorsten
> > >>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> > >>>>>>>>> On 20.02.24 15:45, Alex Deucher wrote:
> > >>>>>>>>>> On Mon, Feb 19, 2024 at 9:47=E2=80=AFAM Linux regression tra=
cking (Thorsten
> > >>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> > >>>>>>>>>>> On 17.02.24 14:30, Greg KH wrote:
> > >>>>>>>>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrot=
e:
> > >>>>>>>>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for m=
y GPU (RX 6700XT,
> > >>>>>>>>>>>>> mesa, archlinux) and I cannot get power cap as low as bef=
ore(to 115W),
> > >>>>>>>>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a=
 variable read-only
> > >>>>>>>>>>>>> even for root. This is not of above apps issue but of the=
 kernel, I read
> > >>>>>>>>>>>>> similar issues from other bug reports of above apps. I do=
wngraded to v6.6.10
> > >>>>>>>>>>>>> kernel and my 115W(under power)cap work again as before.
> > >>>>>>>>>>> For the record and everyone that lands here: the cause is k=
nown now
> > >>>>>>>>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting powe=
r1_cap_min
> > >>>>>>>>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
> > >>>>>>>>>>>
> > >>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> > >>>>>>>>>>>
> > >>>>>>>>>>> Other mentions:
> > >>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
> > >>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
> > >>>>>>>>>>>
> > >>>>>>>>>>> Haven't seen any statement from the amdgpu developers (now =
CCed) yet on
> > >>>>>>>>>>> this there (but might have missed something!). From what I =
can see I
> > >>>>>>>>>>> assume this will likely be somewhat tricky to handle, as a =
revert
> > >>>>>>>>>>> overall might be a bad idea here. We'll see I guess.
> > >>>>>>>>>> The change aligns the driver what has been validated on each=
 board
> > >>>>>>>>>> design.  Windows uses the same limits.  Using values lower t=
han the
> > >>>>>>>>>> validated range can lead to undefined behavior and could pot=
entially
> > >>>>>>>>>> damage your hardware.
> > >>>>>>>>> Thx for the reply! Yeah, I was expecting something along thos=
e lines.
> > >>>>>>>>>
> > >>>>>>>>> Nevertheless it afaics still is a regression in the eyes of m=
any users.
> > >>>>>>>>> I'm not sure how Linus feels about this, but I wonder if we c=
an find
> > >>>>>>>>> some solution here so that users that really want to, can con=
tinue to do
> > >>>>>>>>> what was possible out-of-the box before. Is that possible to =
realize or
> > >>>>>>>>> even supported already?
> > >>>>>>>>>
> > >>>>>>>>> And sure, those users would be running their hardware outside=
 of its
> > >>>>>>>>> specifications. But is that different from overclocking (whic=
h the
> > >>>>>>>>> driver allows, doesn't it? If not by all means please correct=
 me!)?
> > >>>>>>>> Sure.  The driver has always had upper bound limits for overcl=
ocking,
> > >>>>>>>> this change adds lower bounds checking for underclocking as we=
ll.
> > >>>>>>>> When the silicon validation teams set the bounding box for a d=
evice,
> > >>>>>>>> they set a range of values where it's reasonable to operate ba=
sed on
> > >>>>>>>> the characteristics of the design.
> > >>>>>>>>
> > >>>>>>>> If we did want to allow extended underclocking, we need a big =
warning
> > >>>>>>>> in the logs at the very least.
> > >>>>>>> Requiring a module-option to be set to allow this, as well as a=
 big
> > >>>>>>> warning in the logs sounds like a good solution to me.
> > >>>>>> Yeah, especially as it sounds from some of the reports as if som=
e
> > >>>>>> vendors did a really bad job when it came to setting the proper
> > >>>>>> lower-bound limits are now adhered -- and thus higher then what =
we used
> > >>>>>> out-of-the box before 1958946858a62b was applied.
> > >>>>>>
> > >>>>>> Side note: I assume those "lower bounds checking" is done round =
about
> > >>>>>> the same way by the Windows driver? Does that one allow users to=
 go
> > >>>>>> lower somehow? Say after modifying the registry or something lik=
e that?
> > >>>>>> Or through external tools?
> > >>>>> Windows uses the same limit.  I'm not aware of any way to overrid=
e the
> > >>>>> limit on windows off hand.
> > >>>>>
> > >>>>> Alex
> > >>>>>
> > >>>>>
> > >>>>>> Ciao, Thorsten
> > >>>>>>
> > >>>>>>>>>>> Roman posted something that apparently was meant to go to t=
he list, so
> > >>>>>>>>>>> let me put it here:
> > >>>>>>>>>>>
> > >>>>>>>>>>> """
> > >>>>>>>>>>> UPDATE: User fililip already posted patch, but it need to b=
e merged,
> > >>>>>>>>>>> discussion is on gitlab link below.
> > >>>>>>>>>>>
> > >>>>>>>>>>> (PS: I hope I am replying correctly to "all" now? - using o=
riginal addr.)
> > >>>>>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>>>> it seems that commit was already found(see user's 'fililip=
' comment):
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> > >>>>>>>>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
> > >>>>>>>>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
> > >>>>>>>>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>       drm/amd/pm: Support for getting power1_cap_min value
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>       Support for getting power1_cap_min value on smu13 an=
d smu11.
> > >>>>>>>>>>>>       For other Asics, we still use 0 as the default value=
.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>       Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> > >>>>>>>>>>>>       Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> > >>>>>>>>>>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.c=
om>
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> However, this is not good as it remove under-powering rang=
e too far. I
> > >>>>>>>>>>> was getting only about 7% less performance but 90W(!) less =
consumption
> > >>>>>>>>>>> when set to my 115W before. Also I wonder if we as a OS of =
options and
> > >>>>>>>>>>> freedom have to stick to such very high reference for min v=
alues without
> > >>>>>>>>>>> ability to override them through some sys ctrls. Commit was=
 done by amd
> > >>>>>>>>>>> guy and I wonder if because of maybe this post that I made =
few months
> > >>>>>>>>>>> ago(business strategy?):
> > >>>>>>>>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_fro=
m_230w_to_capped_115w_at_only_10/
> > >>>>>>>>>>>> This is not a dangerous OC upwards where I can understand =
desire to
> > >>>>>>>>>>> protect HW, it is downward, having min cap at 190W when car=
d pull on
> > >>>>>>>>>>> 115W almost same speed is IMO crazy to deny. We don't talk =
about default
> > >>>>>>>>>>> or reference values here either, just a move to lower the r=
ange of
> > >>>>>>>>>>> options for whatever reason.
> > >>>>>>>>>>>> I don't know how much power you guys have over them, but p=
lease
> > >>>>>>>>>>> consider either reverting this change, or give us an option=
 to set
> > >>>>>>>>>>> min_cap through say /sys (right now param is readonly, even=
 for root).
> > >>>>>>>>>>>> Thank you in advance for looking into this, with regards: =
 Romano
> > >>>>>>>>>>> """
> > >>>>>>>>>>>
> > >>>>>>>>>>> And while at it, let me add this issue to the tracking as w=
ell
> > >>>>>>>>>>>
> > >>>>>>>>>>> [TLDR: I'm adding this report to the list of tracked Linux =
kernel
> > >>>>>>>>>>> regressions; the text you find below is based on a few temp=
lates
> > >>>>>>>>>>> paragraphs you might have encountered already in similar fo=
rm.
> > >>>>>>>>>>> See link in footer if these mails annoy you.]
> > >>>>>>>>>>>
> > >>>>>>>>>>> Thanks for the report. To be sure the issue doesn't fall th=
rough the
> > >>>>>>>>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kerne=
l regression
> > >>>>>>>>>>> tracking bot:
> > >>>>>>>>>>>
> > >>>>>>>>>>> #regzbot introduced 1958946858a62b /
> > >>>>>>>>>>> #regzbot title drm: amdgpu: under-powering broke
> > >>>>>>>>>>>
> > >>>>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression =
tracker' hat)
> > >>>>>>>>>>> --
> > >>>>>>>>>>> Everything you wanna know about Linux kernel regression tra=
cking:
> > >>>>>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
> > >>>>>>>>>>> That page also explains what to do if mails like this annoy=
 you.
> > >>>>>>>
> > >
> > >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
