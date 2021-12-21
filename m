Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C973C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 22:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3183710E273;
	Tue, 21 Dec 2021 22:19:09 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493B710E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 22:19:08 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso262231otj.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jBzs35093DbXqK8zWbgGQIma92n1ky9DMRARM0To2zU=;
 b=IhsSNn/focP3sjfGY3mtHEh7rfjKTNQpeVTb24szryxV8Lj/+QWwX5FUFbTAdXIRV2
 bCsIpJnxBuTB+rP+fvXZ0+n7Ig86KkptOTq2+NDdDvT3PMiTckHwyOlWuhnmrtRGA0qh
 Nsyu7pUMAx2RkMq0FPvV7rEQIEgjoHYuxUFm2qpZ4lcCe7jXl8tl/dR0UP2xnLW9tdy4
 2Xb1mUQ3/NKghu6W9a2HQakuusdzpjVUcZCDD9Z0YkAVbReOgrgZ0IN4a771WMTxnjH3
 S86/XjxgssVAGy4npEpISBkjSwP8TEzOJPZVnlPVefDK+wqnVIiAB6oKfCF4KJ/RgNA7
 xFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jBzs35093DbXqK8zWbgGQIma92n1ky9DMRARM0To2zU=;
 b=K0QU+0nP5IUBjk8WOfKxVVsvFEo9mlt3/A/39hgYix6XPAoORpmzVzEFSXHd05AeFm
 JyJ7i2RpoCZ3bwEGA/hVD0Cs2cntz0takgf0SkSji69DX92PA+bI6UkeEoU+84bZpTqE
 tEgF6PY1UeR8wGatz9iZ2rZpRI+VZAfKGqwGlhEBqloJ8RJ+OsSEh0+5FGM4/Va61be0
 snXfc06Sp8ObO6VvpW/Xd3UrWqBTvpKlxbK4szjt2ZGgKbOoxrODHBZ6wYxDudMz3IqO
 aAe6aZcTPCOZrVqh9ZNQAIkLg00li4sO2bql6I2N8Gl3pqxhKrkQQaAd8MgO1xkGKIHV
 US7A==
X-Gm-Message-State: AOAM5302DxXGGM0bjJuBLPn54OH5C7ttjjaZf9mV9UivHnKbIwnbyMAF
 42XDjc26Jqp6LCwH5taPNxB4M2vzYj3VWheQvRM=
X-Google-Smtp-Source: ABdhPJxWBN/hcIthkoRzYtLwQA7SdAriI9w+ee/gm1InGAaO43/iWAt54fVqesYcyHeglaPvoTRKjESAwKo9KOD0C8Q=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr251778oto.357.1640125147587; 
 Tue, 21 Dec 2021 14:19:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
 <BL1PR12MB514437F7B1726A2173650FBFF77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB5144E1E5C51C5B5226197978F77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CADnq5_Pio64msSwvDXL6Ocm6Ty5B2VVf+v+7f+Dz2EJ_-J7VzQ@mail.gmail.com>
 <32ca7ff8-b5d3-23e5-7821-e429baa4c5aa@amd.com>
In-Reply-To: <32ca7ff8-b5d3-23e5-7821-e429baa4c5aa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Dec 2021 17:18:56 -0500
Message-ID: <CADnq5_Mj8A4sUc4Gg11zJrWZsKvkv=F32Vu59RhC9BYR=nObYg@mail.gmail.com>
Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Imre Deak <imre.deak@intel.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 21, 2021 at 5:09 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
>
>
> On 2021-12-21 16:18, Alex Deucher wrote:
> > On Tue, Dec 21, 2021 at 1:47 PM Deucher, Alexander
> > <Alexander.Deucher@amd.com> wrote:
> >>
> >> [Public]
> >>
> >>> -----Original Message-----
> >>> From: Deucher, Alexander
> >>> Sent: Tuesday, December 21, 2021 12:01 PM
> >>> To: Linus Torvalds <torvalds@linux-foundation.org>; Imre Deak
> >>> <imre.deak@intel.com>; amd-gfx@lists.freedesktop.org
> >>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>; Kai-Heng Feng
> >>> <kai.heng.feng@canonical.com>
> >>> Subject: RE: Expecting to revert commit 55285e21f045 "fbdev/efifb: Re=
lease
> >>> PCI device ..."
> >>>
> >>> [Public]
> >>>
> >>>> -----Original Message-----
> >>>> From: Linus Torvalds <torvalds@linux-foundation.org>
> >>>> Sent: Monday, December 20, 2021 5:05 PM
> >>>> To: Imre Deak <imre.deak@intel.com>
> >>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>; Deucher, Alexander
> >>>> <Alexander.Deucher@amd.com>; Kai-Heng Feng
> >>>> <kai.heng.feng@canonical.com>
> >>>> Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb:
> >>>> Release PCI device ..."
> >>>>
> >>>> On Mon, Dec 20, 2021 at 1:33 PM Imre Deak <imre.deak@intel.com>
> >>> wrote:
> >>>>>
> >>>>> amdgpu.runpm=3D0
> >>>>
> >>>> Hmmm.
> >>>>
> >>>> This does seem to "work", but not very well.
> >>>>
> >>>> With this, what seems to happen is odd: I lock the screen, wait, it
> >>>> goes "No signal, shutting down", but then doesn't actually shut down
> >>>> but stays black (with the backlight on). After _another_ five second=
s
> >>>> or so, the monitor goes "No signal, shutting down" _again_, and at t=
hat
> >>> point it actually does it.
> >>>>
> >>>> So it solves my immediate problem - in that yes, the backlight final=
ly
> >>>> does turn off in the end - but it does seem to be still broken.
> >>>>
> >>>> I'm very surprised if no AMD drm developers can see this exact same =
thing.
> >>>> This is a very simple setup. The only possibly slightly less common
> >>>> thing is that I have two monitors, but while that is not necessarily
> >>>> the _most_ common setup in an absolute sense, I'd expect it to be ve=
ry
> >>>> common among DRM developers..
> >>>>
> >>>> I guess I can just change the revert to just a
> >>>>
> >>>>     -int amdgpu_runtime_pm =3D -1;
> >>>>     +int amdgpu_runtime_pm =3D 0;
> >>>>
> >>>> instead. The auto-detect is apparently broken. Maybe it should only
> >>>> kick in for LVDS screens on actual laptops?
> >>>>
> >>>> Note: on my machine, I get that
> >>>>
> >>>>    amdgpu 0000:49:00.0: amdgpu: Using BACO for runtime pm
> >>>>
> >>>> so maybe the other possible runtime pm models (ARPX and BOCO) are ok=
,
> >>>> and it's only that BACO case that is broken.
> >>>>
> >>>> I have no idea what any of those three things are - I'm just looking
> >>>> at the uses of that amdgpu_runtime_pm variable.
> >>>>
> >>>> amdgpu people: if you don't want that amdgpu_runtime_pm turned off b=
y
> >>>> default, tell me something else to try.
> >>>
> >>> For a little background, runtime PM support was added about 10 year a=
go
> >>> originally to support laptops with multiple GPUs (integrated and disc=
rete).
> >>> It's not specific to the display hardware.  When the GPU is idle, it =
can be
> >>> powered down completely.  In the case of these laptops, it's D3 cold
> >>> (managed by ACPI, we call this BOCO in AMD parlance - Bus Off, Chip O=
ff)
> >>> which powers off the dGPU completely (i.e., it disappears from the bu=
s).  A
> >>> few years ago we extended this to support desktop dGPUs as well which
> >>> support their own version of runtime D3 (called BACO in AMD parlance =
- Bus
> >>> Active, Chip Off).  The driver can put the chip into a low power stat=
e where
> >>> everything except the bus interface is powered down (to avoid the dev=
ice
> >>> disappearing from the bus).  So this has worked for almost 2 years no=
w on
> >>> BACO capable parts and for a decade or more on BOCO systems.
> >>> Unfortunately, changing the default runpm parameter setting would cau=
se a
> >>> flood of bug reports about runtime power management breaking and
> >>> suddenly systems are using more power.
> >>>
> >>> Imre's commit (55285e21f045) fixes another commit (a6c0fd3d5a8b).
> >>> Runtime pm was working on amdgpu prior to that commit.  Is it possibl=
e
> >>> there is still some race between when amdgpu takes over from efifb?  =
Does
> >>> it work properly when all pm_runtime calls in efifb are removed or if=
 efifb is
> >>> not enabled?  Runtime pm for Polaris boards has been enabled by defau=
lt
> >>> since 4fdda2e66de0b which predates both of those patches.
> >>
> >> Thinking about this more, I wonder if there was some change in some us=
erspace component which was hidden by the changes in 55285e21f045 and a6c0f=
d3d5a8b.  E.g., some desktop component started polling for display changes =
or GPU temperature or something like that and when a6c0fd3d5a8b was in plac=
e the GPU never entered runtime suspend.  Then when 55285e21f045 was applie=
d, it unmasked the new behavior in the userpace component.
> >>
> >> What should happen is that when all of the displays blank, assuming th=
e GPU is otherwise idle, the GPU will runtime suspend after  seconds.  When=
 you move the mouse or hit the keyboard, that should trigger the GPU should=
 runtime resume and then the displays will be re-enabled.
> >>
> >> In the behavior you are seeing, when the displays come back on after t=
hey blank are you seeing the device resume from runtime suspend?  On resume=
 from suspend (runtime or system) we issue a hotplug notification to usersp=
ace in case any displays changed during suspend when the GPU was powered do=
wn (and hence could not detect a hotplug event).  Perhaps that event is tri=
ggering userspace to reprobe and re-enable the displays shortly after resum=
e from runtime suspend due to some other event that caused the device to ru=
ntime resume.  Does something like this help by any chance?
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu=
gzilla.kernel.org%2Fattachment.cgi%3Fid%3D300103%26action%3Ddiff%26collapse=
d%3D%26headers%3D1%26format%3Draw&amp;data=3D04%7C01%7CHarry.Wentland%40amd=
.com%7Cd1d2f9528d8e42199af508d9c4c7793d%7C3dd8961fe4884e608e11a82d994e183d%=
7C0%7C0%7C637757183279389936%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DKdIAXxYP0oQ=
pNCFCe1slYwqgDhRdse2CrkGuCc2KrAE%3D&amp;reserved=3D0
> >
> > I'm not seeing this on my system, and another user tried the patch and
> > it fixed his system, so it indeed seems to be something along the
> > lines of what I described above.  Something in userspace seems to be
> > accessing the GPU causing it to runtime resume.  On resume the driver
> > then sends a hotplug event to userspace (in case anything display
> > related changed while the GPU was suspended).  The desktop manager
> > then sees the hotplug event and reprobes and lights up the displays
> > again.  @Wentland, Harry, I guess the display code may already handle
> > this (seeing if anything has changed on resume since suspend), so we
> > can probably drop the call from the generic amdgpu resume code?  Or if
> > not, it should be pretty straightforward to fix that in
> > dm_suspend()/dm_resume().
> >
>
> We handle re-detection in dm_resume but only seem to call the
> drm_kms_helper_hotplug_event for MST. We might want to call it
> in dm_resume but that would just move it from amdgpu_device_resume
> and will probably cause the same issue.
>
> What I think we'd really want here is to make sure
> drm_kms_helper_hotplug_event is only called when any display
> config actually changes. Unfortunately, we're not being very
> smart in our detection and just recreate everything (even
> though dc_link_detect_helper seems to have code that wants to
> be smart enough to detect if the sink is changed or not).
> This means this change is non-trivial. At least I can't see
> an easy fix that doesn't run the risk of breaking a bunch of
> stuff.

I think something like this patch may do the trick:
https://bugzilla.kernel.org/attachment.cgi?id=3D300109&action=3Ddiff&collap=
sed=3D&headers=3D1&format=3Draw
We can use the helper to check if anything actually changed.

Alex

>
> Or maybe someone can try to see if (non-MST) detection during
> RPM still works with your patch. If it does (for some reason)
> then we should be good.
>
> I can't seem to repro the problem on my Navi 1x card with KDE Plasma.
> I wonder if it's a Polaris issue.
>
> I also don't see my Navi 1x card going into RPM after
> 'xset dpms force off' with the Manjaro 5.15 kernel. Might need
> to try the latest mainline or amd-stg.
>
> Harry
>
>
> > Alex
