Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BB1C47DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 20:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5E910EAF9;
	Mon, 22 Jan 2024 20:07:58 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8428510EAF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 20:07:57 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so2492538b6e.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705954017; x=1706558817; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ClvFiynPA21bw46AybuPoqe2xxVaLmP3rqm5Kc3nxg=;
 b=bcLXp8MJjHeahgV0HR8ciZYRh2f8tKIdH2gNaQG2uBrx4TqudzvIIvTcKXMJyZUMsv
 POV4lQTBha3nHG0mnXEJyRKb/3lnlDQMdHLd/bAGi06dgmeq7es+xrB2Vc06WL05VZrK
 cUkRi0YFJKwUgiNNYkd1Ecdjrok/5gXgF+41AgEuJdJvPt3z3s/gZOK6F/Zlet5Ov81j
 tf7rBNHIzOL4qXIxSFogYSU4ihqQtWeP1TBxzZWPs30PZFqHrNNeUC8R+0tbst9IQcdc
 O7bXVD0ZKtls3vGtsAj+UKRgEY4d8NFgTte6+SdwgFv5TgssMT2bNPociCIyhNiyr3CF
 hcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705954017; x=1706558817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ClvFiynPA21bw46AybuPoqe2xxVaLmP3rqm5Kc3nxg=;
 b=wAMHyDSJcy21gbNGr8yCfhs7bO1CHQKky46iPz7y69NX3j/pDzJ442JIeJkQG176cL
 t7rTDgalox89nuvc+86OeACtgrkABAyz96CCWIiPmJ5mH+8nqkrMscjfV7FpUSrextXi
 2FQD6+ONrCojLA6nL9llhNCWGL5hJFlmWmEBhb54DMNYpdkjYhbu9IyQKW5ESR7QIvi5
 jYgVKpeKx0IR5M1+jI63/5uUu1uj5XaN0FOm62/c6zFpcdEjwQyx8I+FoiQyYCVI3S2B
 YVWbmukDTjhrWH/s12x+JpMYIoawjnEAx5VCS+/xfcrnMNnQ6Chd9H8n40MyVbKd08fY
 +UcQ==
X-Gm-Message-State: AOJu0YxBggSDzy7Y6RT8Stux8XZ84BfnX5uisxe8z+qWfr2xB5jFtDNo
 PRSItlDhANPUHB6LLq1Hp5V9RSsDCldK21Ucb8YCCPi56wnQ7Niy/BSyexnZPncwT5Cz6dPCyh8
 0tVJkNnsz1kfKyyx5rZ8QuJYXIy+JLeVg
X-Google-Smtp-Source: AGHT+IExXxeg03r2HUBHdmDNkv4tlbSbxAbMdcTCVCUjzt6UZX3BeqMfrtDSAXFtjtS3laN5ppENzK5F1SBUrB/s/ME=
X-Received: by 2002:a05:6870:b619:b0:210:d265:8d76 with SMTP id
 cm25-20020a056870b61900b00210d2658d76mr381320oab.104.1705954016607; Mon, 22
 Jan 2024 12:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20240121001951.75950-1-vitaly.prosyak@amd.com>
 <4f773891-8a38-41d8-bf35-d0feedc2e6b6@amd.com>
In-Reply-To: <4f773891-8a38-41d8-bf35-d0feedc2e6b6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jan 2024 15:06:44 -0500
Message-ID: <CADnq5_MCmwwVnFtJoyvia7v=8kmwRsQJAZ-SkwFhHbnfYECdbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check flag ring->no_scheduler before usage
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com, vitaly.prosyak@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 22, 2024 at 7:06=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 21.01.24 um 01:19 schrieb vitaly.prosyak@amd.com:
> > From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> >
> >     The issue started to appear after the following commit
> >   11b3b9f461c5c4f700f6c8da202fcc2fd6418e1f (scheduler to variable numbe=
r
> >   of run-queues). The scheduler flag ready (ring->sched.ready) could no=
t be
> >   used to validate multiple scenarios, for example, check job is runnin=
g,
> >   gpu_reset, PCI errors etc. The reason is that after GPU reset, the fl=
ag
> >   is set to true unconditionally even for those rings with an uninitial=
ized scheduler.
>
> That's probably a bug we should fix instead.
>
> scheduler.ready means that the engines was initialized and should
> *never* be touched during GPU reset.
>
> The only exception to this is when the GPU reset fails and we can't get
> the engine working again. In this case the scheduler.ready flag should
> be set to false.
>
> The problem is that when we moved this flag into the scheduler we had
> some rings (like KIQ) which don't have a scheduler but still need to
> toggle this flag. We should probably look into cleaning that up instead.
>

I think this is the right fix in this case.  The queues with
no_scheduler set aren't using the GPU scheduler in the first place, so
we don't really care what the status is, we should just not be
touching them at all in cases which involve the scheduler.  That said,
I agree we should clean up the sched.ready handling in general.

Alex


> Regards,
> Christian.
>
> >   As a result, we called drm_sched_stop, drm_sched_start for the uninit=
ialized
> >   schedule and NULL pointer dereference is occured. For example, the fo=
llowing
> >   occurs on Navi10 during GPU reset:
> >
> >   [  354.231044] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIO=
S V1.03.B10 04/01/2019
> >   [  354.239152] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gp=
u_sched]
> >   [  354.246047] RIP: 0010:__flush_work.isra.0+0x23a/0x250
> >   [  354.251110] Code: 8b 04 25 40 2e 03 00 48 89 44 24 40 48 8b 73 40 =
8b 4b 30 e9 f9 fe ff ff 40 30 f6 4c 8b 36 e9 37 fe ff ff 0f 0b e9 3a ff ff =
ff <0f> 0b e9 33 ff ff ff 66
> >   66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
> >   [  354.269876] RSP: 0018:ffffb234c00e3c20 EFLAGS: 00010246
> >   [  354.275121] RAX: 0000000000000011 RBX: ffff9796d9796de0 RCX: 00000=
00000000000
> >   [  354.282271] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9=
796d9796de0
> >   [  354.289420] RBP: ffff9796d9796de0 R08: ffff977780401940 R09: fffff=
fffa1a5c620
> >   [  354.296570] R10: 0000000000000000 R11: 0000000000000000 R12: 00000=
00000000000
> >   [  354.303720] R13: 0000000000000001 R14: ffff9796d97905c8 R15: ffff9=
796d9790230
> >   [  354.310868] FS:  0000000000000000(0000) GS:ffff97865f040000(0000) =
knlGS:0000000000000000
> >   [  354.318963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000=
000003506f0
> >   [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000=
000003506f0
> >   [  354.331859] Call Trace:
> >   [  354.334320]  <TASK>
> >   [  354.336433]  ? __flush_work.isra.0+0x23a/0x250
> >   [  354.340891]  ? __warn+0x81/0x130
> >   [  354.344139]  ? __flush_work.isra.0+0x23a/0x250
> >   [  354.348594]  ? report_bug+0x171/0x1a0
> >   [  354.352279]  ? handle_bug+0x3c/0x80
> >   [  354.355787]  ? exc_invalid_op+0x17/0x70
> >   [  354.359635]  ? asm_exc_invalid_op+0x1a/0x20
> >   [  354.363844]  ? __flush_work.isra.0+0x23a/0x250
> >   [  354.368307]  ? srso_return_thunk+0x5/0x5f
> >   [  354.372331]  ? srso_return_thunk+0x5/0x5f
> >   [  354.376351]  ? desc_read_finalized_seq+0x1f/0x70
> >   [  354.380982]  ? srso_return_thunk+0x5/0x5f
> >   [  354.385011]  ? _prb_read_valid+0x20e/0x280
> >   [  354.389130]  __cancel_work_timer+0xd3/0x160
> >   [  354.393333]  drm_sched_stop+0x46/0x1f0 [gpu_sched]
> >   [  354.398143]  amdgpu_device_gpu_recover+0x318/0xca0 [amdgpu]
> >   [  354.403995]  ? __drm_err+0x1/0x70 [drm]
> >   [  354.407884]  amdgpu_job_timedout+0x151/0x240 [amdgpu]
> >   [  354.413279]  drm_sched_job_timedout+0x76/0x100 [gpu_sched]
> >   [  354.418787]  process_one_work+0x174/0x340
> >   [  354.422816]  worker_thread+0x27b/0x3a0
> >   [  354.426586]  ? __pfx_worker_thread+0x10/0x10
> >   [  354.430874]  kthread+0xe8/0x120
> >   [  354.434030]  ? __pfx_kthread+0x10/0x10
> >   [  354.437790]  ret_from_fork+0x34/0x50
> >   [  354.441377]  ? __pfx_kthread+0x10/0x10
> >   [  354.445139]  ret_from_fork_asm+0x1b/0x30
> >   [  354.449079]  </TASK>
> >   [  354.451285] ---[ end trace 0000000000000000 ]---
> >   [  354.455917] BUG: kernel NULL pointer dereference, address: 0000000=
000000008
> >   [  354.462883] #PF: supervisor read access in kernel mode
> >   [  354.468029] #PF: error_code(0x0000) - not-present page
> >   [  354.473167] PGD 0 P4D 0
> >   [  354.475705] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >   [  354.480066] CPU: 1 PID: 11 Comm: kworker/u64:0 Tainted: G        W=
          6.7.0-991912.1.zuul.e7596ab24dae4bb686e58b0f1e7842da #1
> >   [  354.491883] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIO=
S V1.03.B10 04/01/2019
> >   [  354.499976] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gp=
u_sched]
> >   [  354.506855] RIP: 0010:drm_sched_stop+0x61/0x1f0 [gpu_sched]
> >
> >    The solution is every place where we check the ready flag and check
> >   for ring->no_scheduler. The ready flag serves the purpose in case an =
initialization
> >   is failed, like starting the worker thread, etc.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> > ---
> >   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 +++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 14 ++++++++-----=
-
> >   3 files changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > index 899e31e3a5e8..70bbf602df34 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > @@ -292,6 +292,8 @@ static int suspend_resume_compute_scheduler(struct =
amdgpu_device *adev, bool sus
> >
> >               if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
> >                       continue;
> > +             if (ring->no_scheduler)
> > +                     continue;
> >
> >               /* stop secheduler and drain ring. */
> >               if (suspend) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index e485dd3357c6..35132aa2c0f4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq=
_file *m, void *unused)
> >       for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> >               struct amdgpu_ring *ring =3D adev->rings[i];
> >
> > -             if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> > +             if (!ring || ring->no_scheduler || !drm_sched_wqueue_read=
y(&ring->sched))
> >                       continue;
> >               drm_sched_wqueue_stop(&ring->sched);
> >       }
> > @@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq=
_file *m, void *unused)
> >       for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> >               struct amdgpu_ring *ring =3D adev->rings[i];
> >
> > -             if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> > +             if (!ring || ring->no_scheduler || !drm_sched_wqueue_read=
y(&ring->sched))
> >                       continue;
> >               drm_sched_wqueue_start(&ring->sched);
> >       }
> > @@ -1916,7 +1916,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, =
u64 val)
> >
> >       ring =3D adev->rings[val];
> >
> > -     if (!ring || !ring->funcs->preempt_ib ||
> > +     if (!ring || !ring->funcs->preempt_ib || ring->no_scheduler ||
> >           !drm_sched_wqueue_ready(&ring->sched))
> >               return -EINVAL;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 2df14f0e79d8..894b657df1d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5052,7 +5052,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_=
device *adev)
> >       for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >               struct amdgpu_ring *ring =3D adev->rings[i];
> >
> > -             if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> > +             if (!ring || ring->no_scheduler || !drm_sched_wqueue_read=
y(&ring->sched))
> >                       continue;
> >
> >               spin_lock(&ring->sched.job_list_lock);
> > @@ -5191,8 +5191,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_d=
evice *adev,
> >       for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >               struct amdgpu_ring *ring =3D adev->rings[i];
> >
> > -             if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> > +             if (!ring || ring->no_scheduler || !drm_sched_wqueue_read=
y(&ring->sched))
> >                       continue;
> > +              if (ring->no_scheduler)
> > +                      continue;
> >
> >               /* Clear job fence from fence drv to avoid force_completi=
on
> >                * leave NULL and vm flush fence in fence drv
> > @@ -5658,7 +5660,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >               for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >                       struct amdgpu_ring *ring =3D tmp_adev->rings[i];
> >
> > -                     if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> > +                     if (!ring || ring->no_scheduler || !drm_sched_wqu=
eue_ready(&ring->sched))
> >                               continue;
> >
> >                       drm_sched_stop(&ring->sched, job ? &job->base : N=
ULL);
> > @@ -5727,7 +5729,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >               for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >                       struct amdgpu_ring *ring =3D tmp_adev->rings[i];
> >
> > -                     if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> > +                     if (!ring || ring->no_scheduler || !drm_sched_wqu=
eue_ready(&ring->sched))
> >                               continue;
> >
> >                       drm_sched_start(&ring->sched, true);
> > @@ -6082,7 +6084,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct=
 pci_dev *pdev, pci_channel_sta
> >               for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >                       struct amdgpu_ring *ring =3D adev->rings[i];
> >
> > -                     if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> > +                     if (!ring || ring->no_scheduler || !drm_sched_wqu=
eue_ready(&ring->sched))
> >                               continue;
> >
> >                       drm_sched_stop(&ring->sched, NULL);
> > @@ -6224,7 +6226,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
> >       for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >               struct amdgpu_ring *ring =3D adev->rings[i];
> >
> > -             if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> > +             if (!ring || ring->no_scheduler || !drm_sched_wqueue_read=
y(&ring->sched))
> >                       continue;
> >
> >               drm_sched_start(&ring->sched, true);
>
