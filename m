Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82326C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 15:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216FE10E3A1;
	Fri, 11 Jul 2025 15:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vk27+zeY";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEC010E3A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 15:51:33 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-313fab41fd5so454178a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752249093; x=1752853893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0Xky7gnLnMVVR0Uvfb3z39dRfPReD8LNQp8i0OTrVY=;
 b=Vk27+zeYpLVZIV8kNfalIf2T2J/dgf2iw16qOW47TRUjZzK/nqtgzlG7r/QKR/rTm/
 YrjbRT9Nl6UuBVyablWOiLCjjcib2vXr3tmI7lTBbWNshvA0vcwim4RFnEgkQkEmw2mU
 NxQZuxgIFNin610gaIBO23Z7RGaxlJ8RXzBy4bs+guvh8cNz3h6YzEVAfCSuohYiNSQd
 wPhF6zoSPRhr4vrl/FoaTG9wBzTE0fDTi3/qnnPbyVQBtOiR/zZEec1xJa9TcVk2RrBG
 nQx3jUCcLzA7dHPHzy0oyfiHoKmA8UlKnn2SUXdVElqipUa/ya6xMuKzLLtElXj8fjon
 tlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752249093; x=1752853893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0Xky7gnLnMVVR0Uvfb3z39dRfPReD8LNQp8i0OTrVY=;
 b=XJ0NgS7f5YAvDTrM0BJg79e7qo+8wHKp6JB6A8unzlKfw7FtYb3vTQ1ERYdxZA8w/A
 u+TBYGOC6ekGp9alyMZadZtlvAJcRjz1O31n2ZmXGnCdi073dB7qtLgjy2CamR+4vCCf
 xsRdyVhcyaOrdBwhgBI/5z4UGXFIdSYe1FcMkkxXpwXZUG2G8fq1UcsGaFBfAuBqRb54
 sGLaqEBKL+lWiPEOcuI0BIjVSoFKhzIKLboT1KFpvgBl7vGdwd10kA62NfSANw3d/aao
 Uvg3zKC5yn3Kaf5B4sVtHsAefDIF9kIexu/PelP95wiqTCpenCGbotSbTuTAsizttkXK
 +qRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV4tl2Zqx5YJ/lD929qjlHXsMmrd8fjtAtwx/Hh80noeFdL+2KcPpc/vjqNMCSr9TqNFE1U7g0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzL6STbsOk2xL0U1QcA74QlBTPiv3Od6GOC45rq6z3urj5madDN
 U3tyhGs0UAKNb9y4DC/FCED/hmIttv11AKaJjoeiZGLS8EfzXSF4zrNzqIaobz8k7J88zeV25NU
 ZLPLhx6YYF9GGHFNgMVQL5P5gx1TnFgs=
X-Gm-Gg: ASbGncuVUs/AIn+bm4dhT2v6p6UZ6KZJVq+4tHkuF3trJJS1xRbQfUyhSUeWk8jfeJd
 cbR9kQvu//U8IUNaU4DkfYxHYsYHp0TfLFRtxjQC6WAvQq3Ng3B1vknt6RTHxd63jZNP++afwVw
 axm4la2DdRRY737+5O7wXyHa3Ax48tnb7/sW9pBjZZPsD1gfRRW2oPd1ANUiAhuviavYWZzis6w
 BTa8MgYP58sdRg/iCI=
X-Google-Smtp-Source: AGHT+IFQLxApbVE0cUaSiYMazwOi3eqP3gZIbSYcNsTy5OUzTNhiHRIwIaPfkxrjRzmMn4bG49CnDus7XocRFY2IyWQ=
X-Received: by 2002:a17:90b:2e8b:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c4f540066mr1816285a91.5.1752249093081; Fri, 11 Jul 2025
 08:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
In-Reply-To: <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Jul 2025 11:51:21 -0400
X-Gm-Features: Ac12FXzuEXbMVA7d2ZqQJQSWSGXHTrZMBKw1LEiz0q2IfBogR-yoi4Wi24tniEg
Message-ID: <CADnq5_NYhPa+6gUqeJsvXkqtkwwkWmv=F70Wv96L+CEA-AGE1w@mail.gmail.com>
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

On Fri, Jul 11, 2025 at 9:58=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
>
> On 11/07/2025 14:39, Alex Deucher wrote:
> > On Fri, Jul 11, 2025 at 9:22=E2=80=AFAM Tvrtko Ursulin
> > <tvrtko.ursulin@igalia.com> wrote:
> >>
> >>
> >> On 11/07/2025 13:45, Christian K=C3=B6nig wrote:
> >>> On 11.07.25 14:23, Tvrtko Ursulin wrote:
> >>>> Commit
> >>>> 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks"=
)
> >>>> added a workaround which disables GFXOFF for the duration of the job
> >>>> submit stage (with a 100ms trailing hysteresis).
> >>>>
> >>>> Empirically the GFXOFF disable/enable request can suffer from signif=
icant
> >>>> latencies (2ms is easily seen) which are then inserted onto the
> >>>> amdgpu_job_run() path, which slows down the CPU submission of ready =
jobs.
> >>>>
> >>>> 1)
> >>>> If the premise of the GFXOFF workaround is to keep it disabled while=
 the
> >>>> SDMA engine is active, the current workaround achieves that only
> >>>> partially, for submissions and jobs which take less than 100ms (the =
GFXOFF
> >>>> re-enable hysteresis), counting from the ring write phase, up to
> >>>> completion.
> >>>>
> >>>> 2)
> >>>> If disabling GFXOFF affects the GFX engine too, basing the workaroun=
d
> >>>> solely on the SDMA activity creates, at minimum, a needless "chatter=
" on
> >>>> the SMU communication channel.
> >>>
> >>> IIRC that is intentional. This "needless" chatter is what the workaro=
und was all about.
> >>
> >> I tried to gather knowledge to how the hardware works from the comment
> >> in sdma_v5_2_ring_begin_use(). Maybe I got it wrong so bear with me pl=
ease.
> >>
> >> To try and explain my questions better. If the GFX ring/engine is busy
> >> is there a point for SDMA to be requesting GFXOFF enable/disable? Or
> >> maybe with diagrams...
> >>
> >> 1)
> >>
> >> SDMA:
> >>
> >>      ring-write     ring-commit       job-execute       job-done
> >>    gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
> >>
> >> Was the workaround prematurely dropped in this case (aka is
> >> ring->funcs->end_use() the right place to drop it from)? Probably
> >> theoretical that a SDMA job takes more than 100ms but I am trying to
> >> understand it all.
> >>
> >
> > The firmware controls the power to a subset of the chip which contains
> > both gfx and sdma.  Normally the firmware dynamically powers up and
> > down gfx transparently when doorbells come in or the engines go idle
> > for either engine.  amdgpu_gfx_off_ctrl() tells the firmware to allow
> > or disallow gfxoff entry.  So what this workaround does is disallow
> > gfxoff (which results in gfx being powered up) before we touch SDMA.
> > Once SDMA is active, we can allow gfxoff again as it will dynamically
>
> Hmm so it is "once" and not "while", as the comment says:
>
>         /* SDMA 5.2.3 (RMB) FW doesn't seem to properly
>          * disallow GFXOFF in some cases leading to
>          * hangs in SDMA.  Disallow GFXOFF while SDMA is active.
>
> ?
>
> And for "once active" amdgpu_ring_commit() is what it counts?

Yes, amdgpu_ring_commit() rings the doorbell and at that point the
engine starts running and SDMA is active.

>
> > be disabled once GFX/SDMA is no longer active.  In this particular
> > case there was a race condition somewhere in the internal handshaking
> > with SDMA which led to SDMA missing doorbells sometimes and not
> > executing the job even if there was work in the ring.
>
> Thank you, more or less than what I assumed.
>
> But in this case there should be no harm in holding GFXOFF disabled
> until the job completes (like this patch)? Only a win to avoid the SMU
> communication latencies while unit is powered on anyway.

The extra latency is only on the CPU side, once the
amdgpu_ring_commit() is called the SDMA engine is already working.
Plus, the sooner you allow gfxoff again, the sooner it can start
kicking in again.

Alex


>
> Regards,
>
> Tvrtko
>
> >> 2)
> >>
> >>
> >> GFX:
> >>
> >>      +-----  job executing --------------------------------------+
> >>
> >> SDMA:
> >>
> >>      ring-write     ring-commit       job-execute       job-done
> >>    gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
> >>
> >>
> >> Is it required for the SDMA activity to cause SMU message traffic in
> >> this case, or is the powerdomain implied to be on (GFXOFF cannot turn =
it
> >> off while GFX is active)?
> >>
> >> This is the case I measured latency spikes. While the GFX load was
> >> running I was seeing SDMA->run_job() spike and traced it to the SMU
> >> communication.
> >>
> >> Hence the idea from the patch - prevent adev->gfx.gfx_off_req_count
> >> dropping to zero until both GFX and SDMA are idle.
> >>
> >> https://imgshare.cc/rdxu2bjl
> >>
> >> Above is visual representation of these latencies. Y is SDMA run_job()
> >> duration in micro-seconds, X is seconds wall time. Blue is stock kerne=
l,
> >> orange is with this patch. X goes for ~60 seconds, which is how long
> >> Cyberpunk 2077 benchmark is.
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>>> If 1) and 2) hold true, we can improve on the workaround by; a) only
> >>>> re-enabling GFXOFF once the job had actually completed*, and b) appl=
y the
> >>>> same workaround on other rings which share the same GFXOFF powergati=
ng
> >>>> domain.
> >>>
> >>> The point of GFXOFF is to turn GFX on/off *without* kernel driver int=
eraction. Otherwise we don't need it in the first place.
> >>>
> >>> We just have a hack for the SDMA because that moved into the GFXOFF d=
omain with Navi and is broken on some HW generations IIRC.
> >>>
> >>>>
> >>>> With these two applied, the GFXOFF re-enable requests are avoided
> >>>> altogether during persistent activity on the GFX ring and simultaneo=
us
> >>>> sporadic activity on the SDMA ring.
> >>>>
> >>>> This has a positive effect of drastically reducing SDMA submission
> >>>> latencies. For example during the Cyberpunk 2077 benchmark, they are
> >>>> reduced from an average of 64us (stdev 60) to 9us (stdev 6). Or more
> >>>> importantly the worst case latency, averaged to a one second window,=
 is
> >>>> reduced from 305us to 30us**.
> >>>>
> >>>> *) For ease of implementation we put the re-enable at the job free s=
tage,
> >>>> since doing it on actual completion is problematic in terms of locki=
ng.
> >>>
> >>> Absolutely clear NAK to this. Never ever base anything on the job liv=
etime!
> >>>
> >>> We already had enough trouble with that.
> >>>
> >>>>
> >>>> **) Submission latency ewma averaged (DECLARE_EWMA(latency, 6, 4)) -
> >>>> Approximately 30 SDMA submissions per second, ewma average logged on=
ce
> >>>> per second therefore significantly hides the worst case latency. Eg.
> >>>> the real improvement in max submission latency is severely understat=
ed by
> >>>> these numbers.
> >>>
> >>> Well that would indeed be quite nice to have.
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>> References: 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use rin=
g callbacks")
> >>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 1 +
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 ++++++++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 7 +++++++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 2 ++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
> >>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
> >>>>    7 files changed, 23 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_gfx.h
> >>>> index 08f268dab8f5..eee40f385793 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>> @@ -475,6 +475,7 @@ struct amdgpu_gfx {
> >>>>       uint32_t                        compute_supported_reset;
> >>>>
> >>>>       /* gfx off */
> >>>> +    bool                            gfx_off_held;       /* true: ri=
ngs hold gfx_off */
> >>>>       bool                            gfx_off_state;      /* true: e=
nabled, false: disabled */
> >>>>       struct mutex                    gfx_off_mutex;      /* mutex t=
o change gfxoff state */
> >>>>       uint32_t                        gfx_off_req_count;  /* default=
 1, enable gfx off: dec 1, disable gfx off: add 1 */
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ib.c
> >>>> index 206b70acb29a..bf9bffe40235 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>>> @@ -191,6 +191,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring=
, unsigned int num_ibs,
> >>>>               return r;
> >>>>       }
> >>>>
> >>>> +    if (job && adev->gfx.gfx_off_held &&
> >>>> +        (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX ||
> >>>> +         ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> >>>> +         ring->funcs->type =3D=3D AMDGPU_RING_TYPE_SDMA)) {
> >>>> +            amdgpu_gfx_off_ctrl(adev, false);
> >>>> +            job->gfx_off_held =3D true;
> >>>> +    }
> >>>> +
> >>>>       need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
> >>>>       if (ring->funcs->emit_pipeline_sync && job &&
> >>>>           ((tmp =3D amdgpu_sync_get_fence(&job->explicit_sync)) ||
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_job.c
> >>>> index 2b58e353cca1..4cfd175ac6df 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> @@ -191,6 +191,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
> >>>>       if (!*job)
> >>>>               return -ENOMEM;
> >>>>
> >>>> +    (*job)->adev =3D adev;
> >>>>       (*job)->vm =3D vm;
> >>>>
> >>>>       amdgpu_sync_create(&(*job)->explicit_sync);
> >>>> @@ -268,6 +269,9 @@ static void amdgpu_job_free_cb(struct drm_sched_=
job *s_job)
> >>>>
> >>>>       amdgpu_sync_free(&job->explicit_sync);
> >>>>
> >>>> +    if (job->gfx_off_held)
> >>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
> >>>> +
> >>>
> >>>
> >>>
> >>>
> >>>>       /* only put the hw fence if has embedded fence */
> >>>>       if (!job->hw_fence.base.ops)
> >>>>               kfree(job);
> >>>> @@ -301,6 +305,9 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >>>>       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >>>>               dma_fence_put(job->gang_submit);
> >>>>
> >>>> +    if (job->gfx_off_held)
> >>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
> >>>> +
> >>>>       if (!job->hw_fence.base.ops)
> >>>>               kfree(job);
> >>>>       else
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_job.h
> >>>> index 2f302266662b..d4ab832ac193 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>>> @@ -46,6 +46,7 @@ enum amdgpu_ib_pool_type;
> >>>>
> >>>>    struct amdgpu_job {
> >>>>       struct drm_sched_job    base;
> >>>> +    struct amdgpu_device    *adev;
> >>>>       struct amdgpu_vm        *vm;
> >>>>       struct amdgpu_sync      explicit_sync;
> >>>>       struct amdgpu_fence     hw_fence;
> >>>> @@ -55,6 +56,7 @@ struct amdgpu_job {
> >>>>       bool                    vm_needs_flush;
> >>>>       bool                    gds_switch_needed;
> >>>>       bool                    spm_update_needed;
> >>>> +    bool                    gfx_off_held;
> >>>>       uint64_t                vm_pd_addr;
> >>>>       unsigned                vmid;
> >>>>       unsigned                pasid;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ring.c
> >>>> index 426834806fbf..22cac94e2f2a 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>>> @@ -350,6 +350,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev,=
 struct amdgpu_ring *ring,
> >>>>       ring->max_dw =3D max_dw;
> >>>>       ring->hw_prio =3D hw_prio;
> >>>>
> >>>> +    if (ring->funcs->gfx_off_held)
> >>>> +            adev->gfx.gfx_off_held =3D true;
> >>>> +
> >>>>       if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NU=
M) {
> >>>>               hw_ip =3D ring->funcs->type;
> >>>>               num_sched =3D &adev->gpu_sched[hw_ip][hw_prio].num_sch=
eds;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ring.h
> >>>> index 784ba2ec354c..afaf951b0b78 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>>> @@ -202,6 +202,7 @@ struct amdgpu_ring_funcs {
> >>>>       bool                    support_64bit_ptrs;
> >>>>       bool                    no_user_fence;
> >>>>       bool                    secure_submission_supported;
> >>>> +    bool                    gfx_off_held;
> >>>>       unsigned                extra_dw;
> >>>>
> >>>>       /* ring read/write ptr handling */
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/dr=
m/amd/amdgpu/sdma_v5_2.c
> >>>> index 42a25150f83a..c88de65e82bc 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>>> @@ -1944,6 +1944,7 @@ static const struct amdgpu_ring_funcs sdma_v5_=
2_ring_funcs =3D {
> >>>>       .nop =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
> >>>>       .support_64bit_ptrs =3D true,
> >>>>       .secure_submission_supported =3D true,
> >>>> +    .gfx_off_held =3D true,
> >>>>       .get_rptr =3D sdma_v5_2_ring_get_rptr,
> >>>>       .get_wptr =3D sdma_v5_2_ring_get_wptr,
> >>>>       .set_wptr =3D sdma_v5_2_ring_set_wptr,
> >>>
> >>
>
