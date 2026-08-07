Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EDCC5ACC2
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D4510F50C;
	Fri,  7 Aug 2026 14:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WUk4sCDf";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF1010F50C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 14:38:05 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so498408a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 07:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113485; cv=none;
 d=google.com; s=arc-20260327;
 b=nzbot9NXlROaOrnUtrqs+IshwmzO4WKtf2m1mnJj236FThti1gpegqsva+r11+1lT1
 bCl0/Ea9NrT0PXLEK747utsxgZuGlurrdCXgSABnAGxlKVqyqUXITA+DPOqu95kVcsC1
 6BMavj5FrdABdmKiTXaMY2OsmZTrh7k+79Q+4+tlxiPqzFt6WGAkgRaqx6dZDZeA9Tts
 cIalZg9gZZ9h/CkziGL/TjHg4KTMEhlTS9KBD7daa+ZzENPGNe48nKbmbWPeXtyb3R7G
 8P/wlNBupGzJrbxl7Io15jHIDYs9ddV24YU/tsLVuiT2lFYkg+DxFDE6DAMeVCbmGOEE
 zA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7AnXLE+E56JyXo03cuubL4fGOZKjBewfQLzkSoI1veE=;
 fh=W4urHV6Jxzgzzxw2YDhJT/SpG6V6wMzjpVvif4ofd8U=;
 b=Vlm5ihnHPmr2vZoOITlY7029pE/WWerWMibyKLZZ+Z+0dzH5u+m1L45XhyZSTDs9DF
 P9NQMT+kF5pHVCYdXiwMAEHxOkxwWJuCxK8dPKQIhVjbq8tI0oqohX6KCljGlmYjd2+q
 yVnf+6xiWNm20bV0wrulTfOH7R0qn2CJleh1x56yJmrqewVu5pzzR17OV0Bkt3jgmyxR
 AFxetEdS34XpwRKIXnNo9EunrmjFqOAIEp63Z4OhYb2fDnR5wMPJ6pEwUkzFBHzBB6vl
 PSvFsnlP9XoPqmE+R1+WxKN+UsX5Bu+MtaznFAFrLEd2ujDufDNq6WMz1v4TGgO60t6L
 NTDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786113485; x=1786718285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7AnXLE+E56JyXo03cuubL4fGOZKjBewfQLzkSoI1veE=;
 b=WUk4sCDf9x1VZIEy8W/9HnP2E4Twotx7EAnggA4RrVRt3Br0TSaJ34/2IfqGuhXiSM
 snd4eqvIq1ningYB2wMUmGAmca3tZuYioqueUwr18GOVMThymYllHlKamDpoLoMixKE1
 BKb+NfuIP6y/oqV1/PbiSRs8kZfox47R8CiL1A2kxqHFMZIMOEqm85CYYxkR6rACrK7d
 6nSmg7VdDd4ytNXouzvdeepzWwLgw39gU/xJZEzYprfP3E5AzAqMq/hhYd24RPplMWAg
 dXrWACSPrIWJynIQC8vyPMRDSbeV+egX+APWi/Atwo0414fhN8APg3udIs1iLe/VRVKA
 H75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786113485; x=1786718285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7AnXLE+E56JyXo03cuubL4fGOZKjBewfQLzkSoI1veE=;
 b=ghOGyJS5OLmCcRe8Qf0xqNLDK9W5GxU4sP6l5H2Jf3yywXS8fl4rK7T7/iwM46SdbB
 ToYpQUXwJucaBe5kIyzxEC5rlhNBLknmMcpvAk0SfzOlNWdksLyM2nuTSR1c+CiKCXBs
 C5GJQ6NkzBcYGKRbjcNMNJAnyKgN3lHZ2PJ1GDkHDd6hVw1u8KdlxyJki4urUyY3VjYe
 PrW47dqLdFdYd+hQFuiMkdiCuFBYdlE/NRXv8clMfCEG1L4l7MDim8JwNLGY/hHeOrLt
 Vb11cu9M4XeRyj/JStfruvUVDU5/ZGcYoN956dDJeo38x69Y12Kcm8Cc5yY7S5rvHtx6
 pJww==
X-Gm-Message-State: AOJu0YwSiqjsPIgvL8n6cIliA7sKFdZUjpucjEVNk1s7p2mgJDNXFJq8
 +zIRFnuDwIoNaJMxEeeNaZS6RATDAk7qh/KtemXkEnLMUOmZArEokfCtX+IyVgx7ANiPEOO9fBY
 Fv06dEEbc+izCgIb6e0r0Z/4a2dryy/s=
X-Gm-Gg: AR+sD12JNG5otnBGqC9f7Pmr49O1Y3LrK09FwH4m1Fct8kMv0m6Uq7AibowVKTauUP2
 6gmupPMb03HRMk1rVy2Ts5NOY4LBkielaI11wYahQByvvoVC96dW9AKJV2kdIENvNDqZQFHTYpt
 UZaaRMreVr4t+CE/pn5BFzb5IdSfeMzGsMsCaZaDQT4aKpCdqUds9jPKmHra7a4xPmXOR2E8W6/
 0kIeqsEvdI9Z2EtxlVoJF99V4RLTPEy7bUt8WeEOWd1FCnRV2/8TP26ivmNgpdKm5GXejANJMKQ
 QYG7VFVESCdGLj5bi/l/lzbSi/uPD3DL8AJkyMS5ZJXPasrqpzk0GRzuUWzohik79tvAneLG/R6
 ukFRgpTstQpwHnaznwa9fe6udFgUDHF+4JCBdzhxypg==
X-Received: by 2002:a17:90b:4410:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3903c5bff9dmr15541882a91.1.1786113484923; Fri, 07 Aug 2026
 07:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
 <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
 <DS7PR12MB6005E76101209F514B1544D9FBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PL1ECn9BHex4czV=35+ZkTmPrpQHbVOFg_ZQK7t1HygA@mail.gmail.com>
 <DS7PR12MB60058ABC1D885DF414416607FBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_ONP+D7kSJEb0B0d3q8CaJGL4PTV7jfq+=j+dd_Tj0+Ow@mail.gmail.com>
 <PH7PR12MB600029F6BFBAD2FE80A1841DFBD12@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_NtQF7eU0iZv5786gVPUJ+U8daOBrqP0snAUpknKogMgQ@mail.gmail.com>
 <PH7PR12MB6000775677CD969B8AE74AB7FBD12@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000775677CD969B8AE74AB7FBD12@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Aug 2026 10:37:53 -0400
X-Gm-Features: AUfX_myhqbaIYMq3O3xVjSAaPoepzLdpcR7ODnSnxCE8GGHozo7bFflZWptKVeA
Message-ID: <CADnq5_NBuTYNc=XgJztJZCY6ZU6w4g_Cu51dmK+1AV1nFA3xiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq reset
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Fri, Aug 7, 2026 at 10:11=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, August 7, 2026 9:47 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om>;
> > Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute use=
rq reset
> >
> > On Fri, Aug 7, 2026 at 9:39=E2=80=AFAM Liang, Prike <Prike.Liang@amd.co=
m> wrote:
> > >
> > > AMD General
> > >
> > >
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Tuesday, August 4, 2026 10:18 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher,
> > > > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute
> > > > userq reset
> > > >
> > > > On Tue, Aug 4, 2026 at 4:16=E2=80=AFAM Liang, Prike <Prike.Liang@am=
d.com> wrote:
> > > > >
> > > > > AMD General
> > > > >
> > > > > Regards,
> > > > >       Prike
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > Sent: Monday, August 3, 2026 9:40 PM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> > > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > compute userq reset
> > > > > >
> > > > > > On Mon, Aug 3, 2026 at 9:36=E2=80=AFAM Liang, Prike <Prike.Lian=
g@amd.com>
> > wrote:
> > > > > > >
> > > > > > > AMD General
> > > > > > >
> > > > > > > Regards,
> > > > > > >       Prike
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > > > Sent: Monday, August 3, 2026 9:23 PM
> > > > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> > > > > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > > > compute userq reset
> > > > > > > >
> > > > > > > > On Mon, Aug 3, 2026 at 5:25=E2=80=AFAM Liang, Prike
> > > > > > > > <Prike.Liang@amd.com>
> > > > wrote:
> > > > > > > > >
> > > > > > > > > AMD General
> > > > > > > > >
> > > > > > > > > As for the hung userq, it should be identified by the MES
> > > > > > > > > reset API with the
> > > > > > > > hang_detect_only setting. However, it is unlikely to miss
> > > > > > > > detecting the invalid opcode hang case, especially given
> > > > > > > > that the userq invalid opcode IGT test has not been impleme=
nted yet.
> > > > > > > > >
> > > > > > > > > Hi @Liu, Shaoyun, are you aware of any known userq hang
> > > > > > > > > scenarios that cannot
> > > > > > > > be identified by MES API hang_detect_only? If not, could yo=
u
> > > > > > > > please help review the following patch, which unifies the
> > > > > > > > userq reset path for hung
> > > > > > queues?
> > > > > > > > >
> > > > > > > >
> > > > > > > > We added it in the first place to deal with those cases.
> > > > > > > > There can be queues which are not hung, but will never
> > > > > > > > complete and hence never signal their fence.  E.g., you can
> > > > > > > > have a queue that is waiting on a memory location that MES
> > > > > > > > can preempt, but due to a bug elsewhere that memory locatio=
n
> > > > > > > > will never change so the fence will
> > > > never signal.
> > > > > > >
> > > > > > > Thank you for the input. However, for fake timeout cases such
> > > > > > > as the long shader
> > > > > > scenario, we should identify the fake hang cases by checking
> > > > > > whether the guilty queue appears in the hang list, or whether
> > > > > > the queue rptr is still updating? If so, preempt the queue rath=
er than resetting
> > it?
> > > > > > >
> > > > > >
> > > > > > We have to assume that if we end up in the queue reset path tha=
t
> > > > > > the queue is
> > > > hung.
> > > > > > The fences have to signal in finite time.  If we preempt the
> > > > > > queue that won't signal the fence so we'll just end up in the
> > > > > > queue reset path again.  Preemption of a queue that won't make
> > > > > > progress only makes sense
> > > > if fences are not involved.
> > > > >
> > > > > The most cases relevant to userq fence timeout and reset worker
> > > > > likely to be
> > > > scheduled when a userq fence polling period expires. If a long
> > > > running shader is detected, the driver may need to try preempting t=
he queue
> > within a few retry cycles.
> > > > If the userq fence remains unsignaled after the retries are
> > > > exhausted, the driver can either return -ETIME to userspace for
> > > > further handling or fall back to resetting the queue directly.
> > > > Meanwhile, If the preemption succeeds and the queue completes its
> > > > work during the subsequent restore process, no further reset is nec=
essary for the
> > guilty queue?
> > > > >
> > > >
> > > > If an application wants to run long running jobs they shouldn't use
> > > > protected fences in the first place.  If they don't use protected
> > > > fences, then it should behave like KFD queues.  If there is some
> > > > operation that needs to happen the queues will get preempted and
> > > > then will continue later.  DMA fences need to signal in finite time
> > > > so we can't just keep pushing them off.  Other kernel paging operat=
ions may
> > depend on them signalling.
> > >
> > > Regarding the protected fences, do you mean the userq fence that trig=
gers the
> > hang detection work queue?
> > >
> >
> > Yes.
> >
> > > If so, the current implementation calls amdgpu_userq_fence_init() at =
fence emit
> > time (i.e., at each queue submission), which both initializes the dma_f=
ence structure
> > and starts the hang detection timer for that submission. Once the timeo=
ut expires,
> > amdgpu_userq_hang_detect_work() fires and triggers a queue reset regard=
less of
> > whether the queue is actually hung or simply long-running. But there's =
a core
> > problem for the kernel to distinguish a hung queue from a slow one at f=
ence emit
> > time, since both look identical an unsignaled fence with an active queu=
e.
> > >
> >
> > That is the intended behavior. If you opt into using a dma fence, you n=
eed to abide
> > by its semantics.
> >
> > > However, we can defer that determination to the first timeout expiry =
in
> > amdgpu_userq_hang_detect_work(). At that point we have more information=
 to work
> > with:
> > >
> > >
> > > Check for real hang: query rptr and rptr has not updated since the fe=
nce was
> > emitted, the queue is genuinely stuck (frozen waves, infinite loop). Th=
is is a real
> > hang, reset immediately and forcing completing the fences.
> > > Check for forward progress: if rptr has updated but the fence is stil=
l unsignaled, the
> > queue is making progress, so it is long running, not hung. In this case=
:
> > >
> > > Extend the timeout (reschedule hang_detect_work with a longer
> > > interval) Track retry count if the queue still has not completed afte=
r N extended
> > cycles, escalate: Preempt the queue, force completing the fence and ret=
urn -ETIME
> > to userspace then let the application decide: resubmit, split the workl=
oad, or drop.
> > >
> > > Avoid unnecessary resets: if preemption succeeds and the queue resume=
s and
> > completes within the extended window, cancel the reset entirely since t=
he queue
> > was slow, not broken.
> > >
> > >
> > > Do you think this is the right way for handling long-running tasks to=
 resolve the
> > userq timeout issue, or does it align with your idea?
> >
> > If you want to run a super long running job, then you shouldn't use a d=
ma fence in
> > the first place.  There might be a job that takes 2 minutes or even an =
hour to run, but
> > you can't wait that long for a dma fence.  If you do, the kernel might =
run out of
> > memory and the OOM killer will start killing processes or you could dea=
dlock.  If you
> > want to run a long job, don't use a dma fence.  If you don't use a dma =
fence, then the
> > kernel can preempt the queues, do whatever memory management it needs t=
o and
> > then it can resume the queues.  dma fences have to signal in finite tim=
e.
>
> Got it. So to skip attaching a dma_fence to a long-running submission, do=
es this require an explicit flag from userspace at queue creation, or is th=
ere another mechanism to identify it on the kernel side?
>

Userspace would simply not call the userq signal IOCTL if they want to
run long running jobs.

Alex

> Thanks,
> Prike
> > Alex
> >
> > >
> > > Thanks,
> > > Prike
> > >
> > > Avoid unnecessary resets: if preemption succeeds and the queue resume=
s
> > > and completes within the extended window, cancel the reset entirely =
=E2=80=94
> > > the queue was slow, not broken.>
> > > > Alex
> > > >
> > > > > In the longer term, we may need to introduce a more robust
> > > > > mechanism to
> > > > distinguish slow queue cases from genuine hangs, handling them
> > > > appropriately via extending time slice for completing the queue
> > > > submission, userspace driven resubmission, or dropping the work
> > > > through a queue reset. If it makes sense and right way to do, then =
I
> > > > will work on implementing the solution for such slow/long queue cas=
es.
> > > > >
> > > > > Thanks,
> > > > > Prike
> > > > >
> > > > > > Alex
> > > > > >
> > > > > > > >
> > > > > > > > Alex
> > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > >       Prike
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Liang, Prike
> > > > > > > > > > Sent: Thursday, July 23, 2026 2:38 PM
> > > > > > > > > > To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > > > > > <Jesse.Zhang@amd.com>
> > > > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > > > > > > > Koenig, Christian <Christian.Koenig@amd.com>
> > > > > > > > > > Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate
> > > > > > > > > > guilty compute userq reset
> > > > > > > > > >
> > > > > > > > > > I checked each different userq hang cases, and the
> > > > > > > > > > guilty userq can be identified by the MES firmware and =
report
> > correctly.
> > > > > > > > > > @Zhang,
> > > > > > > > > > Jesse(Jie) could you further check as well at you side?
> > > > > > > > > >
> > > > > > > > > > If there're some hang queues miss identified by MES
> > > > > > > > > > firmware, then the correct thing is to further debug
> > > > > > > > > > from MES firmware side rather than have such strange
> > > > > > > > > > reset sequence and this reset workaround should be
> > > > > > > > cleaned sooner or later.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > >       Prike
> > > > > > > > > >
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > > > > > Sent: Wednesday, July 15, 2026 2:31 PM
> > > > > > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > > > > > > > > Koenig, Christian <Christian.Koenig@amd.com>; Liang,
> > > > > > > > > > > Prike <Prike.Liang@amd.com>
> > > > > > > > > > > Subject: [PATCH 1/2] drm/amdgpu: Remove separate
> > > > > > > > > > > guilty compute userq reset
> > > > > > > > > > >
> > > > > > > > > > > amdgpu_mes_detect_and_reset_hung_queues() already
> > > > > > > > > > > detects the guilty compute user queue and resets it
> > > > > > > > > > > through mes_userq_reset_queue(). The additional reset
> > > > > > > > > > > via
> > > > > > > > > > > mes_userq_reset() is unnecessary, so remove it to
> > > > > > > > > > > unify the compute userq
> > > > > > > > reset.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
> > > > > > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
> > > > > > > > > > >  2 files changed, 7 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > @@ -2315,11 +2315,6 @@ int
> > > > > > > > > > > amdgpu_gfx_reset_mes_compute(struct
> > > > > > > > > > > amdgpu_device *adev,
> > > > > > > > > > >             deferred_end[n_deferred].fence =3D guilty=
_fence;
> > > > > > > > > > >             n_deferred++;
> > > > > > > > > > >     }
> > > > > > > > > > > -   if (uq) {
> > > > > > > > > > > -           r =3D mes_userq_reset(uq);
> > > > > > > > > > > -           if (r)
> > > > > > > > > > > -                   goto out;
> > > > > > > > > > > -   }
> > > > > > > > > > >     for (i =3D 0; i < num_hung; i++) {
> > > > > > > > > > >             struct amdgpu_ring *hr =3D NULL;
> > > > > > > > > > >             struct amdgpu_fence *hf =3D NULL; diff --=
git
> > > > > > > > > > > a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > index b6bfa3974839..fab21d4275f3 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct
> > > > > > > > > > > amdgpu_device *adev,
> > > > > > > > > > >
> > > > > > > > > > >     xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) =
{
> > > > > > > > > > >             if (uq->queue_type =3D=3D queue_type) {
> > > > > > > > > > > -                   if (uq =3D=3D guilty_uq)
> > > > > > > > > > > -                           continue;
> > > > > > > > > > >                     if (uq->doorbell_index =3D=3D db)=
 {
> > > > > > > > > > >                             uq->state =3D AMDGPU_USER=
Q_STATE_HUNG;
> > > > > > > > > > >                             if (use_mmio)
> > > > > > > > > > > --
> > > > > > > > > > > 2.34.1
> > > > > > > > >
