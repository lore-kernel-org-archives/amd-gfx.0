Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342BDC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 16:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EB510E3B0;
	Fri, 11 Jul 2025 16:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ndkfWSFm";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752D710E3B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 16:51:55 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-23c8f163476so2187485ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752252715; x=1752857515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5arwYGW3RwSl8kPzi6Pu11+kcVjNYYz2Xs1IruRNDc=;
 b=ndkfWSFmnsvVHoyFux+lcUAobdnyLlb2jfsaJ3NMt2/mhBeZrxW4KUqO61fpljfFc/
 CF1tfDxjjyR72xallTndYatJ5+SbqmlI+FldIwRmK3Ep8Utsv0N/CNk2UdsAZiKHfZhd
 EmphkrC9zqPca53Mnam1f2RsGsDAWLTX7ZLrPJVtMQDURUaQVLBYjud7DndqzmKlq4wb
 BYpQiOkLiJxE6hSGZR6nEdoUGCuGk/BRklDKWfhNPtFzbun/pg5lbj9Ns77zsfsKZB6f
 724jVPjoh37+uHdDe56xePEgF82MOorLLY7G6WlgFF+opjF0YVSueGFJv2GlO5N/z2d2
 YyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752252715; x=1752857515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5arwYGW3RwSl8kPzi6Pu11+kcVjNYYz2Xs1IruRNDc=;
 b=ZzLh0o+x6JICI99+f4zISb8u38JL2OiR2jptKmcXQG1dWN/2fSzhx74OUaZjJK0HlT
 xi3ZWMHvCizBJ2qSSgff4lp6vwOXQiMQtUO/0dYV9fhNQ72m9c/80WbbKPdejEBUTwc4
 HuQtB/YwZZEURA9xdl+B/RGOifvZoK86UCKyTx+5w9nN7MIDA+gxVdYRFOHQiJ8QiMFz
 nR0QT2RdmMb3MJcQ/WRzvcHWNXXAt3xIIScv9ToCNCXzE1NUOKNg0GqYeA0yvdlKMOtJ
 Au5KbE7OhRmBxkS/ChO/UCPmDNQZIYE4fYZhQmniQmVz775+/c2lhi+jOnUuIdmN8OIg
 CjiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVInl8LjqTBDcKqtEKVKU6625yIgPXbuPoMzOi8G9lQxIKAEn3LSip5lmaER1GjDEzdu+IXsVjJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh595a/ctz79TH6grKIVrPxopfHz4N1lvSRxLv8b44JiUdd3Xy
 K+aArkAMNly71dcRR2fFd9RnGiTy8YzwSs4OO3MHJPs2Mbl+oz2w0km8jOn1lPp8JGB0bVbw/Gk
 kRGjzggk9AMRbbrHMCzOpKayY7B6h6ybDoEYq
X-Gm-Gg: ASbGnctyPb45FhkO4VMvAED22d+wHyOo9KB+nhggOd0atj7HWjR4v4MgUPtHSYm1LB4
 iKX/7OftSxqqyzdQVhkuSEcgQI3E2/PSRAMVjOtbNVmFHsikhzjcd4seQ4hHuq2ycEcXThU1+OD
 d4RcK5ABllK1uiL0y2JBDJFQSy7PIPhyUWHiBCU8j0M5v2CPxMiTWrlzd5pXOZtWztqga8CdgO2
 jT93Qwx
X-Google-Smtp-Source: AGHT+IGJ1SjhjCn2hdBlAIfP9KdF4AwlZGYRIqmIifhv8kJNbstlIp+GRz1MY7X8OCxiVHD09vByZ2LUG0kYlSrQql4=
X-Received: by 2002:a17:903:1206:b0:236:71f1:d345 with SMTP id
 d9443c01a7336-23def8a31cfmr16305065ad.1.1752252714628; Fri, 11 Jul 2025
 09:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
 <CADnq5_NYhPa+6gUqeJsvXkqtkwwkWmv=F70Wv96L+CEA-AGE1w@mail.gmail.com>
 <6d19ad87-6091-477c-a1ee-ddb224a63fe1@igalia.com>
In-Reply-To: <6d19ad87-6091-477c-a1ee-ddb224a63fe1@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jul 2025 12:51:41 -0400
X-Gm-Features: Ac12FXxuIr8i8fNBlPWRLQaouAA7Es1mPyICMiPguhpasrb_3HY3W0956oGa6Ko
Message-ID: <CADnq5_PFKKdDOnX7np+31jDfmf17=PNSFoFtmHk+XSPqRjnf4Q@mail.gmail.com>
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
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

On Fri, Jul 11, 2025 at 12:07=E2=80=AFPM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
>
> On 11/07/2025 16:51, Alex Deucher wrote:
> > On Fri, Jul 11, 2025 at 9:58=E2=80=AFAM Tvrtko Ursulin
> > <tvrtko.ursulin@igalia.com> wrote:
> >>
> >>
> >> On 11/07/2025 14:39, Alex Deucher wrote:
> >>> On Fri, Jul 11, 2025 at 9:22=E2=80=AFAM Tvrtko Ursulin
> >>> <tvrtko.ursulin@igalia.com> wrote:
> >>>>
> >>>>
> >>>> On 11/07/2025 13:45, Christian K=C3=B6nig wrote:
> >>>>> On 11.07.25 14:23, Tvrtko Ursulin wrote:
> >>>>>> Commit
> >>>>>> 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callback=
s")
> >>>>>> added a workaround which disables GFXOFF for the duration of the j=
ob
> >>>>>> submit stage (with a 100ms trailing hysteresis).
> >>>>>>
> >>>>>> Empirically the GFXOFF disable/enable request can suffer from sign=
ificant
> >>>>>> latencies (2ms is easily seen) which are then inserted onto the
> >>>>>> amdgpu_job_run() path, which slows down the CPU submission of read=
y jobs.
> >>>>>>
> >>>>>> 1)
> >>>>>> If the premise of the GFXOFF workaround is to keep it disabled whi=
le the
> >>>>>> SDMA engine is active, the current workaround achieves that only
> >>>>>> partially, for submissions and jobs which take less than 100ms (th=
e GFXOFF
> >>>>>> re-enable hysteresis), counting from the ring write phase, up to
> >>>>>> completion.
> >>>>>>
> >>>>>> 2)
> >>>>>> If disabling GFXOFF affects the GFX engine too, basing the workaro=
und
> >>>>>> solely on the SDMA activity creates, at minimum, a needless "chatt=
er" on
> >>>>>> the SMU communication channel.
> >>>>>
> >>>>> IIRC that is intentional. This "needless" chatter is what the worka=
round was all about.
> >>>>
> >>>> I tried to gather knowledge to how the hardware works from the comme=
nt
> >>>> in sdma_v5_2_ring_begin_use(). Maybe I got it wrong so bear with me =
please.
> >>>>
> >>>> To try and explain my questions better. If the GFX ring/engine is bu=
sy
> >>>> is there a point for SDMA to be requesting GFXOFF enable/disable? Or
> >>>> maybe with diagrams...
> >>>>
> >>>> 1)
> >>>>
> >>>> SDMA:
> >>>>
> >>>>       ring-write     ring-commit       job-execute       job-done
> >>>>     gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
> >>>>
> >>>> Was the workaround prematurely dropped in this case (aka is
> >>>> ring->funcs->end_use() the right place to drop it from)? Probably
> >>>> theoretical that a SDMA job takes more than 100ms but I am trying to
> >>>> understand it all.
> >>>>
> >>>
> >>> The firmware controls the power to a subset of the chip which contain=
s
> >>> both gfx and sdma.  Normally the firmware dynamically powers up and
> >>> down gfx transparently when doorbells come in or the engines go idle
> >>> for either engine.  amdgpu_gfx_off_ctrl() tells the firmware to allow
> >>> or disallow gfxoff entry.  So what this workaround does is disallow
> >>> gfxoff (which results in gfx being powered up) before we touch SDMA.
> >>> Once SDMA is active, we can allow gfxoff again as it will dynamically
> >>
> >> Hmm so it is "once" and not "while", as the comment says:
> >>
> >>          /* SDMA 5.2.3 (RMB) FW doesn't seem to properly
> >>           * disallow GFXOFF in some cases leading to
> >>           * hangs in SDMA.  Disallow GFXOFF while SDMA is active.
> >>
> >> ?
> >>
> >> And for "once active" amdgpu_ring_commit() is what it counts?
> >
> > Yes, amdgpu_ring_commit() rings the doorbell and at that point the
> > engine starts running and SDMA is active.
>
> Should I submit a patch to change this comment to say "Disallow GFXOFF
> until SDMA is active (doorbell was rang)"?

Sure.

>
> >>
> >>> be disabled once GFX/SDMA is no longer active.  In this particular
> >>> case there was a race condition somewhere in the internal handshaking
> >>> with SDMA which led to SDMA missing doorbells sometimes and not
> >>> executing the job even if there was work in the ring.
> >>
> >> Thank you, more or less than what I assumed.
> >>
> >> But in this case there should be no harm in holding GFXOFF disabled
> >> until the job completes (like this patch)? Only a win to avoid the SMU
> >> communication latencies while unit is powered on anyway.
> >
> > The extra latency is only on the CPU side, once the
> > amdgpu_ring_commit() is called the SDMA engine is already working.
>
> It is on the CPU side but can create bubbles in the pipeline, no? Is
> there no scope with AMD to have GFX and SDMA jobs depend on each other?
> Because, as said, I've seen some high latencies from the GFXOFF disable
> calls.

The SDMA job is already executing at that point.  The allow gfxoff
message to the firmware shouldn't come until later because it's
handled by a delayed work thread from end_use().  If you have multiple
submissions to SDMA within the delay window, the begin_use() and
end_use() will just be ref count handling and won't actually talk to
the firmware.

>
> > Plus, the sooner you allow gfxoff again, the sooner it can start
> > kicking in again.
>
>  From this I read that even while GFX or SDMA rings are executing jobs
> GFXOFF can still power down stuff?

Only if all of the blocks are idle which would likely not be the case
if you have outstanding jobs.

Alex

>
> Regards,
>
> Tvrtko
>
> >
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>>> 2)
> >>>>
> >>>>
> >>>> GFX:
> >>>>
> >>>>       +-----  job executing --------------------------------------+
> >>>>
> >>>> SDMA:
> >>>>
> >>>>       ring-write     ring-commit       job-execute       job-done
> >>>>     gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
> >>>>
> >>>>
> >>>> Is it required for the SDMA activity to cause SMU message traffic in
> >>>> this case, or is the powerdomain implied to be on (GFXOFF cannot tur=
n it
> >>>> off while GFX is active)?
> >>>>
> >>>> This is the case I measured latency spikes. While the GFX load was
> >>>> running I was seeing SDMA->run_job() spike and traced it to the SMU
> >>>> communication.
> >>>>
> >>>> Hence the idea from the patch - prevent adev->gfx.gfx_off_req_count
> >>>> dropping to zero until both GFX and SDMA are idle.
> >>>>
> >>>> https://imgshare.cc/rdxu2bjl
> >>>>
> >>>> Above is visual representation of these latencies. Y is SDMA run_job=
()
> >>>> duration in micro-seconds, X is seconds wall time. Blue is stock ker=
nel,
> >>>> orange is with this patch. X goes for ~60 seconds, which is how long
> >>>> Cyberpunk 2077 benchmark is.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Tvrtko
> >>>>
> >>>>>> If 1) and 2) hold true, we can improve on the workaround by; a) on=
ly
> >>>>>> re-enabling GFXOFF once the job had actually completed*, and b) ap=
ply the
> >>>>>> same workaround on other rings which share the same GFXOFF powerga=
ting
> >>>>>> domain.
> >>>>>
> >>>>> The point of GFXOFF is to turn GFX on/off *without* kernel driver i=
nteraction. Otherwise we don't need it in the first place.
> >>>>>
> >>>>> We just have a hack for the SDMA because that moved into the GFXOFF=
 domain with Navi and is broken on some HW generations IIRC.
> >>>>>
> >>>>>>
> >>>>>> With these two applied, the GFXOFF re-enable requests are avoided
> >>>>>> altogether during persistent activity on the GFX ring and simultan=
eous
> >>>>>> sporadic activity on the SDMA ring.
> >>>>>>
> >>>>>> This has a positive effect of drastically reducing SDMA submission
> >>>>>> latencies. For example during the Cyberpunk 2077 benchmark, they a=
re
> >>>>>> reduced from an average of 64us (stdev 60) to 9us (stdev 6). Or mo=
re
> >>>>>> importantly the worst case latency, averaged to a one second windo=
w, is
> >>>>>> reduced from 305us to 30us**.
> >>>>>>
> >>>>>> *) For ease of implementation we put the re-enable at the job free=
 stage,
> >>>>>> since doing it on actual completion is problematic in terms of loc=
king.
> >>>>>
> >>>>> Absolutely clear NAK to this. Never ever base anything on the job l=
ivetime!
> >>>>>
> >>>>> We already had enough trouble with that.
> >>>>>
> >>>>>>
> >>>>>> **) Submission latency ewma averaged (DECLARE_EWMA(latency, 6, 4))=
 -
> >>>>>> Approximately 30 SDMA submissions per second, ewma average logged =
once
> >>>>>> per second therefore significantly hides the worst case latency. E=
g.
> >>>>>> the real improvement in max submission latency is severely underst=
ated by
> >>>>>> these numbers.
> >>>>>
> >>>>> Well that would indeed be quite nice to have.
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>>>> References: 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use r=
ing callbacks")
> >>>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 1 +
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 ++++++++
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 7 +++++++
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 2 ++
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
> >>>>>>     7 files changed, 23 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>>> index 08f268dab8f5..eee40f385793 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>>> @@ -475,6 +475,7 @@ struct amdgpu_gfx {
> >>>>>>        uint32_t                        compute_supported_reset;
> >>>>>>
> >>>>>>        /* gfx off */
> >>>>>> +    bool                            gfx_off_held;       /* true: =
rings hold gfx_off */
> >>>>>>        bool                            gfx_off_state;      /* true=
: enabled, false: disabled */
> >>>>>>        struct mutex                    gfx_off_mutex;      /* mute=
x to change gfxoff state */
> >>>>>>        uint32_t                        gfx_off_req_count;  /* defa=
ult 1, enable gfx off: dec 1, disable gfx off: add 1 */
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ib.c
> >>>>>> index 206b70acb29a..bf9bffe40235 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>>>>> @@ -191,6 +191,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ri=
ng, unsigned int num_ibs,
> >>>>>>                return r;
> >>>>>>        }
> >>>>>>
> >>>>>> +    if (job && adev->gfx.gfx_off_held &&
> >>>>>> +        (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX ||
> >>>>>> +         ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> >>>>>> +         ring->funcs->type =3D=3D AMDGPU_RING_TYPE_SDMA)) {
> >>>>>> +            amdgpu_gfx_off_ctrl(adev, false);
> >>>>>> +            job->gfx_off_held =3D true;
> >>>>>> +    }
> >>>>>> +
> >>>>>>        need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
> >>>>>>        if (ring->funcs->emit_pipeline_sync && job &&
> >>>>>>            ((tmp =3D amdgpu_sync_get_fence(&job->explicit_sync)) |=
|
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> index 2b58e353cca1..4cfd175ac6df 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> @@ -191,6 +191,7 @@ int amdgpu_job_alloc(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
> >>>>>>        if (!*job)
> >>>>>>                return -ENOMEM;
> >>>>>>
> >>>>>> +    (*job)->adev =3D adev;
> >>>>>>        (*job)->vm =3D vm;
> >>>>>>
> >>>>>>        amdgpu_sync_create(&(*job)->explicit_sync);
> >>>>>> @@ -268,6 +269,9 @@ static void amdgpu_job_free_cb(struct drm_sche=
d_job *s_job)
> >>>>>>
> >>>>>>        amdgpu_sync_free(&job->explicit_sync);
> >>>>>>
> >>>>>> +    if (job->gfx_off_held)
> >>>>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
> >>>>>> +
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>>        /* only put the hw fence if has embedded fence */
> >>>>>>        if (!job->hw_fence.base.ops)
> >>>>>>                kfree(job);
> >>>>>> @@ -301,6 +305,9 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >>>>>>        if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >>>>>>                dma_fence_put(job->gang_submit);
> >>>>>>
> >>>>>> +    if (job->gfx_off_held)
> >>>>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
> >>>>>> +
> >>>>>>        if (!job->hw_fence.base.ops)
> >>>>>>                kfree(job);
> >>>>>>        else
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_job.h
> >>>>>> index 2f302266662b..d4ab832ac193 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>>>>> @@ -46,6 +46,7 @@ enum amdgpu_ib_pool_type;
> >>>>>>
> >>>>>>     struct amdgpu_job {
> >>>>>>        struct drm_sched_job    base;
> >>>>>> +    struct amdgpu_device    *adev;
> >>>>>>        struct amdgpu_vm        *vm;
> >>>>>>        struct amdgpu_sync      explicit_sync;
> >>>>>>        struct amdgpu_fence     hw_fence;
> >>>>>> @@ -55,6 +56,7 @@ struct amdgpu_job {
> >>>>>>        bool                    vm_needs_flush;
> >>>>>>        bool                    gds_switch_needed;
> >>>>>>        bool                    spm_update_needed;
> >>>>>> +    bool                    gfx_off_held;
> >>>>>>        uint64_t                vm_pd_addr;
> >>>>>>        unsigned                vmid;
> >>>>>>        unsigned                pasid;
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_ring.c
> >>>>>> index 426834806fbf..22cac94e2f2a 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>>>>> @@ -350,6 +350,9 @@ int amdgpu_ring_init(struct amdgpu_device *ade=
v, struct amdgpu_ring *ring,
> >>>>>>        ring->max_dw =3D max_dw;
> >>>>>>        ring->hw_prio =3D hw_prio;
> >>>>>>
> >>>>>> +    if (ring->funcs->gfx_off_held)
> >>>>>> +            adev->gfx.gfx_off_held =3D true;
> >>>>>> +
> >>>>>>        if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP=
_NUM) {
> >>>>>>                hw_ip =3D ring->funcs->type;
> >>>>>>                num_sched =3D &adev->gpu_sched[hw_ip][hw_prio].num_=
scheds;
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_ring.h
> >>>>>> index 784ba2ec354c..afaf951b0b78 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>>>>> @@ -202,6 +202,7 @@ struct amdgpu_ring_funcs {
> >>>>>>        bool                    support_64bit_ptrs;
> >>>>>>        bool                    no_user_fence;
> >>>>>>        bool                    secure_submission_supported;
> >>>>>> +    bool                    gfx_off_held;
> >>>>>>        unsigned                extra_dw;
> >>>>>>
> >>>>>>        /* ring read/write ptr handling */
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/=
drm/amd/amdgpu/sdma_v5_2.c
> >>>>>> index 42a25150f83a..c88de65e82bc 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>>>>> @@ -1944,6 +1944,7 @@ static const struct amdgpu_ring_funcs sdma_v=
5_2_ring_funcs =3D {
> >>>>>>        .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
> >>>>>>        .support_64bit_ptrs =3D true,
> >>>>>>        .secure_submission_supported =3D true,
> >>>>>> +    .gfx_off_held =3D true,
> >>>>>>        .get_rptr =3D sdma_v5_2_ring_get_rptr,
> >>>>>>        .get_wptr =3D sdma_v5_2_ring_get_wptr,
> >>>>>>        .set_wptr =3D sdma_v5_2_ring_set_wptr,
> >>>>>
> >>>>
> >>
>
