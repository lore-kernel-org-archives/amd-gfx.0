Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 15:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97235604E9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 15:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97235604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0499C6E8C0;
	Wed, 27 Oct 2021 15:12:18 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F053C6E8B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 15:12:16 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 q39-20020a4a962a000000b002b8bb100791so1049149ooi.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ubRtHJji8qralq4npOmVoRDXuTjBC/iGEPP2eSScFVM=;
 b=dwp10hmU0tM+WLNbvrwC5kEEFu8KRGIgALljJZJps6EEC9duO3k1YMdwptiNhOdYX5
 orFNOSIs6DTCdZGvWHQnF0PbfeP9OdQEcsJUV/Il5a/B4nrU9O89mz/tFZRHGLpmMGjA
 KtK/I7+SWS+We//enS+a4MtihiUxKA7a6UfFZ2SMWfwEoRjmbIzJ1dgxnKzuXstuKYVo
 UI4bDxXdpvpA04oKfeN79y1P/GHSg9jYv3Q/dfBzdAdUbGVv7hJpCFuyecY0NVr2FXwG
 F8SB8BAqDanA1OQD+OYlmqn/AJHE+0go1K/spJomq+Lnjy+giAHv3Ktzgy62m9UVhdPK
 JO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ubRtHJji8qralq4npOmVoRDXuTjBC/iGEPP2eSScFVM=;
 b=kscM1ICYMN115Lh/BYvnm93J0hW24sqq5Z8Z0coTIOb0gcDVQvnPzr+MKsaTdhEPGW
 5NL3gQQjjFzFUkCHHYtgBp/Qs23T4XYYS446htQq5XidpZbzoCT7nQluq9hz126qdqcv
 KfkOFKGSZM5Cukw9GGMW6C3voTfTZ32ZwL5ErFQVRPLgyNTl799RXlUDcLDs82s2qV0F
 xPp0yN+JXdFOFFaAFYVoV0XVne1JaiJiT4scv/CyVZNivmnHxoYwWRLBmZDRg53fHKbz
 9OqENJl3o+Y+0yRac5Mci8wZ66fp9nsJEot0lnd76hUjC9D2U6bCETeVb6NwDpLl9eQV
 ki0Q==
X-Gm-Message-State: AOAM532oo1T26NzEsyx64TFGKQkZr8Sh0/JJeb1MzUFRxshRWpwHN4no
 bDTe9XPDT1B8lH+WMijHzvjXzeA4K+bx8Nt6u2OU7rLe5iA=
X-Google-Smtp-Source: ABdhPJxLPyW+rIt6aYQ1i+uoRRq5+fWEZpDtJJrOFix4wE7bc0n7D4qEx1n4BohWJeV+xcnWbxkoRTsDyhzNPhLKykg=
X-Received: by 2002:a4a:8508:: with SMTP id k8mr4909324ooh.23.1635347536086;
 Wed, 27 Oct 2021 08:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <091c6805-a72c-a286-f7fb-9d5d5da344d3@amd.com>
 <DM6PR12MB3324CDCA68D04483A57C150985BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <DM6PR12MB3324C490C0CF191F6F34602C85BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <831e76f9-4fad-da9f-7baf-1e0dc92a378a@amd.com>
 <DM6PR12MB3324ECC96ADE558E587AAFF085BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <a0939873-8599-c47c-15ec-cfb5018edf57@amd.com>
 <CADnq5_O2o9e3FaRhdU17jbSwSjNt-czdQBnFY-5MSOBNR-gXPg@mail.gmail.com>
 <04c721d1-0561-fef8-263e-e492499ef77b@amd.com>
 <d0ed1ed4-42e8-4c05-f027-7bbb5486909b@amd.com>
In-Reply-To: <d0ed1ed4-42e8-4c05-f027-7bbb5486909b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Oct 2021 11:12:04 -0400
Message-ID: <CADnq5_POSaN7AbXV4BJgPRb7Dg0AgJb+eUdQs-pouqQdn-CFEw@mail.gmail.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
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

On Wed, Oct 27, 2021 at 1:20 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 10/27/2021 3:30 AM, Luben Tuikov wrote:
> > On 2021-10-26 17:26, Alex Deucher wrote:
> >> On Tue, Oct 19, 2021 at 9:54 AM Luben Tuikov <luben.tuikov@amd.com> wr=
ote:
> >>> It again fails with the same message!
> >>> But this time it is different!
> >>> Here's why:
> >>>
> >>> openat(AT_FDCWD, "/sys/class/drm/card0/device/pp_dpm_fclk", O_RDONLY)=
 =3D 3
> >>> read(3, "0: 571Mhz \n1: 1274Mhz *\n2: 1221M"..., 8191) =3D 36
> >>> read(3, "", 8191)                       =3D 0
> >>> close(3)                                =3D 0
> >>> write(2, "python3: /home/ltuikov/proj/amd/"..., 220python3: /home/ltu=
ikov/proj/amd/rocm_smi_lib/src/rocm_smi.cc:913: rsmi_status_t get_frequenci=
es(amd::smi::DevInfoTypes, uint32_t, rsmi_frequencies_t*, uint32_t*): Asser=
tion `f->frequency[i-1] <=3D f->frequency[i]' failed.
> >>> ) =3D 220
> >>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=
 0) =3D 0x7f531f9bc000
> >>> rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) =3D 0
> >>> rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) =3D 0
> >>> getpid()                                =3D 37861
> >>> gettid()                                =3D 37861
> >>> tgkill(37861, 37861, SIGABRT)           =3D 0
> >>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> >>> --- SIGABRT {si_signo=3DSIGABRT, si_code=3DSI_TKILL, si_pid=3D37861, =
si_uid=3D1000} ---
> >>> +++ killed by SIGABRT (core dumped) +++
> >>> Aborted (core dumped)
> >>> $cat /sys/class/drm/card0/device/pp_dpm_fclk
> >>> 0: 571Mhz
> >>> 1: 1274Mhz *
> >>> 2: 1221Mhz
> >>> $_
> >>>
> >>> Why is the mid frequency larger than the last?
> >>> Why does get_frequencies() insists that they be ordered when they're =
not? (Does the tool need fixing or the kernel?)
> >>>
> >>> The current patchset doesn't report 0, and doesn't report any current=
 if 0 would've been reported as current. But anything else is reported as i=
t would've been reported before the patch. And I tested it with vanilla amd=
-staging-drm-next--same thing.
> >>>
> >> Seems to crash both ways.  I'd rather either:
> >> 1. Remove the * when the clock is outside of the min and max ranges
> >> or
> >> 2. Clamp the clock to the max or min if it's above or below.
> >>
> >> And then fix the tools accordingly.  Those seem like the choices of
> >> least surprise considering the interface is supposed to show the
> >> current and available DPM levels.
> >
> > So, if we get a case such as the one above, we remove the whole line at=
 1:, not just the asterisk, right? (for option 1 above).
> > The rocm-smi lib would fail if they're out of order, so only removing t=
he * char would still confuse the tool.
> >
> > What does it mean when the current frequency (line 1:) is above the "ma=
x" (line 2:) as shown in my output above?
> >
> > Do we perhaps want to sort them and report current still, and swap line=
s 1 and 2?
> >
> > Or should we simply remove the ordering requirement in rocm-smi lib?
> >
> These nodes help to find the current state of ASIC. Clamping the values
> will just erase questions like these and possible improvements/fixes.
>

I don't really think that is the case.  E.g., rocm-smi expects the
values to be ordered.  As was previously discussed, this was
originally added as an interface to see what the current DPM state was
and as a way to mask out specific DPM states.  When discrete DPM
states went away, we end up with just a min and max so a middle step
was added to show the current clock in relation to the min and max.
When the clock is on, DPM is active and the clock should be >=3D min and
<=3D max.

> For ex: if the situation above is a case of OD (this is only example,
> don't know what is really the case above) that goes beyond regular DPM
> min/max levels, then we could add + as improvement.

With over- or under-clocking, shouldn't the min/max change instead?

>
> IMO, the node should reflect the current state of ASIC and masking the
> values shouldn't be done. Other cases could be 0 or FW handshake
> failures where * itself will be missing.

I'm fine with dropping the * for cases outside of the min/max, but I
think clamping works as well.  E.g., while SMU reports 0 in some
cases, that could be due to the clock being off or the block being
powergated.  It's still in the lowest state.  If the clock were on, it
would be in the lowest state.  Same thing on the high end.  It's
possible there is a little slop in the clock calculations for
stability.  E.g., the clock may be a few Mhz above the max because SMU
determined that the current max frequency was not stable in
combination with some other clock.  It's still ostensibly in the
highest DPM state.

Alex


>
> Thanks,
> Lijo
>
> > Regards,
> > Luben
> >
> >>
> >> Alex
> >>
> >>
> >>> Regards,
> >>> Luben
> >>>
> >>>
> >>> On 2021-10-19 09:25, Russell, Kent wrote:
> >>>
> >>> [AMD Official Use Only]
> >>>
> >>>
> >>>
> >>> It was the rocm-smi -c flag. Maybe some work was done to make it more=
 robust, that would be nice. But the -c flag is supposed to show the curren=
t frequency for each clock type. -g would do the same, but just for SCLK.
> >>>
> >>>
> >>>
> >>> Kent
> >>>
> >>>
> >>>
> >>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> >>> Sent: Tuesday, October 19, 2021 12:27 AM
> >>> To: Russell, Kent <Kent.Russell@amd.com>; Deucher, Alexander <Alexand=
er.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Laza=
r@amd.com>; amd-gfx@lists.freedesktop.org
> >>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> >>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
> >>>
> >>>
> >>>
> >>> Kent,
> >>>
> >>> What is the command which fails?
> >>> I can try to duplicate it here.
> >>>
> >>> So far, things I've tried, I cannot make rocm-smi fail. Command argum=
ents?
> >>>
> >>> Regards,
> >>> Luben
> >>>
> >>> On 2021-10-18 21:06, Russell, Kent wrote:
> >>>
> >>> [AMD Official Use Only]
> >>>
> >>>
> >>>
> >>> The * is required for the rocm-smi=E2=80=99s functionality for showin=
g what the current clocks are. We had a bug before where the * was removed,=
 then the SMI died fantastically. Work could be done to try to handle that =
type of situation, but the SMI has a =E2=80=9Cshow current clocks=E2=80=9D =
and uses the * to determine which one is active
> >>>
> >>>
> >>>
> >>> Kent
> >>>
> >>>
> >>>
> >>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ru=
ssell, Kent
> >>> Sent: Monday, October 18, 2021 9:05 PM
> >>> To: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexand=
er.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Laza=
r@amd.com>; amd-gfx@lists.freedesktop.org
> >>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> >>> Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
> >>>
> >>>
> >>>
> >>> [AMD Official Use Only]
> >>>
> >>>
> >>>
> >>> +Harish, rocm-smi falls under his purview now.
> >>>
> >>>
> >>>
> >>> Kent
> >>>
> >>>
> >>>
> >>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> >>> Sent: Monday, October 18, 2021 4:30 PM
> >>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.=
Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.=
org; Russell, Kent <Kent.Russell@amd.com>
> >>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
> >>>
> >>>
> >>>
> >>> I think Kent is already seen these patches as he did comment on 1/5 p=
atch.
> >>>
> >>> The v3 version of the patch, posted last week, removes the asterisk t=
o report the lowest frequency as the current frequency, when the current fr=
equency is 0, i.e. when the block is in low power state. Does the tool rely=
 on the asterisk? If this information is necessary could it not use amdgpu_=
pm_info?
> >>>
> >>> Regards,
> >>> Luben
> >>>
> >>> On 2021-10-18 16:19, Deucher, Alexander wrote:
> >>>
> >>> [Public]
> >>>
> >>>
> >>>
> >>> We the current behavior (0 for clock) already crashes the tool, so I =
don't think we can really make things worse.
> >>>
> >>>
> >>>
> >>> Alex
> >>>
> >>>
> >>>
> >>> ________________________________
> >>>
> >>> From: Quan, Evan <Evan.Quan@amd.com>
> >>> Sent: Thursday, October 14, 2021 10:25 PM
> >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Tuikov, Luben <Luben.Tuikov@amd=
.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Russe=
ll, Kent <Kent.Russell@amd.com>
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >>> Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
> >>>
> >>>
> >>>
> >>> [AMD Official Use Only]
> >>>
> >>>
> >>>
> >>> +Kent who maintains the Rocm tool
> >>>
> >>>
> >>>
> >>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of La=
zar, Lijo
> >>> Sent: Thursday, October 14, 2021 1:07 AM
> >>> To: Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.o=
rg
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
> >>>
> >>>
> >>>
> >>> [AMD Official Use Only]
> >>>
> >>>
> >>>
> >>> [AMD Official Use Only]
> >>>
> >>>
> >>>
> >>>> Or maybe just a list without default hint, i.e. no asterisk?
> >>>
> >>>
> >>> I think this is also fine meaning we are having trouble in determinin=
g the current frequency or DPM level. Evan/Alex? Don't know if this will cr=
ash the tools.
> >>>
> >>>
> >>>
> >>> Thanks,
> >>> Lijo
> >>>
> >>> ________________________________
> >>>
> >>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> >>> Sent: Wednesday, October 13, 2021 9:52:09 PM
> >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
> >>>
> >>>
> >>>
> >>> On 2021-10-13 00:14, Lazar, Lijo wrote:
> >>>> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
> >>>>> Some ASIC support low-power functionality for the whole ASIC or jus=
t
> >>>>> an IP block. When in such low-power mode, some sysfs interfaces wou=
ld
> >>>>> report a frequency of 0, e.g.,
> >>>>>
> >>>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> >>>>> 0: 500Mhz
> >>>>> 1: 0Mhz *
> >>>>> 2: 2200Mhz
> >>>>> $_
> >>>>>
> >>>>> An operating frequency of 0 MHz doesn't make sense, and this interf=
ace
> >>>>> is designed to report only operating clock frequencies, i.e. non-ze=
ro,
> >>>>> and possibly the current one.
> >>>>>
> >>>>> When in this low-power state, round to the smallest
> >>>>> operating frequency, for this interface, as follows,
> >>>>>
> >>>> Would rather avoid this -
> >>>>
> >>>> 1) It is manipulating FW reported value. If at all there is an uncau=
ght
> >>>> issue in FW reporting of frequency values, that is masked here.
> >>>> 2) Otherwise, if 0MHz is described as GFX power gated case, this
> >>>> provides a convenient interface to check if GFX is power gated.
> >>>>
> >>>> If seeing a '0' is not pleasing, consider changing to something like
> >>>>         "NA" - not available (frequency cannot be fetched at the mom=
ent).
> >>> There's a ROCm tool which literally asserts if the values are not ord=
ered in increasing order. Now since 0 < 550, but 0 is listed as the second =
entry, the tool simply asserts and crashes.
> >>>
> >>> It is not clear what you'd rather see here:
> >>>
> >>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> >>> 0: 550Mhz
> >>> 1: N/A *
> >>> 2: 2200MHz
> >>> $_
> >>>
> >>> Is this what you want to see? (That'll crash other tools which expect=
 %uMhz.)
> >>>
> >>> Or maybe just a list without default hint, i.e. no asterisk?
> >>>
> >>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> >>> 0: 550Mhz
> >>> 1: 2200MHz
> >>> $_
> >>>
> >>> What should the output be?
> >>>
> >>> We want to avoid showing 0, but still show numbers.
> >>>
> >>> Regards,
> >>> Luben
> >>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> >>>>> 0: 500Mhz *
> >>>>> 1: 2200Mhz
> >>>>> $_
> >>>>>
> >>>>> Luben Tuikov (5):
> >>>>>     drm/amd/pm: Slight function rename
> >>>>>     drm/amd/pm: Rename cur_value to curr_value
> >>>>>     drm/amd/pm: Rename freq_values --> freq_value
> >>>>>     dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
> >>>>>     dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
> >>>>>
> >>>>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++----=
--
> >>>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-=
------
> >>>>>    2 files changed, 86 insertions(+), 47 deletions(-)
> >>>>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >
