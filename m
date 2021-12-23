Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE76FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 04:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DEBC10E271;
	Thu, 23 Dec 2021 04:07:22 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD2210E271
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 04:07:21 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 45-20020a9d0a30000000b0058f1a6df088so5409588otg.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5ybcWOCSQ8S2/rG9CG1tImB2MLhhQW4gg2Qo5Sh9h0o=;
 b=hStwB31uvP/xPAWdMnE3iXpBSPdjR5OWqbjMjerenDSNGvbpUoJj4GFTWKXt0v5Yfu
 cW3fInzbw7r4Q3VSi4ynRmEPsrbXtUQJM2hS4/uFd7jU5QeWiZfhhGuJXiUjDoNAMC8o
 a9rcGhZZIlwpyT8BSe2ZVGRhcGohAqM1TFPKzqRGuw4+Ezh9arpqPyWKSyxFaFZo5pf3
 26Y6qnRJ4qBy5I5RB5O1LQC+h897KbLBQHcQXpVFlFbbm6vFXf3Cx1juTNSvmdMY51Yv
 IoXO8q7/YZSGG0cSrjxdlajJKC6R9xsno3QtPxd6q3uwFEMw/Am9MJ8IhizLRFveoXqa
 Nzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5ybcWOCSQ8S2/rG9CG1tImB2MLhhQW4gg2Qo5Sh9h0o=;
 b=BL+k9TCpBTF72OjtmX99n0I3tfMTqZ2KQONXzoFdBhjivg4x1PdBv1uGElmvohKT2e
 Tf4FNAjz5ByXGlD4lrmGv6PgtAZMtgWpE82faP1ubczfRfy9gjh9nzU95lJwmrylIzn/
 9aHV88sex3cwvCuq73cl4+DvzyU9nm5K1y0oflag3u6bWK/m7TStpUtW1bgm+PyV3hoy
 kzSaR8p9za0c24LtzbhrbhdfcCDt8fccxhXP3aCxPPZceev2QI1rHi/pwPpkU6qjFjJP
 1/tdXYx2iniswNTwdOH4WgXovo1hwR2mLUVy6KIDUZ736kvpxResi+l/RvR9IX7sKgod
 iIoQ==
X-Gm-Message-State: AOAM531hsbzVNtj6jh+mmCR0wb/63ClLuZaf+UHTQFnF2hhmzzlWllPJ
 vZEunyKWyDtvOntxiA53NfkU60tvtzy7oGwIuPs=
X-Google-Smtp-Source: ABdhPJwKzEuVqxHjMFsZILHF6+0HGuX0Ync/sKn59qeoc0sICG0WesjfTWQ8OERexzFBd0N9TZKMs9gdWKvO2KxMSzo=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr374925otn.299.1640232440937;
 Wed, 22 Dec 2021 20:07:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
 <BL1PR12MB514437F7B1726A2173650FBFF77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB5144E1E5C51C5B5226197978F77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144E1E5C51C5B5226197978F77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Dec 2021 23:07:10 -0500
Message-ID: <CADnq5_NDiV+k8xmQt2zxYRjhd1_8NDBZxdSuZ__65U0=+MXN=Q@mail.gmail.com>
Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
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
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 21, 2021 at 1:47 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Deucher, Alexander
> > Sent: Tuesday, December 21, 2021 12:01 PM
> > To: Linus Torvalds <torvalds@linux-foundation.org>; Imre Deak
> > <imre.deak@intel.com>; amd-gfx@lists.freedesktop.org
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>; Kai-Heng Feng
> > <kai.heng.feng@canonical.com>
> > Subject: RE: Expecting to revert commit 55285e21f045 "fbdev/efifb: Rele=
ase
> > PCI device ..."
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > > Sent: Monday, December 20, 2021 5:05 PM
> > > To: Imre Deak <imre.deak@intel.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Kai-Heng Feng
> > > <kai.heng.feng@canonical.com>
> > > Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb:
> > > Release PCI device ..."
> > >
> > > On Mon, Dec 20, 2021 at 1:33 PM Imre Deak <imre.deak@intel.com>
> > wrote:
> > > >
> > > > amdgpu.runpm=3D0
> > >
> > > Hmmm.
> > >
> > > This does seem to "work", but not very well.
> > >
> > > With this, what seems to happen is odd: I lock the screen, wait, it
> > > goes "No signal, shutting down", but then doesn't actually shut down
> > > but stays black (with the backlight on). After _another_ five seconds
> > > or so, the monitor goes "No signal, shutting down" _again_, and at th=
at
> > point it actually does it.
> > >
> > > So it solves my immediate problem - in that yes, the backlight finall=
y
> > > does turn off in the end - but it does seem to be still broken.
> > >
> > > I'm very surprised if no AMD drm developers can see this exact same t=
hing.
> > > This is a very simple setup. The only possibly slightly less common
> > > thing is that I have two monitors, but while that is not necessarily
> > > the _most_ common setup in an absolute sense, I'd expect it to be ver=
y
> > > common among DRM developers..
> > >
> > > I guess I can just change the revert to just a
> > >
> > >     -int amdgpu_runtime_pm =3D -1;
> > >     +int amdgpu_runtime_pm =3D 0;
> > >
> > > instead. The auto-detect is apparently broken. Maybe it should only
> > > kick in for LVDS screens on actual laptops?
> > >
> > > Note: on my machine, I get that
> > >
> > >    amdgpu 0000:49:00.0: amdgpu: Using BACO for runtime pm
> > >
> > > so maybe the other possible runtime pm models (ARPX and BOCO) are ok,
> > > and it's only that BACO case that is broken.
> > >
> > > I have no idea what any of those three things are - I'm just looking
> > > at the uses of that amdgpu_runtime_pm variable.
> > >
> > > amdgpu people: if you don't want that amdgpu_runtime_pm turned off by
> > > default, tell me something else to try.
> >
> > For a little background, runtime PM support was added about 10 year ago
> > originally to support laptops with multiple GPUs (integrated and discre=
te).
> > It's not specific to the display hardware.  When the GPU is idle, it ca=
n be
> > powered down completely.  In the case of these laptops, it's D3 cold
> > (managed by ACPI, we call this BOCO in AMD parlance - Bus Off, Chip Off=
)
> > which powers off the dGPU completely (i.e., it disappears from the bus)=
.  A
> > few years ago we extended this to support desktop dGPUs as well which
> > support their own version of runtime D3 (called BACO in AMD parlance - =
Bus
> > Active, Chip Off).  The driver can put the chip into a low power state =
where
> > everything except the bus interface is powered down (to avoid the devic=
e
> > disappearing from the bus).  So this has worked for almost 2 years now =
on
> > BACO capable parts and for a decade or more on BOCO systems.
> > Unfortunately, changing the default runpm parameter setting would cause=
 a
> > flood of bug reports about runtime power management breaking and
> > suddenly systems are using more power.
> >
> > Imre's commit (55285e21f045) fixes another commit (a6c0fd3d5a8b).
> > Runtime pm was working on amdgpu prior to that commit.  Is it possible
> > there is still some race between when amdgpu takes over from efifb?  Do=
es
> > it work properly when all pm_runtime calls in efifb are removed or if e=
fifb is
> > not enabled?  Runtime pm for Polaris boards has been enabled by default
> > since 4fdda2e66de0b which predates both of those patches.
>
> Thinking about this more, I wonder if there was some change in some users=
pace component which was hidden by the changes in 55285e21f045 and a6c0fd3d=
5a8b.  E.g., some desktop component started polling for display changes or =
GPU temperature or something like that and when a6c0fd3d5a8b was in place t=
he GPU never entered runtime suspend.  Then when 55285e21f045 was applied, =
it unmasked the new behavior in the userpace component.
>
> What should happen is that when all of the displays blank, assuming the G=
PU is otherwise idle, the GPU will runtime suspend after  seconds.  When yo=
u move the mouse or hit the keyboard, that should trigger the GPU should ru=
ntime resume and then the displays will be re-enabled.
>
> In the behavior you are seeing, when the displays come back on after they=
 blank are you seeing the device resume from runtime suspend?  On resume fr=
om suspend (runtime or system) we issue a hotplug notification to userspace=
 in case any displays changed during suspend when the GPU was powered down =
(and hence could not detect a hotplug event).  Perhaps that event is trigge=
ring userspace to reprobe and re-enable the displays shortly after resume f=
rom runtime suspend due to some other event that caused the device to runti=
me resume.  Does something like this help by any chance?
> https://bugzilla.kernel.org/attachment.cgi?id=3D300103&action=3Ddiff&coll=
apsed=3D&headers=3D1&format=3Draw

I've been working with the reporters of the following bug reports.
Probably best to follow the progress there:
https://bugzilla.kernel.org/show_bug.cgi?id=3D215203
https://gitlab.freedesktop.org/drm/amd/-/issues/1840

Alex
