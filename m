Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B9D44C48
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 14:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EC910E76F;
	Thu, 15 Jan 2026 14:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aGRsPDq5";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C56E10E76F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 14:08:16 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1233bc11279so52463c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 06:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768486096; cv=none;
 d=google.com; s=arc-20240605;
 b=duGyFAH0q1Ykz4PX74soCNAGDQRzQMjMtIOVzk/pyUKPJ+18fAc+PRDBGe8tEVGmSL
 VSB/eBNkSSFK86YWQQ6ifGVMDyT8/3pkdeOMM40SPyDtkY42STUoCg8j+FzCbQdh+9Vv
 qvocxufo9Gx3Q+XOAcADO/fILT0GEzwfUy22yWNPB+j6etT8X5Ssp3QcLwQLVGbyrc+R
 IiaWrJ+saO/Spr5iDme5geNiuv62AHBMDBcyEyq61ieNhK8WLA6s6rEXPoHKG1dUnGpi
 FTxAMFpHsZ0ZIfPZ6scY/MOG/kyxvXLcLW5tfwknyEy5nHFO/zEwb4pnIzAYE8X6qAge
 wQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hQ88y/AxlNzRE2zzXGlinUqxtTldozkh0Ax8+GfqHvI=;
 fh=WRwazfNCvRahx3sogGSWv6aorGBoboLocYx23beV+jY=;
 b=BAvJfpjzrdmfGWSrionia6nOZvQgDN2xc1lUZiZhb9+fchPKY8MDWS0CTf5w2EY2L7
 8aOg6lI2g0Q9TZmf3NTFCv5JoVZ7QVH6Az37XiV4TikW+ffcIaAz7fEozS5wBDJf9+H0
 coywQUwQb8Llsw3/+WBL6NoHLnL4WqLsahGXEVOnHV5Laa0JBQIOFTGT0MfcuAJXjAtx
 Y79UgGSQAzXLyjrr09rjXsEVAV+DqNBw0kRUQGAmO1mBo4NFhH7psm79xFmvOoHk2rZC
 rUzbhdpPSpHTkqdrhtlgZDoChP4+WSQQjtBOkxJ886g7NAVBx/wkgtwU5HPJP5cYIhKK
 jQuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768486096; x=1769090896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQ88y/AxlNzRE2zzXGlinUqxtTldozkh0Ax8+GfqHvI=;
 b=aGRsPDq5YmRUhzdeIyBLmL4Dw5VZqMqqPfn8ybgDk6JY0TUnF4C7MI849VoJhavGmm
 DzSo2PMZC7+MkVG7jbVPpcH12hJC/IsT28AYwmQjPk2mmdxwY2nzlo+aX0TPDL4YPs4l
 ScBfQZ75GlbIFKysHS6aDUMWzbe/BYZzezmAcm2i1B77sMUViK1J02W5hXRwCS0GRyqY
 EWxVdhmxKJHh1DQsAwmMpBFD90P3mPoBka1PskjajXgPkcWSBDtbywPB26FsYijMNpj2
 xjVE2JAToy9JwhzYNQB5uboiUKwc3j+bpyZDWEbP/rWmfIp1hNWtQlueb7ls9G/KxvmZ
 mNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768486096; x=1769090896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hQ88y/AxlNzRE2zzXGlinUqxtTldozkh0Ax8+GfqHvI=;
 b=jDpMj21B60zJtoXVvRatPD0fQ88dLIvAh83DQLTLz5YpYEf+zEDOYepe6n1/Vs3lgE
 QMGzJ6DO8axGkfmgP6BB/+8RbGbvf6JVJWJ0kQylhQ8bmf/F56OtisIjFyHilldndpr8
 ElOURRTbyX6YDjJgGeejuBwtKOLtCHSs6hCk9Wi0AzGfgOrX+4rzLT3zlavwdPOjwTL3
 fvoBR80hqQNpV+Kr9ikD8IBx1q7K+KDlkGvPfCGREmrrO6+weN/izjArd3N4dtrP0zN1
 7CNMO+1iGqh0e6mpsEctUqtTgn6wi0RgLD2m1Bn2lMf/A142lG/KcU00ekr3FjDW1AAR
 o/6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4/MOwigZfHDFPNvUkL5EbZsDdmPNNY+5dS7qogIk9TFF7deZkMcPSOzdQea9oycPbwp4l73n0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoDJDoIHuVTWZS6VNxE8aeGFywVHddGW7DMO+X7CThcXYSRHkH
 4XRZrT5bio4gRMzE6YMjp+8iAUasYub0RfwyOBHPrfMVz5vFuS33JuMxoTyNhERLM26O2KcDjah
 30Hn1fQ6KctQY9TbhZWn24TEheX9p/2s=
X-Gm-Gg: AY/fxX751L7SO+WYFq+1BIVgXNd9TW6/qLvSzQPfPuReIrNtC+AwUp5ATTcq+XSeBDU
 MG4vDkMedui2+5VbfFsIC8tue/RoYd+tWvGxBgrUCgErawYu3pKbe7ytAPqk3dOIKiDHrmG8NAl
 Te6nmOHNg83v+PRVxmrQtdBjiEQymm7wgip5Oj6HEiCOTGbKv2v2xg1dBp/vS85rVe/kwRzGMyd
 3E/fHqJlYrwfeAFMMMFy4qN06uUK51aYyavfpiAP7cygH4GbhDN2GmC6OKDG+Sl/+Iym6j1YuEI
 q6yP628=
X-Received: by 2002:a05:7022:7e82:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-12336a94480mr3312018c88.3.1768486095455; Thu, 15 Jan 2026
 06:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
 <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
 <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
 <CADnq5_PoHgp_Pf7EsV_bRwmh0Q7GuWfnEW-3Pp0gscT80VAnLg@mail.gmail.com>
 <6bbdb38b-75d0-4867-b4b6-afa5dc0b479e@amd.com>
 <CADnq5_Nm+E3trPt7LLUMBC697Upjnm6y46vdyXwBLxb_PHLxCQ@mail.gmail.com>
 <47105606-f0ea-4358-a7a7-8ff559d6d762@amd.com>
In-Reply-To: <47105606-f0ea-4358-a7a7-8ff559d6d762@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jan 2026 09:08:04 -0500
X-Gm-Features: AZwV_QiFRAy-IDMS6WIGel5lSDrjnqfBimmSvO-0m_w_otWZFOlKvgUPegQqFtg
Message-ID: <CADnq5_PHts+E6mVTXEaO=1f+U0YWsxdXBKhUB+Lb5g7pfcy1GA@mail.gmail.com>
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

On Thu, Jan 15, 2026 at 4:08=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 1/14/26 17:36, Alex Deucher wrote:
> > On Wed, Jan 14, 2026 at 5:45=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 1/13/26 23:36, Alex Deucher wrote:
> >>> On Tue, Jan 13, 2026 at 10:34=E2=80=AFAM Alex Deucher <alexdeucher@gm=
ail.com> wrote:
> >>>>
> >>>> On Tue, Jan 13, 2026 at 9:48=E2=80=AFAM Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com> wrote:
> >>>>>
> >>>>> On 1/13/26 15:10, Alex Deucher wrote:
> >>>>>> On Tue, Jan 13, 2026 at 8:57=E2=80=AFAM Christian K=C3=B6nig
> >>>>>> <christian.koenig@amd.com> wrote:
> >>>>>>>
> >>>>>>> Patches #1-#3: Reviewed-by: Christian K=C3=B6nig <christian.koeni=
g@amd.com>
> >>>>>>>
> >>>>>>> Comment on patch #4 which also affects patches #5-#26.
> >>>>>>>
> >>>>>>> Comment on patch #27 and #28. When #28 comes before #27 then that=
 would potentially solve the issue with #27.
> >>>>>>>
> >>>>>>> Patches #31: Reviewed-by: Christian K=C3=B6nig <christian.koenig@=
amd.com>
> >>>>>>>
> >>>>>>> Patches #32-#40 that looks extremely questionable to me. I've int=
entionally removed that state from the job because it isn't job dependent a=
nd sometimes has inter-job meaning.
> >>>>>>>
> >>>>>>> Patch #41: Absolutely clear NAK! We have exercised that nonsense =
to the max and I'm clearly against doing that over and over again. Saving t=
he ring content clearly seems to be the saver approach.
> >>>>>>>
> >>>>>>
> >>>>>> I disagree.  If the ring emit functions are purely just emitting
> >>>>>> packets to the ring, it's a much cleaner approach than trying to s=
ave
> >>>>>> and restore packet sequences repeatedly.
> >>>>>
> >>>>> Exactly that's the problem, this is not what they do.
> >>>>>
> >>>>> See gfx_v11_0_ring_emit_gfx_shadow() for an example:
> >>>>>
> >>>>> ...
> >>>>>         /*
> >>>>>          * We start with skipping the prefix SET_Q_MODE and always =
executing
> >>>>>          * the postfix SET_Q_MODE packet. This is changed below wit=
h a
> >>>>>          * WRITE_DATA command when the postfix executed.
> >>>>>          */
> >>>>>         amdgpu_ring_write(ring, shadow_va ? 1 : 0);
> >>>>>         amdgpu_ring_write(ring, 0);
> >>>>>
> >>>>>         if (ring->set_q_mode_offs) {
> >>>>>                 uint64_t addr;
> >>>>>
> >>>>>                 addr =3D amdgpu_bo_gpu_offset(ring->ring_obj);
> >>>>>                 addr +=3D ring->set_q_mode_offs << 2;
> >>>>>                 end =3D gfx_v11_0_ring_emit_init_cond_exec(ring, ad=
dr);
> >>>>>         }
> >>>>> ...
> >>>>>         if (shadow_va) {
> >>>>>                 uint64_t token =3D shadow_va ^ csa_va ^ gds_va ^ vm=
id;
> >>>>>
> >>>>>                 /*
> >>>>>                  * If the tokens match try to skip the last postfix=
 SET_Q_MODE
> >>>>>                  * packet to avoid saving/restoring the state all t=
he time.
> >>>>>                  */
> >>>>>                 if (ring->set_q_mode_ptr && ring->set_q_mode_token =
=3D=3D token)
> >>>>>                         *ring->set_q_mode_ptr =3D 0;
> >>>>>
> >>>>>                 ring->set_q_mode_token =3D token;
> >>>>>         } else {
> >>>>>                 ring->set_q_mode_ptr =3D &ring->ring[ring->set_q_mo=
de_offs];
> >>>>>         }
> >>>>>
> >>>>>         ring->set_q_mode_offs =3D offs;
> >>>>> }
> >>>>>
> >>>>> Executing this multiple times is simply not possible without saving=
 set_q_mode_offs, the token and the CPU pointer (and restoring the CPU poin=
ter content).
> >>>>>
> >>>>> And that is just the tip of the iceberg, we have tons of state like=
 this.
> >>>>
> >>>> There is not much more than that.  I looked when I wrote these
> >>>> patches.  Even this state should be handled correctly.  In this case=
,
> >>>> the state is saved in the job at the original submission time and is
> >>>> explicitly passed to the emit ring functions.  As such the original
> >>>> state is reproduced.  In this case, ring->set_q_mode_offs and
> >>>> ring->set_q_mode_ptr get reset in gfx_v11_0_ring_emit_vm_flush().
> >>>> Then they get set as appropriate based on the saved state in the job
> >>>> in gfx_v11_0_ring_emit_gfx_shadow().  It emits the same ring state
> >>>> again.
> >>>>
> >>>
> >>> I just fixed up the set_q handling locally.  I added a helper which
> >>> saves the state of the ring (any ring->set_q values, etc.) in the job
> >>> before we schedule the IB.  Then after the reset I restore the ring
> >>> state before re-emitting the IB state.
> >>
> >> Exactly that doesn't work.
> >>
> >> See the set_q_mode handling works by looking at the next job in the qu=
eue and determining based in PM4 code if executing the packet is necessary =
or not.
> >>
> >> When we drop some jobs from execution because they belong to the same =
context as the one who caused the timeout we write incorrect commands into =
the PM4 stream when re-emitting.
> >>
> >> We would need to extend the handling in a way where we can say ok this=
 job is now skipped, but we need to pretend that it isn't so that the set_q=
_mode handling works and then still not execute the IBs in the job.
> >>
> >
> > Explicit re-emit is the only way this can easily work correctly.  We
> > save the ring state and and job state in the job and then we replay
> > the state and re-emit a proper coherent packet stream after the reset.
> > When we re-emit, we update the offsets as appropriate so that the
> > logic works properly as you replay the job stream.  You can skip the
> > IBs for the timedout context, but as long as the rest of the logic is
> > there, everything works.  Saving and restoring the opaque ring
> > contents is much harder because you need to either save a bunch of
> > pointers or try and determine which offsets to patch, etc.
>
> Or you tell the HW to continue at the place you stopped excuting and befo=
re the reset and use the conditional execute all jobs are wrapped up in any=
way to determine if they should execute or not or overwrite the commands wi=
th NOPs when for engines who don't use the conditional execute.
>

Not all rings retain the contents of the ring after a reset or may not
be able to start at arbitrary ring ptr locations.  Plus only gfx and
compute have conditional execution support.  For everything else you
need to adjust the packet stream.

> Re-emitting the command stream would only be necessary if we need to chan=
ge the commands in anyway, and even if we would need to do that then I woul=
d say that we should not emit the commands again at all.
>

The only case where we need to mess with anything is to support the
set_q stuff and that is only supported on one gfx11 chip specifically
for SR-IOV.

> I have patches in the pipeline to remove the job object from the reset pa=
th, so that we can free it up directly after submission again and completel=
y solve all the lifetime issues we had with that.
>

I don't really see any lifetime issues with the job after we fix the
whole sched stop/start stuff.  Moreover, having the job around (or we
could hang the state on the fence, but that is less clean because
there are potentially two fences per job that you need to keep track
of that share common state) makes it much easier to re-emit the packet
stream after a reset.  It's a lot easier to just call the emit
functions on a clean ring than to deal with opaque ring contents.
Depending on the ring you end up needing to keep lots of pointers to
mark fences and job boundaries.  Then if you have to re-emit the same
job multiple times, you have to re-adjust all of the pointers, plus
deal with skipping the IBs while still emitting the fences.

Alex

> Re-emitting completely breaks that again.
>
> Christian.
>
> >
> > Alex
> >
> >> Long story short that is seriously not going to work. So absolutely cl=
ear NAK from my side to this approach.
> >>
> >> What we could do to avoid problems and patching pointers in the comman=
d stream is to emit only the fence signaling for skipped jobs and fill ever=
ything else with NOPs.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>  At that point the ring has the
> >>> same state it had before the queue was reset and the state gets
> >>> updated in the ring as the IBs are reemitted.
> >>>
> >>> That's it.  The only other state dependent on the ring was the seq
> >>> number to wait on for pipeline sync and I fixed that by making it
> >>> explicit.
> >>>
> >>> Alex
> >>>
> >>>>>
> >>>>>> If the relevant state is
> >>>>>> stored in the job, you can re-emit it and get the same ring state =
each
> >>>>>> time.
> >>>>>
> >>>>> No, you can't. Background is that the relevant state is not job dep=
endent, but inter job dependent.
> >>>>>
> >>>>> In other words it doesn't depend on what job is executing now but r=
ather which one was executed right before that one.
> >>>>>
> >>>>> Or even worse in the case of the set_q_mode packet on the job depen=
dent after the one you want to execute.
> >>>>>
> >>>>> I can absolutely not see how stuff like that should work with re-su=
bmission.
> >>>>
> >>>> All you need to do is save the state that was used to emit the packe=
ts
> >>>> in the original submission.
> >>>>
> >>>>>
> >>>>>> If you end up with multiple queue resets in a row, it gets
> >>>>>> really complex to try and save and restore opaque ring contents.  =
By
> >>>>>> the time you fix up the state tracking to handle that, you end up
> >>>>>> pretty close to this solution.
> >>>>>
> >>>>> Not even remotely, you have tons of state we would need to save and=
 restore and a lot of that is outside of the job.
> >>>>>
> >>>>> Updating a few fence pointers on re-submission is absolutely trivia=
l compared to that.
> >>>>
> >>>> It's not that easy.  If you want to just emit the fences for bad
> >>>> contexts rather than the whole IB stream, you can also potentially
> >>>> mess up the ring state.  You'd end up needing a pile of pointers tha=
t
> >>>> need to be recalculated on every reset to try and remit the
> >>>> appropriate state again.  This approach also paves the way for
> >>>> re-emitting state for all queues after adapter reset when VRAM is no=
t
> >>>> lost.
> >>>>
> >>>> Alex
> >>>>
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>> Regards,
> >>>>>>> Christian.
> >>>>>>>
> >>>>>>> On 1/8/26 15:48, Alex Deucher wrote:
> >>>>>>>> This set contains a number of bug fixes and cleanups for
> >>>>>>>> IB handling that I worked on over the holidays.
> >>>>>>>>
> >>>>>>>> Patches 1-2:
> >>>>>>>> Simple bug fixes.
> >>>>>>>>
> >>>>>>>> Patches 3-26:
> >>>>>>>> Removes the direct submit path for IBs and requires
> >>>>>>>> that all IB submissions use a job structure.  This
> >>>>>>>> greatly simplifies the IB submission code.
> >>>>>>>>
> >>>>>>>> Patches 27-42:
> >>>>>>>> Split IB state setup and ring emission.  This keeps all
> >>>>>>>> of the IB state in the job.  This greatly simplifies
> >>>>>>>> re-emission of non-timed-out jobs after a ring reset and
> >>>>>>>> allows for re-emission multiple times if multiple resets
> >>>>>>>> happen in a row.  It also properly handles the dma fence
> >>>>>>>> error handling for timedout jobs with adapter resets.
> >>>>>>>>
> >>>>>>>> Alex Deucher (42):
> >>>>>>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
> >>>>>>>>   drm/amdgpu: fix error handling in ib_schedule()
> >>>>>>>>   drm/amdgpu: add new job ids
> >>>>>>>>   drm/amdgpu/vpe: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx6: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx7: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx8: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx9: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx10: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx11: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx12: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/si_dma: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma3: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma4: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma5: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma6: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma7: switch to using job for IBs
> >>>>>>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
> >>>>>>>>   drm/amdgpu: require a job to schedule an IB
> >>>>>>>>   drm/amdgpu: mark fences with errors before ring reset
> >>>>>>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion=
()
> >>>>>>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
> >>>>>>>>   drm/amdgpu: drop drm_sched_increase_karma()
> >>>>>>>>   drm/amdgpu: plumb timedout fence through to force completion
> >>>>>>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
> >>>>>>>>   drm/amdgpu: drop extra parameter for vm_flush
> >>>>>>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
> >>>>>>>>   drm/amdgpu: store vm flush state in amdgpu_job
> >>>>>>>>   drm/amdgpu: split fence init and emit logic
> >>>>>>>>   drm/amdgpu: split vm flush and vm flush emit logic
> >>>>>>>>   drm/amdgpu: split ib schedule and ib emit logic
> >>>>>>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout=
()
> >>>>>>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
> >>>>>>>>   drm/amdgpu: rework reset reemit handling
> >>>>>>>>   drm/amdgpu: simplify per queue reset code
> >>>>>>>>
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++---=
-------
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
> >>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> >>>>>>>>  54 files changed, 952 insertions(+), 966 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>
> >>
>
