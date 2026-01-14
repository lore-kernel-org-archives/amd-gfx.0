Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B3ED38FE9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF6610E651;
	Wed, 14 Jan 2026 16:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CkdFLAPb";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4255010E651
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:36:56 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1233bc11279so24711c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 08:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768408615; cv=none;
 d=google.com; s=arc-20240605;
 b=THmEuKSZ46rhLn+pzsU1p7NxxCnBBsba4L1r51+caAa570Fsu7qPk5ExMs1WRq3lTd
 KeSI9wCLTctsdlMaJOi6oBcQwzQXNq+zjoo7e11D8ZWtrL1tcjU37dQ2ihE3YDBoz8az
 zaSEpa0Gk2eRRsBn7J9eZ363bwuElplsLOW+rs5BmQDJv210B5QvkgBI1WP6Ldvh8w+k
 0ywOeORLIFnKVCG4UAdN5nRMvTM3QxMFwkRTfIRlzxl4egn/pxNL9SY7J0W7gsLKFT8T
 0sNRiwBzKnC0PpMepxlfwL2cgqqQkiT+Epxw9zs+rFZcbr+MECoGnoAen8/bASWdqevc
 brBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5A93CSIZrMw6etjsHl7A2FO98Ispb4UaIMjrAZz//HA=;
 fh=xq6EPdmQT5uJjDXZ2buWH1xN4a3L0xqYvypv346+Mxw=;
 b=DgN8eN4CFEyRRzUyPdxYkNCyNNOhc9e/XyoAUHuVZlNp5S0eWSanZUHbrrwFcFjHYw
 DlapdeVSJy3rhsaPGcp1NzpROn5MZ+HarRtmXtqVs8aGoFj2zLjEL6MmDvK7QcYnBIqg
 BbF81sTSCl65yI/E1mMJDf1uAYrDkLKjE3wPvbSkpU2412MUlK0NUMY2ecO5IklSRfn0
 UT5F4FRLp2Fj03b3Agy/6oGPxUWuoU7f9/3va3VcZZZ+4ge++TH3hCA6koNXuGFhCGaL
 M1dZtx7Vm7m4gCztO07ICxF9OuOANwAHiIA5aFY+zlElyPSBJSFK1XtglNTpVha+CG6A
 VjmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768408615; x=1769013415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5A93CSIZrMw6etjsHl7A2FO98Ispb4UaIMjrAZz//HA=;
 b=CkdFLAPbgaKiQv7HiVQkMDnkTEcCaG/XgJEtlHM+p1ccOmbpfpgYhHE/pWPHOr3q/c
 Uez+caxYeV0XhLeE3x4Df25E1smjXv0ZmceIJ8OIp8k8xfpgS2mvGeqxVP6RoiB36SFg
 fO1qnYRKsh7zNjkuxWCC3vG/2EbzD5GEkYZzBo81lfXul815AtJlvLHwwavdz2XH5Cot
 WYvN99UuV8LPWf4svyDk/OjFFKR8bNIygHnWlJFMX1ZuXpxXz0pyHW8PMvAxGb2SMH27
 Sta5nvc30WP0Kxl8Y7Sm1UM9VudPtfsdmNUanwtSSH1hjy4xuGZw/rrBGbUGRw1OhNFG
 RIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768408615; x=1769013415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5A93CSIZrMw6etjsHl7A2FO98Ispb4UaIMjrAZz//HA=;
 b=ky9JZEenicOzGTNcyI8GwxFVMaBQ3RvP+Q5y/RoUJ7chHgMm+7MtrT5xiu8Tr2jgpd
 +jkwSdygOqQaNSv8l4OE8lf1lID9POjm9S5/9nRKjbEtLQTlzD/IrGvg+Se4cv07Y/Oc
 UowfNBfHaVMcl0K7yYWLjmBXT3/XXtd9dVhubaWcl3YFzX6PMGixLc1cXMNsqxg7XpHk
 GID3xSeGWOCu5jLchNhxa4ZZIw4nMwFsXb8df/9/FKuLW/MfLw3gfeE7Ma/n6+KVffCJ
 +0E8PNJ+toJceYxqq86D84A85u54LEA2KDOUbBMlqthRv15xWDYWV/twYzhr5PJ0jf3h
 cJIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcrFKAeeqZUJM/P3ej+5/aBVrbn2VAOfJX3UJpRmCGlUQl6R/dU3IP567EUZ+vzksCIkXzbRSH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7tTLi/9KPcM7AzmiQoiEA0Z2aXNq6EWLTXmLoDBcBkdg0Er/B
 cLghekOAt8zr9D1Elr5yhbXVs4nZMInoxX5OVsli4UP5FyqklTFmNg8q7KzWBKqHqLru6sL6gWI
 4ALqE0fMED1ecDGHovRDGMDS54UEVv2bP0A==
X-Gm-Gg: AY/fxX4RSNDq4QnnClcJD0y1iGviVLZF6zz258/ZUuMUtpur9sTetJQVewkBbqDBYzB
 BCMF7kWf3IC5UzrKXlTRK1Deq0qNRwVa5sgy2O7Eh7Rl+r8lFmPtdeF84CJ3IpjsGO1OnGyUVBx
 Fv7pPC+X1f5X1Si7v8M+nvwiLC2wKA1n07jqtZ4GDql6ivid06vVnM7Rgw3lTjX0Lok5PMtBlfH
 yq6saK8iJV46545xgJQrtjuqdUX7GV2Dj/ss9iq6MunPfdd+fRINiRr1/WeMRSM6Fm5B6OV
X-Received: by 2002:a05:7022:f8d:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-12336ad5f3bmr1819589c88.7.1768408615302; Wed, 14 Jan 2026
 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
 <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
 <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
 <CADnq5_PoHgp_Pf7EsV_bRwmh0Q7GuWfnEW-3Pp0gscT80VAnLg@mail.gmail.com>
 <6bbdb38b-75d0-4867-b4b6-afa5dc0b479e@amd.com>
In-Reply-To: <6bbdb38b-75d0-4867-b4b6-afa5dc0b479e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jan 2026 11:36:43 -0500
X-Gm-Features: AZwV_QiSknmmRN5xjQ0C3eGicHnUIr8lbVgbtddf0Uc3tfX80zGxUr5uBiuMabo
Message-ID: <CADnq5_Nm+E3trPt7LLUMBC697Upjnm6y46vdyXwBLxb_PHLxCQ@mail.gmail.com>
Subject: Re: [PATCH 00/42] Improvements for IB handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Jan 14, 2026 at 5:45=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 1/13/26 23:36, Alex Deucher wrote:
> > On Tue, Jan 13, 2026 at 10:34=E2=80=AFAM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> >>
> >> On Tue, Jan 13, 2026 at 9:48=E2=80=AFAM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >>>
> >>> On 1/13/26 15:10, Alex Deucher wrote:
> >>>> On Tue, Jan 13, 2026 at 8:57=E2=80=AFAM Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com> wrote:
> >>>>>
> >>>>> Patches #1-#3: Reviewed-by: Christian K=C3=B6nig <christian.koenig@=
amd.com>
> >>>>>
> >>>>> Comment on patch #4 which also affects patches #5-#26.
> >>>>>
> >>>>> Comment on patch #27 and #28. When #28 comes before #27 then that w=
ould potentially solve the issue with #27.
> >>>>>
> >>>>> Patches #31: Reviewed-by: Christian K=C3=B6nig <christian.koenig@am=
d.com>
> >>>>>
> >>>>> Patches #32-#40 that looks extremely questionable to me. I've inten=
tionally removed that state from the job because it isn't job dependent and=
 sometimes has inter-job meaning.
> >>>>>
> >>>>> Patch #41: Absolutely clear NAK! We have exercised that nonsense to=
 the max and I'm clearly against doing that over and over again. Saving the=
 ring content clearly seems to be the saver approach.
> >>>>>
> >>>>
> >>>> I disagree.  If the ring emit functions are purely just emitting
> >>>> packets to the ring, it's a much cleaner approach than trying to sav=
e
> >>>> and restore packet sequences repeatedly.
> >>>
> >>> Exactly that's the problem, this is not what they do.
> >>>
> >>> See gfx_v11_0_ring_emit_gfx_shadow() for an example:
> >>>
> >>> ...
> >>>         /*
> >>>          * We start with skipping the prefix SET_Q_MODE and always ex=
ecuting
> >>>          * the postfix SET_Q_MODE packet. This is changed below with =
a
> >>>          * WRITE_DATA command when the postfix executed.
> >>>          */
> >>>         amdgpu_ring_write(ring, shadow_va ? 1 : 0);
> >>>         amdgpu_ring_write(ring, 0);
> >>>
> >>>         if (ring->set_q_mode_offs) {
> >>>                 uint64_t addr;
> >>>
> >>>                 addr =3D amdgpu_bo_gpu_offset(ring->ring_obj);
> >>>                 addr +=3D ring->set_q_mode_offs << 2;
> >>>                 end =3D gfx_v11_0_ring_emit_init_cond_exec(ring, addr=
);
> >>>         }
> >>> ...
> >>>         if (shadow_va) {
> >>>                 uint64_t token =3D shadow_va ^ csa_va ^ gds_va ^ vmid=
;
> >>>
> >>>                 /*
> >>>                  * If the tokens match try to skip the last postfix S=
ET_Q_MODE
> >>>                  * packet to avoid saving/restoring the state all the=
 time.
> >>>                  */
> >>>                 if (ring->set_q_mode_ptr && ring->set_q_mode_token =
=3D=3D token)
> >>>                         *ring->set_q_mode_ptr =3D 0;
> >>>
> >>>                 ring->set_q_mode_token =3D token;
> >>>         } else {
> >>>                 ring->set_q_mode_ptr =3D &ring->ring[ring->set_q_mode=
_offs];
> >>>         }
> >>>
> >>>         ring->set_q_mode_offs =3D offs;
> >>> }
> >>>
> >>> Executing this multiple times is simply not possible without saving s=
et_q_mode_offs, the token and the CPU pointer (and restoring the CPU pointe=
r content).
> >>>
> >>> And that is just the tip of the iceberg, we have tons of state like t=
his.
> >>
> >> There is not much more than that.  I looked when I wrote these
> >> patches.  Even this state should be handled correctly.  In this case,
> >> the state is saved in the job at the original submission time and is
> >> explicitly passed to the emit ring functions.  As such the original
> >> state is reproduced.  In this case, ring->set_q_mode_offs and
> >> ring->set_q_mode_ptr get reset in gfx_v11_0_ring_emit_vm_flush().
> >> Then they get set as appropriate based on the saved state in the job
> >> in gfx_v11_0_ring_emit_gfx_shadow().  It emits the same ring state
> >> again.
> >>
> >
> > I just fixed up the set_q handling locally.  I added a helper which
> > saves the state of the ring (any ring->set_q values, etc.) in the job
> > before we schedule the IB.  Then after the reset I restore the ring
> > state before re-emitting the IB state.
>
> Exactly that doesn't work.
>
> See the set_q_mode handling works by looking at the next job in the queue=
 and determining based in PM4 code if executing the packet is necessary or =
not.
>
> When we drop some jobs from execution because they belong to the same con=
text as the one who caused the timeout we write incorrect commands into the=
 PM4 stream when re-emitting.
>
> We would need to extend the handling in a way where we can say ok this jo=
b is now skipped, but we need to pretend that it isn't so that the set_q_mo=
de handling works and then still not execute the IBs in the job.
>

Explicit re-emit is the only way this can easily work correctly.  We
save the ring state and and job state in the job and then we replay
the state and re-emit a proper coherent packet stream after the reset.
When we re-emit, we update the offsets as appropriate so that the
logic works properly as you replay the job stream.  You can skip the
IBs for the timedout context, but as long as the rest of the logic is
there, everything works.  Saving and restoring the opaque ring
contents is much harder because you need to either save a bunch of
pointers or try and determine which offsets to patch, etc.

Alex

> Long story short that is seriously not going to work. So absolutely clear=
 NAK from my side to this approach.
>
> What we could do to avoid problems and patching pointers in the command s=
tream is to emit only the fence signaling for skipped jobs and fill everyth=
ing else with NOPs.
>
> Regards,
> Christian.
>
> >  At that point the ring has the
> > same state it had before the queue was reset and the state gets
> > updated in the ring as the IBs are reemitted.
> >
> > That's it.  The only other state dependent on the ring was the seq
> > number to wait on for pipeline sync and I fixed that by making it
> > explicit.
> >
> > Alex
> >
> >>>
> >>>> If the relevant state is
> >>>> stored in the job, you can re-emit it and get the same ring state ea=
ch
> >>>> time.
> >>>
> >>> No, you can't. Background is that the relevant state is not job depen=
dent, but inter job dependent.
> >>>
> >>> In other words it doesn't depend on what job is executing now but rat=
her which one was executed right before that one.
> >>>
> >>> Or even worse in the case of the set_q_mode packet on the job depende=
nt after the one you want to execute.
> >>>
> >>> I can absolutely not see how stuff like that should work with re-subm=
ission.
> >>
> >> All you need to do is save the state that was used to emit the packets
> >> in the original submission.
> >>
> >>>
> >>>> If you end up with multiple queue resets in a row, it gets
> >>>> really complex to try and save and restore opaque ring contents.  By
> >>>> the time you fix up the state tracking to handle that, you end up
> >>>> pretty close to this solution.
> >>>
> >>> Not even remotely, you have tons of state we would need to save and r=
estore and a lot of that is outside of the job.
> >>>
> >>> Updating a few fence pointers on re-submission is absolutely trivial =
compared to that.
> >>
> >> It's not that easy.  If you want to just emit the fences for bad
> >> contexts rather than the whole IB stream, you can also potentially
> >> mess up the ring state.  You'd end up needing a pile of pointers that
> >> need to be recalculated on every reset to try and remit the
> >> appropriate state again.  This approach also paves the way for
> >> re-emitting state for all queues after adapter reset when VRAM is not
> >> lost.
> >>
> >> Alex
> >>
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Alex
> >>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>> On 1/8/26 15:48, Alex Deucher wrote:
> >>>>>> This set contains a number of bug fixes and cleanups for
> >>>>>> IB handling that I worked on over the holidays.
> >>>>>>
> >>>>>> Patches 1-2:
> >>>>>> Simple bug fixes.
> >>>>>>
> >>>>>> Patches 3-26:
> >>>>>> Removes the direct submit path for IBs and requires
> >>>>>> that all IB submissions use a job structure.  This
> >>>>>> greatly simplifies the IB submission code.
> >>>>>>
> >>>>>> Patches 27-42:
> >>>>>> Split IB state setup and ring emission.  This keeps all
> >>>>>> of the IB state in the job.  This greatly simplifies
> >>>>>> re-emission of non-timed-out jobs after a ring reset and
> >>>>>> allows for re-emission multiple times if multiple resets
> >>>>>> happen in a row.  It also properly handles the dma fence
> >>>>>> error handling for timedout jobs with adapter resets.
> >>>>>>
> >>>>>> Alex Deucher (42):
> >>>>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
> >>>>>>   drm/amdgpu: fix error handling in ib_schedule()
> >>>>>>   drm/amdgpu: add new job ids
> >>>>>>   drm/amdgpu/vpe: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx6: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx7: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx8: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx9: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx10: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx11: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx12: switch to using job for IBs
> >>>>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
> >>>>>>   drm/amdgpu/si_dma: switch to using job for IBs
> >>>>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma3: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma4: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma5: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma6: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma7: switch to using job for IBs
> >>>>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
> >>>>>>   drm/amdgpu: require a job to schedule an IB
> >>>>>>   drm/amdgpu: mark fences with errors before ring reset
> >>>>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
> >>>>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
> >>>>>>   drm/amdgpu: drop drm_sched_increase_karma()
> >>>>>>   drm/amdgpu: plumb timedout fence through to force completion
> >>>>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
> >>>>>>   drm/amdgpu: drop extra parameter for vm_flush
> >>>>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
> >>>>>>   drm/amdgpu: store vm flush state in amdgpu_job
> >>>>>>   drm/amdgpu: split fence init and emit logic
> >>>>>>   drm/amdgpu: split vm flush and vm flush emit logic
> >>>>>>   drm/amdgpu: split ib schedule and ib emit logic
> >>>>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
> >>>>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
> >>>>>>   drm/amdgpu: rework reset reemit handling
> >>>>>>   drm/amdgpu: simplify per queue reset code
> >>>>>>
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++-----=
-----
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
> >>>>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> >>>>>>  54 files changed, 952 insertions(+), 966 deletions(-)
> >>>>>>
> >>>>>
> >>>
>
