Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCD9C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 13:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C2E10F4E5;
	Fri,  7 Aug 2026 13:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KFyuI/ye";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B6110F4E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 13:47:25 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so490948a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 06:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786110445; cv=none;
 d=google.com; s=arc-20260327;
 b=b9IFu3qfVifqthDJfhKgj3lNZAtK8MstNsqdQhwFgM8cCy3r/DiG9ig/I70NG42P1U
 Zhvg/qF7XEzXzHkewiS2TSz77MOsYQxcRKQ9b/voEkpORqyIzurrvSs0nZHcxRj2NIhy
 v+w8FBhpm576o50nmTYx17vzStTzAfa/QhDoj5eePgbwPpnHdzh4pnyqkXL7j95P1sYY
 AvefQ7ChjF7zh+Qz6YzNVi7NE7TT2j3FG/KFNpWqmMgEIdFWAriwthOzwQ1y0FqGqSr4
 0Pw1hWbluwftkPJhj0xEU1F3+UpnklC+tfT1dpB2jB9UBqTKGHy0I5xQCYYoP7oYmjd4
 YiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y2S4QJzvvAZTKGnYVbDiJWh512HDqpYEIcTnWiBtQkI=;
 fh=W4urHV6Jxzgzzxw2YDhJT/SpG6V6wMzjpVvif4ofd8U=;
 b=SZV0MsWi5/jfR3kZddHDUC/WO+8mgjfWqizcatj5BoimZSWb2e3b7nDcT0LVYzxXi8
 jbc+dxgRvj9olcwG3WN7T91bwKu/zHBg5jyXXEFLwYJzQCdq+NX/SLoIGTC4gusV/SOI
 3vGjGcLGxAbjD0TTKSINFCC5UDEadCGTbvbLCPfdoYD4RiQHBZxPBYCcby5IWR2zQ3i5
 rK+na1/xlzYn8PsE+G7YlyWzmHq2ziX+/gye2C8tnUeRWt44hUVgxeg8jRvZdOeSFsuO
 0Sf6CsoAXM3j4SDFH1GXm6F7hYroYnZRRjYBMMwJiw3ohlinOCvI4GR1C0OTmnGr0M8o
 EYIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786110445; x=1786715245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2S4QJzvvAZTKGnYVbDiJWh512HDqpYEIcTnWiBtQkI=;
 b=KFyuI/yeqyU3wLHtiDKGjBJU35YvkU+9cCYlYkwaJ7fuFmh/9F/S1woE31CGQkfiFZ
 gxertUq0xDw/6CZGVFQY3o0X5ZERt5KcWvZPt7EkCzbDN9fW2Aem5sl8VgYxiAKk0gEM
 qiOh3NmM8zpW8Xmnikr5A74t7o/UqBWyHHSChsaVG4a3lcKWl9SEmWN4zxVaf7TPzAAM
 IFC9ZvTi3lRzsavIElTzixZDgFGEUjy0egRgw4GK8/hHWpVbWV8atF17dn25FjmasTGS
 KlMxrxkKa16ZoDqtn2/T6mRl/Au/PHDUcnn9g5rBy5mfmufuk3+G5trCEDp31oY2HZBu
 D/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786110445; x=1786715245;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2S4QJzvvAZTKGnYVbDiJWh512HDqpYEIcTnWiBtQkI=;
 b=HwfYwgZUi1+WEywrVm0UtcI+vJtXF9Pm+fYAIzMkJHlrmwaOQmuQ+rs4ikIIRkslW+
 G5O14Y7o3XSDnovyAsOm2CBRHKmbjbpzpy3KqRm7EGgSA2C/NJ8YwgzZ0y0pMJqFbsRI
 LIEBztaL5WDT9tqya0dcn4e9cfn7TUbYPwNxiAvB0abKT2VQ8hVXP3xKslmg7hGsI5za
 m6umd/rsBBDqu3DKohevOPNpyfeA+Hq+1t9wXO7YhoZXoV9rPbI4+X9mubdtodI6s5JN
 ZWZnKoVE5TJGqbMtMwtC3Ai1QR1DlRIeyjPc78bX6R8Cjas6DPanaAi6+yoe+BG5iJWV
 Ws1A==
X-Gm-Message-State: AOJu0YxmZgqCJR4ErhwLCxxQG4BISwtRDmVAL9e/M5XXrFVAJt1SL43j
 nmUmX4o8BB1KbCCd18pa792sYzNKinyhZxNhmfuSgp0OVtjQP46Rv9ZUwif5KjxMlFGeF0l+m6v
 SC/HX4RPXbFJHmdHZzGCUk7JreIzLqIQ=
X-Gm-Gg: AR+sD10sZeuW4bR6+i24GqquQ7mLF6DgWXZXI92TjIZwau9zGitY2ewyFa9ccYLaKXU
 1BLOm6r++23/SC21E19jtDXlT4vA1ARPGsBgp0zjgL86rvmkYZKHxQSmwzhyDDUnrdPPoel444j
 xdeH6Y3I8pNOLZ6F7bZvRkTDjgzyWJNhuuvrIVMjbWKVs0SAhv96osbc9ku0DNt8qF3JrQl5mYz
 h2N+U2fgia7sZX5tp8yhA+mugIrt+iGvkyHqLsrdZpigMkJ1+GRDJAOqTlFO/hrUOeroeA2jxKq
 7PsuNvTeBduA8QNFqWZxrvZSG8yrPHhXnBR4hbQ0rCLoSVAQareXVbT2kcY+HwyxNh0H7LBC3rm
 ArB/Xg/+Ow59vHCxLhJG50plA5japhyo=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3903c7278f5mr16758695a91.3.1786110444880; Fri, 07 Aug 2026
 06:47:24 -0700 (PDT)
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
In-Reply-To: <PH7PR12MB600029F6BFBAD2FE80A1841DFBD12@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Aug 2026 09:47:13 -0400
X-Gm-Features: AUfX_myU6caY5pRMfpw3AuPO5fxJNWvKLwfsTfl0QIkW1axN0RYPbndmbQm_0fk
Message-ID: <CADnq5_NtQF7eU0iZv5786gVPUJ+U8daOBrqP0snAUpknKogMgQ@mail.gmail.com>
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

On Fri, Aug 7, 2026 at 9:39=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> AMD General
>
>
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, August 4, 2026 10:18 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om>;
> > Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute use=
rq reset
> >
> > On Tue, Aug 4, 2026 at 4:16=E2=80=AFAM Liang, Prike <Prike.Liang@amd.co=
m> wrote:
> > >
> > > AMD General
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Monday, August 3, 2026 9:40 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher,
> > > > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute
> > > > userq reset
> > > >
> > > > On Mon, Aug 3, 2026 at 9:36=E2=80=AFAM Liang, Prike <Prike.Liang@am=
d.com> wrote:
> > > > >
> > > > > AMD General
> > > > >
> > > > > Regards,
> > > > >       Prike
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > Sent: Monday, August 3, 2026 9:23 PM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> > > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > compute userq reset
> > > > > >
> > > > > > On Mon, Aug 3, 2026 at 5:25=E2=80=AFAM Liang, Prike <Prike.Lian=
g@amd.com>
> > wrote:
> > > > > > >
> > > > > > > AMD General
> > > > > > >
> > > > > > > As for the hung userq, it should be identified by the MES
> > > > > > > reset API with the
> > > > > > hang_detect_only setting. However, it is unlikely to miss
> > > > > > detecting the invalid opcode hang case, especially given that
> > > > > > the userq invalid opcode IGT test has not been implemented yet.
> > > > > > >
> > > > > > > Hi @Liu, Shaoyun, are you aware of any known userq hang
> > > > > > > scenarios that cannot
> > > > > > be identified by MES API hang_detect_only? If not, could you
> > > > > > please help review the following patch, which unifies the userq
> > > > > > reset path for hung
> > > > queues?
> > > > > > >
> > > > > >
> > > > > > We added it in the first place to deal with those cases.  There
> > > > > > can be queues which are not hung, but will never complete and
> > > > > > hence never signal their fence.  E.g., you can have a queue tha=
t
> > > > > > is waiting on a memory location that MES can preempt, but due t=
o
> > > > > > a bug elsewhere that memory location will never change so the f=
ence will
> > never signal.
> > > > >
> > > > > Thank you for the input. However, for fake timeout cases such as
> > > > > the long shader
> > > > scenario, we should identify the fake hang cases by checking whethe=
r
> > > > the guilty queue appears in the hang list, or whether the queue rpt=
r
> > > > is still updating? If so, preempt the queue rather than resetting i=
t?
> > > > >
> > > >
> > > > We have to assume that if we end up in the queue reset path that th=
e queue is
> > hung.
> > > > The fences have to signal in finite time.  If we preempt the queue
> > > > that won't signal the fence so we'll just end up in the queue reset
> > > > path again.  Preemption of a queue that won't make progress only ma=
kes sense
> > if fences are not involved.
> > >
> > > The most cases relevant to userq fence timeout and reset worker likel=
y to be
> > scheduled when a userq fence polling period expires. If a long running =
shader is
> > detected, the driver may need to try preempting the queue within a few =
retry cycles.
> > If the userq fence remains unsignaled after the retries are exhausted, =
the driver can
> > either return -ETIME to userspace for further handling or fall back to =
resetting the
> > queue directly. Meanwhile, If the preemption succeeds and the queue com=
pletes its
> > work during the subsequent restore process, no further reset is necessa=
ry for the
> > guilty queue?
> > >
> >
> > If an application wants to run long running jobs they shouldn't use pro=
tected fences
> > in the first place.  If they don't use protected fences, then it should=
 behave like KFD
> > queues.  If there is some operation that needs to happen the queues wil=
l get
> > preempted and then will continue later.  DMA fences need to signal in f=
inite time so
> > we can't just keep pushing them off.  Other kernel paging operations ma=
y depend on
> > them signalling.
>
> Regarding the protected fences, do you mean the userq fence that triggers=
 the hang detection work queue?
>

Yes.

> If so, the current implementation calls amdgpu_userq_fence_init() at fenc=
e emit time (i.e., at each queue submission), which both initializes the dm=
a_fence structure and starts the hang detection timer for that submission. =
Once the timeout expires, amdgpu_userq_hang_detect_work() fires and trigger=
s a queue reset regardless of whether the queue is actually hung or simply =
long-running. But there's a core problem for the kernel to distinguish a hu=
ng queue from a slow one at fence emit time, since both look identical an u=
nsignaled fence with an active queue.
>

That is the intended behavior. If you opt into using a dma fence, you
need to abide by its semantics.

> However, we can defer that determination to the first timeout expiry in a=
mdgpu_userq_hang_detect_work(). At that point we have more information to w=
ork with:
>
>
> Check for real hang: query rptr and rptr has not updated since the fence =
was emitted, the queue is genuinely stuck (frozen waves, infinite loop). Th=
is is a real hang, reset immediately and forcing completing the fences.
> Check for forward progress: if rptr has updated but the fence is still un=
signaled, the queue is making progress, so it is long running, not hung. In=
 this case:
>
> Extend the timeout (reschedule hang_detect_work with a longer interval)
> Track retry count if the queue still has not completed after N extended c=
ycles, escalate: Preempt the queue, force completing the fence and return -=
ETIME to userspace then let the application decide: resubmit, split the wor=
kload, or drop.
>
> Avoid unnecessary resets: if preemption succeeds and the queue resumes an=
d completes within the extended window, cancel the reset entirely since the=
 queue was slow, not broken.
>
>
> Do you think this is the right way for handling long-running tasks to res=
olve the userq timeout issue, or does it align with your idea?

If you want to run a super long running job, then you shouldn't use a
dma fence in the first place.  There might be a job that takes 2
minutes or even an hour to run, but you can't wait that long for a dma
fence.  If you do, the kernel might run out of memory and the OOM
killer will start killing processes or you could deadlock.  If you
want to run a long job, don't use a dma fence.  If you don't use a dma
fence, then the kernel can preempt the queues, do whatever memory
management it needs to and then it can resume the queues.  dma fences
have to signal in finite time.

Alex

>
> Thanks,
> Prike
>
> Avoid unnecessary resets: if preemption succeeds and the queue resumes an=
d completes within the extended window, cancel the reset entirely =E2=80=94=
 the queue was slow, not broken.>
> > Alex
> >
> > > In the longer term, we may need to introduce a more robust mechanism =
to
> > distinguish slow queue cases from genuine hangs, handling them appropri=
ately via
> > extending time slice for completing the queue submission, userspace dri=
ven
> > resubmission, or dropping the work through a queue reset. If it makes s=
ense and
> > right way to do, then I will work on implementing the solution for such=
 slow/long
> > queue cases.
> > >
> > > Thanks,
> > > Prike
> > >
> > > > Alex
> > > >
> > > > > >
> > > > > > Alex
> > > > > >
> > > > > > > Regards,
> > > > > > >       Prike
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Liang, Prike
> > > > > > > > Sent: Thursday, July 23, 2026 2:38 PM
> > > > > > > > To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > > > <Jesse.Zhang@amd.com>
> > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > > > Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > > > compute userq reset
> > > > > > > >
> > > > > > > > I checked each different userq hang cases, and the guilty
> > > > > > > > userq can be identified by the MES firmware and report corr=
ectly.
> > > > > > > > @Zhang,
> > > > > > > > Jesse(Jie) could you further check as well at you side?
> > > > > > > >
> > > > > > > > If there're some hang queues miss identified by MES
> > > > > > > > firmware, then the correct thing is to further debug from
> > > > > > > > MES firmware side rather than have such strange reset
> > > > > > > > sequence and this reset workaround should be
> > > > > > cleaned sooner or later.
> > > > > > > >
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > >       Prike
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > > > Sent: Wednesday, July 15, 2026 2:31 PM
> > > > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > > > > > > Koenig, Christian <Christian.Koenig@amd.com>; Liang, Prik=
e
> > > > > > > > > <Prike.Liang@amd.com>
> > > > > > > > > Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > > > > compute userq reset
> > > > > > > > >
> > > > > > > > > amdgpu_mes_detect_and_reset_hung_queues() already detects
> > > > > > > > > the guilty compute user queue and resets it through
> > > > > > > > > mes_userq_reset_queue(). The additional reset via
> > > > > > > > > mes_userq_reset() is unnecessary, so remove it to unify
> > > > > > > > > the compute userq
> > > > > > reset.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
> > > > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
> > > > > > > > >  2 files changed, 7 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > @@ -2315,11 +2315,6 @@ int
> > > > > > > > > amdgpu_gfx_reset_mes_compute(struct
> > > > > > > > > amdgpu_device *adev,
> > > > > > > > >             deferred_end[n_deferred].fence =3D guilty_fen=
ce;
> > > > > > > > >             n_deferred++;
> > > > > > > > >     }
> > > > > > > > > -   if (uq) {
> > > > > > > > > -           r =3D mes_userq_reset(uq);
> > > > > > > > > -           if (r)
> > > > > > > > > -                   goto out;
> > > > > > > > > -   }
> > > > > > > > >     for (i =3D 0; i < num_hung; i++) {
> > > > > > > > >             struct amdgpu_ring *hr =3D NULL;
> > > > > > > > >             struct amdgpu_fence *hf =3D NULL; diff --git
> > > > > > > > > a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > index b6bfa3974839..fab21d4275f3 100644
> > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct
> > > > > > > > > amdgpu_device *adev,
> > > > > > > > >
> > > > > > > > >     xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> > > > > > > > >             if (uq->queue_type =3D=3D queue_type) {
> > > > > > > > > -                   if (uq =3D=3D guilty_uq)
> > > > > > > > > -                           continue;
> > > > > > > > >                     if (uq->doorbell_index =3D=3D db) {
> > > > > > > > >                             uq->state =3D AMDGPU_USERQ_ST=
ATE_HUNG;
> > > > > > > > >                             if (use_mmio)
> > > > > > > > > --
> > > > > > > > > 2.34.1
> > > > > > >
