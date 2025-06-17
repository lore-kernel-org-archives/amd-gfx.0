Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5500C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 13:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1CF10E68A;
	Tue, 17 Jun 2025 13:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+RcMI1p";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521D210E68A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 13:09:20 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-313862d48e7so1032064a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750165760; x=1750770560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2URo6I/0t9AT9Q3gtq4R+ZtsMtMjiUY3Sc79u/0emBg=;
 b=X+RcMI1pHf9phb2+BntwqiIUr+awEiEu8VVxPrae0E/NaeNRZaO1PAZPDbR/hfdxrx
 xt9ZdRh90C3IwxxW6vOwrKw0rq+UMPr/rcm/XtBd9rVHOK8JhlWzvdayuBV5bAFcBpcT
 GGmfunPj4DGwH1vXXRt8K5iaoHGhTnGY7p+1NwWZqSXo6TKJLz14qbCmn/94I8104zad
 h1UpNuR9LUcFK5XdHiVr1qoos5cHDx5lKRo0V0bTWssGwsqShwKBA4LdTeFlDI8KYf+D
 A5IetndFRM98Xc9FzLtDi2OVAz+640FLdD0rbB/Gz3LcdFF/VehMJVjmDOn6scSUiIKS
 8dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750165760; x=1750770560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2URo6I/0t9AT9Q3gtq4R+ZtsMtMjiUY3Sc79u/0emBg=;
 b=A6rLwPEBqOoUIDINuahDOPPt1EtJly8XSrfxc0fpoQCL7qwQ41iM89b6CAeK18o+gD
 O0xHmcWZdiLmyAaXMNvWHNg8m69JBe0Jk+3rXO+FIxA+b+7V4/3iNcePoq7feFkOq3Ty
 u0n5G+BT283LNng26vvrH3iVjz/8y1yloopWOXh59L+Du9k0SB01yfEY6KCepguWi3s7
 mXRvx+fE1V4l9BQ4DR295I9cFUN/U1Xv1VzNEX1DFbJTTy9NIo1gp9fcFelyRPdcOuI3
 8KvQ68/Uhy0vLkon8QTZTXgFzsb4XUW2aLvtdyawxAtaCMIGO5+1AznyzWIxvd60iCAY
 bstA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaVPBiWOWTHviiSuWiv+4yYguh4wXvPBWVJoD/YR2a4qnomYuTy/7XUcjoVq5bLaxPj8WNaK80@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8F+QxkHw624PcfNwwbxHYFjtkNQjwWt3VvZpB1mC4tPv9U69p
 6myCjeqquuqXaJ/Aryey7ONzDe2VZsTTKEYdP21QU60qXRcHz9275vHpfdNZsaRsDouPHurMwDP
 NFFo7v2RKxZeU1GV4DeFEOZHmePn2RLeiEA==
X-Gm-Gg: ASbGncslZ9qF+50WvQsRIQVotgjTUc9wEyOPDN5G6r7eH92XKIzLmUzAES079a0MhQ+
 SO7joPyvyRqWRc8LpQvcj35DDRv+fgfVVGr+b6XEWDLQiSajqH1q+vgUgXLDSOAZGsydOMlXlXQ
 nIH79fcl5s9VpxBGUnvBXoFezw5XtDOX4XPz8Cpko6rjoJ
X-Google-Smtp-Source: AGHT+IFKmwd80XoH4tM1AOVIS6dS4TjwqTcJ6TQeNIu77PlycpKc217qt72d+3CLbcjy6pdQrG8v6P9l1YOhZhn8Jww=
X-Received: by 2002:a17:90b:1c04:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-313f1df630amr7324519a91.5.1750165759608; Tue, 17 Jun 2025
 06:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-34-alexander.deucher@amd.com>
 <351309f3-eb1e-4601-a2c4-51482bbeedda@amd.com>
 <575d165b-f587-4a58-9610-f40ce6f52017@amd.com>
In-Reply-To: <575d165b-f587-4a58-9610-f40ce6f52017@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 09:09:08 -0400
X-Gm-Features: AX0GCFv2q-M-wrWVZMeF2hIe5TICoOgBL-WhLWW3Glcwb1faK5utRrHbqcXpbf0
Message-ID: <CADnq5_M=iU_KaVfN_VmVySN9ZHFAzzHipTz+4cM8FSstAK+nRQ@mail.gmail.com>
Subject: Re: [PATCH 33/36] drm/amdgpu/vcn: add a helper framework for engine
 resets
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com
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

On Tue, Jun 17, 2025 at 2:10=E2=80=AFAM Sundararaju, Sathishkumar
<sasundar@amd.com> wrote:
>
> Please ignore my previous comments here, the new helper additions for
> vcn non unified queues are good.
>
> But one concern, the vinst->reset(vinst) callback must take in ring
> pointer to handle guilty/non-guilty
> for appropriate re-emit part, else the guilty ring has to be tracked
> within the ring structure or identified
> by some query with in reset.

I wasn't sure if we could handle the reemit properly on these VCN
chips.  So at least for the first iteration, I just killed all the
queues.  Is there a way to know which ring caused the hang?  How does
the VCN firmware handle the rings?

Alex

>
> Regards,
> Sathish
>
>
> On 6/17/2025 10:00 AM, Sundararaju, Sathishkumar wrote:
> > Hi Alex,
> >
> > Would it be good to have this logic in the reset call back itself ?
> >
> > Adding common vinst->reset stops the flexibility of having separate
> > reset functionality for enc rings and decode rings,
> > can selectively handle the drm_sched_wqueue_start/stop and re-emit of
> > guilty/non-guilty for enc and dec separately.
> >
> > And the usual vcn_stop() followed by vcn_start() isn't helping in
> > reset of the engine for vcn3.
> >
> > I tried a workaround to pause_dpg and enable static clockgate and
> > powergate, and then stop()/start() the engine
> > which is working consistently so far.
> >
> > Regards,
> > Sathish
> >
> > On 6/17/2025 8:38 AM, Alex Deucher wrote:
> >> With engine resets we reset all queues on the engine rather
> >> than just a single queue.  Add a framework to handle this
> >> similar to SDMA.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++++++++++=
++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 ++-
> >>   2 files changed, 69 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >> index c8885c3d54b33..075740ed275eb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >> @@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device
> >> *adev, int i)
> >> mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> >>       mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> >> +    mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
> >>       atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> >>       INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work,
> >> amdgpu_vcn_idle_work_handler);
> >> atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> >> @@ -1451,3 +1452,66 @@ int vcn_set_powergating_state(struct
> >> amdgpu_ip_block *ip_block,
> >>         return ret;
> >>   }
> >> +
> >> +/**
> >> + * amdgpu_vcn_reset_engine - Reset a specific VCN engine
> >> + * @adev: Pointer to the AMDGPU device
> >> + * @instance_id: VCN engine instance to reset
> >> + *
> >> + * Returns: 0 on success, or a negative error code on failure.
> >> + */
> >> +static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
> >> +                   uint32_t instance_id)
> >> +{
> >> +    struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[instance_id];
> >> +    int r, i;
> >> +
> >> +    mutex_lock(&vinst->engine_reset_mutex);
> >> +    /* Stop the scheduler's work queue for the dec and enc rings if
> >> they are running.
> >> +     * This ensures that no new tasks are submitted to the queues whi=
le
> >> +     * the reset is in progress.
> >> +     */
> >> +    drm_sched_wqueue_stop(&vinst->ring_dec.sched);
> >> +    for (i =3D 0; i < vinst->num_enc_rings; i++)
> >> + drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
> >> +
> >> +    /* Perform the VCN reset for the specified instance */
> >> +    r =3D vinst->reset(vinst);
> >> +    if (r) {
> >> +        dev_err(adev->dev, "Failed to reset VCN instance %u\n",
> >> instance_id);
> >> +    } else {
> >> +        /* Restart the scheduler's work queue for the dec and enc rin=
gs
> >> +         * if they were stopped by this function. This allows new tas=
ks
> >> +         * to be submitted to the queues after the reset is complete.
> >> +         */
> >> +        drm_sched_wqueue_start(&vinst->ring_dec.sched);
> >> +        for (i =3D 0; i < vinst->num_enc_rings; i++)
> >> + drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
> >> +    }
> >> +    mutex_unlock(&vinst->engine_reset_mutex);
> >> +
> >> +    return r;
> >> +}
> >> +
> >> +/**
> >> + * amdgpu_vcn_ring_reset - Reset a VCN ring
> >> + * @ring: ring to reset
> >> + * @vmid: vmid of guilty job
> >> + * @guilty_fence: guilty fence
> >> + *
> >> + * This helper is for VCN blocks without unified queues because
> >> + * resetting the engine resets all queues in that case.  With
> >> + * unified queues we have one queue per engine.
> >> + * Returns: 0 on success, or a negative error code on failure.
> >> + */
> >> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
> >> +              unsigned int vmid,
> >> +              struct amdgpu_fence *guilty_fence)
> >> +{
> >> +    struct amdgpu_device *adev =3D ring->adev;
> >> +
> >> +    if (adev->vcn.inst[ring->me].using_unified_queue)
> >> +        return -EINVAL;
> >> +
> >> +    return amdgpu_vcn_reset_engine(adev, ring->me);
> >> +}
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >> index 83adf81defc71..0bc0a94d7cf0f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >> @@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
> >>                     struct dpg_pause_state *new_state);
> >>       int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
> >>                   enum amd_powergating_state state);
> >> +    int (*reset)(struct amdgpu_vcn_inst *vinst);
> >>       bool using_unified_queue;
> >> +    struct mutex        engine_reset_mutex;
> >>   };
> >>     struct amdgpu_vcn_ras {
> >> @@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct
> >> amdgpu_device *adev);
> >>     int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
> >>                     enum amd_powergating_state state);
> >> -
> >> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
> >> +              unsigned int vmid,
> >> +              struct amdgpu_fence *guilty_fence);
> >>   #endif
> >
>
