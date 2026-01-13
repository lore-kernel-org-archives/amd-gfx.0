Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC7CD30CE5
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 22:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456A410E560;
	Tue, 13 Jan 2026 22:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ektnzjk9";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A212B10E560
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 22:36:47 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-11ddccf4afdso603557c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 14:36:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768343807; cv=none;
 d=google.com; s=arc-20240605;
 b=LljjFtEqB3o0M14FoaRX0WEzIkwuMAJ5W6KOCqFHxqyp5rr4dz9ETIDXKXh22voGM5
 PM7WsqWk+mu5j4llYZVYHRS/Ia1RCHYCLiODzNUQRg0uIfLN2kRG5G4BF2a4N2xgsCJa
 bzp72rTFatILwxrpqNAqt2TaHfIn/dx4NhiaAUMMWQrDz7/Ivs798XFxUNCnFaGbX21P
 yt+PEh6ekyGN0hfs33g/r24ZSzfxDgtOHOU73aBZNLh+Jv84fT3XSiqh8GHERk+SMV1c
 SzfNb6UNh8l1n73fX/mGyDr+wp0FnrROtznSu7Kto8drAr9gDcdXMQNzjn/i+gIh2zCK
 ulmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3ZXXvl8MW+WkOof6Up5h82hKv+dC/frCuxRqekFvRXs=;
 fh=tIVNZ9VZaYnAcsPZMZPrFk/flczwuu3rQEjeX8JGjKg=;
 b=BnByFeEyaWQ/+Dr/L0tMQ9Ee5ubZrbt2NgWLbQM/xGYsiyff89DXhmq0m3o+ZpeR7/
 4NhC0UWvA9y67lNbih6IC9SYrIrVEJ7ulyhtzORGF49vlItGnPufGp7SMLTLzPReYvNW
 QKrrVC2bAHKCKoodB/OUsOhOhyy0/b6kxcf99VzdInmnARnJBXrwyA34KbbN/3ikJTGa
 l+yWIbOUDls4dfbJgksjSY4+MnG+yeDbPlWvOp5VjXO2IbtDcK6gPZVYxOazLQIR+6R1
 MMvEJpcPSipjwlV1dhoiW0IK7E0jtqK7c6RXvoL6Bj5OZASgep++iGPDx8bKTHv9oRgz
 V6wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768343807; x=1768948607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZXXvl8MW+WkOof6Up5h82hKv+dC/frCuxRqekFvRXs=;
 b=Ektnzjk9BKD8fsKbpUqX1ZoBwsn5qlKU1EXqZir9kQmLTvwtycHgY1sjBJjXJkVzrl
 xd3VuZ4t9MgWYqzEmotsyiSe0A2t9X9mCeuRbCybDQ/ckpo4/3Pvab28uEj74fLdCbyp
 4jPjRbVgm+fuYo+XnzuNo7q+iiE0DV1dIh8iTzbtyybxQMDl1AY1R3ww9ZemDra74m/y
 tcIjjBxnnS9Z2yjkNAhmSr7lnX3nzknSK8kg4Krznh6Rca2brjpnALizHuqrNGbYYiM5
 d8ltD8kVXo3Mnn0+rux3DSqFi5qedMaJvrCl9sQEya6RwGq36Cc2OuJfWDybAT4VO5/o
 bKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768343807; x=1768948607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ZXXvl8MW+WkOof6Up5h82hKv+dC/frCuxRqekFvRXs=;
 b=mPDiPBg21QVc8QBfnM34SiuF/2yEa6mo6AdRcFbf3r3RisnrckylSf/8tEiEjpfqBX
 dBhKSpPgyakvJ47htKePrhPF33+4LNzGTg1kUqSR/TMLHx+el0seZ6XrR4GVI7tUju6o
 QmtqFr6wpjV23E9t9VE38dx+zGyZi+79VgjUcjft+h7tsAQjrX22k6dCN9+6If9fOxk5
 78dlBYBQEeqxADlrlhxctL6cIq7VI/h/4AJtsE71BJJ20uYpKSh8u6jaAVymixjnlIz1
 tD/4oIPhXRDyvFqkEORNrJhCo3R5S9NsqNK8JgDaL96gXKIQWgNV/6IvR7PJZeaMNPMP
 pL7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVPXEd6CkLQ4VJ7hVYodnSSbWiMXQV95BuYQk+kxtL7ch3kt1Ci8C7ksVCPVJ+JOXcY0mEFIZ4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpN52wt3tKVYklr75O4GUtP5VPbydJgWwXb3hmlyhdH9Mwr93E
 GMiVDakV31rEuReGm4s65J4DtgqusyCNjJMfZMtmBBgtYln0l9jnyFhia91LQ/cxX6OwS1Ft359
 mIuZJPbafvf7YAFikIJaOL6pDispP4nM=
X-Gm-Gg: AY/fxX7wLeIbhxbEGZKCb7weo0UvBekQKdYQPGoYBnrPLkwqsUSh1CzfbaAFrogsewa
 QVhK7DCAYrHDpk+5x3IfnNe8McaxX4v2rqBY44M4G5e0+FlUxzk0/Woe/VWn/qvnTfsbZ9BYcZ+
 6oMat9D7mYwFX4BveubLU+wJG6us0oLV8Pf3delk1CzBP7xcMiYMYjNGRTSnMKV0nLIl9DPtI2r
 DoZ3Yu6ArtX5+6qv/pd/eiNpqaPtmibpj9mU+10aLv3atIb8saLFasordTNOOMadIFODAbo
X-Received: by 2002:a05:7300:54c:b0:2ac:2b5b:a567 with SMTP id
 5a478bee46e88-2b4871c92d6mr378833eec.6.1768343806584; Tue, 13 Jan 2026
 14:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
 <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
 <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
In-Reply-To: <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 17:36:34 -0500
X-Gm-Features: AZwV_Qj-VntrA4d9h6kj8nDH312m3F2qJNF9pR4rFBZP2AgwQfoGB-2JuTK2728
Message-ID: <CADnq5_PoHgp_Pf7EsV_bRwmh0Q7GuWfnEW-3Pp0gscT80VAnLg@mail.gmail.com>
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

On Tue, Jan 13, 2026 at 10:34=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Jan 13, 2026 at 9:48=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 1/13/26 15:10, Alex Deucher wrote:
> > > On Tue, Jan 13, 2026 at 8:57=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >>
> > >> Patches #1-#3: Reviewed-by: Christian K=C3=B6nig <christian.koenig@a=
md.com>
> > >>
> > >> Comment on patch #4 which also affects patches #5-#26.
> > >>
> > >> Comment on patch #27 and #28. When #28 comes before #27 then that wo=
uld potentially solve the issue with #27.
> > >>
> > >> Patches #31: Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd=
.com>
> > >>
> > >> Patches #32-#40 that looks extremely questionable to me. I've intent=
ionally removed that state from the job because it isn't job dependent and =
sometimes has inter-job meaning.
> > >>
> > >> Patch #41: Absolutely clear NAK! We have exercised that nonsense to =
the max and I'm clearly against doing that over and over again. Saving the =
ring content clearly seems to be the saver approach.
> > >>
> > >
> > > I disagree.  If the ring emit functions are purely just emitting
> > > packets to the ring, it's a much cleaner approach than trying to save
> > > and restore packet sequences repeatedly.
> >
> > Exactly that's the problem, this is not what they do.
> >
> > See gfx_v11_0_ring_emit_gfx_shadow() for an example:
> >
> > ...
> >         /*
> >          * We start with skipping the prefix SET_Q_MODE and always exec=
uting
> >          * the postfix SET_Q_MODE packet. This is changed below with a
> >          * WRITE_DATA command when the postfix executed.
> >          */
> >         amdgpu_ring_write(ring, shadow_va ? 1 : 0);
> >         amdgpu_ring_write(ring, 0);
> >
> >         if (ring->set_q_mode_offs) {
> >                 uint64_t addr;
> >
> >                 addr =3D amdgpu_bo_gpu_offset(ring->ring_obj);
> >                 addr +=3D ring->set_q_mode_offs << 2;
> >                 end =3D gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
> >         }
> > ...
> >         if (shadow_va) {
> >                 uint64_t token =3D shadow_va ^ csa_va ^ gds_va ^ vmid;
> >
> >                 /*
> >                  * If the tokens match try to skip the last postfix SET=
_Q_MODE
> >                  * packet to avoid saving/restoring the state all the t=
ime.
> >                  */
> >                 if (ring->set_q_mode_ptr && ring->set_q_mode_token =3D=
=3D token)
> >                         *ring->set_q_mode_ptr =3D 0;
> >
> >                 ring->set_q_mode_token =3D token;
> >         } else {
> >                 ring->set_q_mode_ptr =3D &ring->ring[ring->set_q_mode_o=
ffs];
> >         }
> >
> >         ring->set_q_mode_offs =3D offs;
> > }
> >
> > Executing this multiple times is simply not possible without saving set=
_q_mode_offs, the token and the CPU pointer (and restoring the CPU pointer =
content).
> >
> > And that is just the tip of the iceberg, we have tons of state like thi=
s.
>
> There is not much more than that.  I looked when I wrote these
> patches.  Even this state should be handled correctly.  In this case,
> the state is saved in the job at the original submission time and is
> explicitly passed to the emit ring functions.  As such the original
> state is reproduced.  In this case, ring->set_q_mode_offs and
> ring->set_q_mode_ptr get reset in gfx_v11_0_ring_emit_vm_flush().
> Then they get set as appropriate based on the saved state in the job
> in gfx_v11_0_ring_emit_gfx_shadow().  It emits the same ring state
> again.
>

I just fixed up the set_q handling locally.  I added a helper which
saves the state of the ring (any ring->set_q values, etc.) in the job
before we schedule the IB.  Then after the reset I restore the ring
state before re-emitting the IB state.  At that point the ring has the
same state it had before the queue was reset and the state gets
updated in the ring as the IBs are reemitted.

That's it.  The only other state dependent on the ring was the seq
number to wait on for pipeline sync and I fixed that by making it
explicit.

Alex

> >
> > > If the relevant state is
> > > stored in the job, you can re-emit it and get the same ring state eac=
h
> > > time.
> >
> > No, you can't. Background is that the relevant state is not job depende=
nt, but inter job dependent.
> >
> > In other words it doesn't depend on what job is executing now but rathe=
r which one was executed right before that one.
> >
> > Or even worse in the case of the set_q_mode packet on the job dependent=
 after the one you want to execute.
> >
> > I can absolutely not see how stuff like that should work with re-submis=
sion.
>
> All you need to do is save the state that was used to emit the packets
> in the original submission.
>
> >
> > > If you end up with multiple queue resets in a row, it gets
> > > really complex to try and save and restore opaque ring contents.  By
> > > the time you fix up the state tracking to handle that, you end up
> > > pretty close to this solution.
> >
> > Not even remotely, you have tons of state we would need to save and res=
tore and a lot of that is outside of the job.
> >
> > Updating a few fence pointers on re-submission is absolutely trivial co=
mpared to that.
>
> It's not that easy.  If you want to just emit the fences for bad
> contexts rather than the whole IB stream, you can also potentially
> mess up the ring state.  You'd end up needing a pile of pointers that
> need to be recalculated on every reset to try and remit the
> appropriate state again.  This approach also paves the way for
> re-emitting state for all queues after adapter reset when VRAM is not
> lost.
>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Alex
> > >
> > >> Regards,
> > >> Christian.
> > >>
> > >> On 1/8/26 15:48, Alex Deucher wrote:
> > >>> This set contains a number of bug fixes and cleanups for
> > >>> IB handling that I worked on over the holidays.
> > >>>
> > >>> Patches 1-2:
> > >>> Simple bug fixes.
> > >>>
> > >>> Patches 3-26:
> > >>> Removes the direct submit path for IBs and requires
> > >>> that all IB submissions use a job structure.  This
> > >>> greatly simplifies the IB submission code.
> > >>>
> > >>> Patches 27-42:
> > >>> Split IB state setup and ring emission.  This keeps all
> > >>> of the IB state in the job.  This greatly simplifies
> > >>> re-emission of non-timed-out jobs after a ring reset and
> > >>> allows for re-emission multiple times if multiple resets
> > >>> happen in a row.  It also properly handles the dma fence
> > >>> error handling for timedout jobs with adapter resets.
> > >>>
> > >>> Alex Deucher (42):
> > >>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
> > >>>   drm/amdgpu: fix error handling in ib_schedule()
> > >>>   drm/amdgpu: add new job ids
> > >>>   drm/amdgpu/vpe: switch to using job for IBs
> > >>>   drm/amdgpu/gfx6: switch to using job for IBs
> > >>>   drm/amdgpu/gfx7: switch to using job for IBs
> > >>>   drm/amdgpu/gfx8: switch to using job for IBs
> > >>>   drm/amdgpu/gfx9: switch to using job for IBs
> > >>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
> > >>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
> > >>>   drm/amdgpu/gfx10: switch to using job for IBs
> > >>>   drm/amdgpu/gfx11: switch to using job for IBs
> > >>>   drm/amdgpu/gfx12: switch to using job for IBs
> > >>>   drm/amdgpu/gfx12.1: switch to using job for IBs
> > >>>   drm/amdgpu/si_dma: switch to using job for IBs
> > >>>   drm/amdgpu/cik_sdma: switch to using job for IBs
> > >>>   drm/amdgpu/sdma2.4: switch to using job for IBs
> > >>>   drm/amdgpu/sdma3: switch to using job for IBs
> > >>>   drm/amdgpu/sdma4: switch to using job for IBs
> > >>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
> > >>>   drm/amdgpu/sdma5: switch to using job for IBs
> > >>>   drm/amdgpu/sdma5.2: switch to using job for IBs
> > >>>   drm/amdgpu/sdma6: switch to using job for IBs
> > >>>   drm/amdgpu/sdma7: switch to using job for IBs
> > >>>   drm/amdgpu/sdma7.1: switch to using job for IBs
> > >>>   drm/amdgpu: require a job to schedule an IB
> > >>>   drm/amdgpu: mark fences with errors before ring reset
> > >>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
> > >>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
> > >>>   drm/amdgpu: drop drm_sched_increase_karma()
> > >>>   drm/amdgpu: plumb timedout fence through to force completion
> > >>>   drm/amdgpu: change function signature for emit_pipeline_sync()
> > >>>   drm/amdgpu: drop extra parameter for vm_flush
> > >>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
> > >>>   drm/amdgpu: store vm flush state in amdgpu_job
> > >>>   drm/amdgpu: split fence init and emit logic
> > >>>   drm/amdgpu: split vm flush and vm flush emit logic
> > >>>   drm/amdgpu: split ib schedule and ib emit logic
> > >>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
> > >>>   drm/amdgpu: add an all_instance_rings_reset ring flag
> > >>>   drm/amdgpu: rework reset reemit handling
> > >>>   drm/amdgpu: simplify per queue reset code
> > >>>
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++------=
----
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
> > >>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
> > >>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> > >>>  54 files changed, 952 insertions(+), 966 deletions(-)
> > >>>
> > >>
> >
