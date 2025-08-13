Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0579AC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 22:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBB110E661;
	Wed, 13 Aug 2025 22:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRZUVhzp";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D154510E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 22:09:03 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-24458293cebso334825ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755122943; x=1755727743; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xz44ROKv4f57igEsvjmS1YXKkj2At1izcpFygIHe/AE=;
 b=eRZUVhzpEiCE91npSVGb7BEjfzmk/Ep7pPTRjt5zNIwcgn4POulDVRo8/z4gBoYM1C
 PPFeld0cSnBgPaWim674fZ0IFqZsMoxEcePC0MnuWFB1t73cRRiTkVFE2vzukS1t+WrA
 YP1wf+Do6xk40JKPGQXyOZTT/cxEIrFKnB6zXC02Tj530ldVLgwjktFXZmml6HK5FzKQ
 edbSP+yZ4Amg6xa2PvdOsYwk5c68WPzFIKP+6bThIIKJfI/e328BLBw+mFfc4w7KyGIG
 WKClrZwUDOFXDpPN7G1yaIsktm8MaFsXtE3Gn5SjnHH/pOxcAsDBK2Gb4tfDDNoA/tcm
 z4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755122943; x=1755727743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xz44ROKv4f57igEsvjmS1YXKkj2At1izcpFygIHe/AE=;
 b=siFk+ZmXE6o9hE6N4+L8ImINgMKq37MXjfMSHFv428sSVIEbIXuD8fkRlKgWKmbGt5
 2g7BEy59otciMiBeISDhO2X6mX2/Ji1vrT7poVmR9/hHKwhPbuY3P1peFVY+wI26RQNf
 +A0cYKUjrNwluPngRXIFY10dfkaNYL8lw5bsW1e7FjyFv5DtWtq4diA72P9Xac0YFLkR
 D1crEGbRBBRxj/hrlse6vSyh99k1sAEum1ojJSrT0k7ej0FWUy4R9oWCq1sl+cAH3VOS
 LDpLUNxucfOJvwHEOwEiAcJDIqBFe2YzH4smDz36xIYw5wzIVKgN4OgeteBj6iVJOENr
 Wjqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdRYLiQBBLa8Vp6duSq8sbuTNOkAauhTLDAsCbbLnCctpquH+tFcCTKP4DkUJKCfp2tSF5sAek@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2nxt4uHzQy1uOvS25J03RQ5cQ/yb2O1Pwi6K6yfm+G1Iwsp6B
 7tf7Vij75kt/n5bG/eVt4cyM082S5FP9rRweHcUdh0M90dvFCxE0gFF4vjQ1QslO+NqBOoYxgfs
 M4ylSL3VMneswPIJisqvTEW4Ylf3kaAo=
X-Gm-Gg: ASbGnctQY9IiUUTmJvMRopmQKdnx/n4ASpZjuVRFDFLhl10ZnWbowY/5xyglhcWh4Wg
 +Un9Z7CNH5s6KkdnGzMx4qdpWraNph8gvHeLKTfzo3+ze9+kozm3+Ch8idqnCO9Z5rHVFMIyQ5q
 UYfMeI1OG4JCiHzHLr+3xOJFEcHnfZSKin/kIuOU752NVVvkiWE55qGOlbJpQU1WN5HbXXhdyHy
 +Zc+Ps=
X-Google-Smtp-Source: AGHT+IF+DyPQRz5amHi/WG1ueb2jY7BVMWxT3cmyzPItJAzU180tyQH7p2q+ouIbRUXk0K7741z/aQWvDzEvfxfXqGw=
X-Received: by 2002:a17:902:c409:b0:242:d237:e20b with SMTP id
 d9443c01a7336-24458524002mr4497945ad.4.1755122942734; Wed, 13 Aug 2025
 15:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
In-Reply-To: <376e6482-7319-426a-3d67-994b9581c678@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 18:08:51 -0400
X-Gm-Features: Ac12FXw35gBYbBOOMG_fEyn7OXwBZQfrSt-b1DSloXtkIQK5qJszvK9QzvYRw5g
Message-ID: <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
Cc: "Wu, David" <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, Aug 13, 2025 at 5:16=E2=80=AFPM Sundararaju, Sathishkumar
<sathishkumar.sundararaju@amd.com> wrote:
>
>
> On 8/14/2025 2:33 AM, Alex Deucher wrote:
> > On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Sundararaju, Sathishkumar
> > <sathishkumar.sundararaju@amd.com> wrote:
> >>
> >> On 8/14/2025 1:35 AM, Alex Deucher wrote:
> >>> On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkumar
> >>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>> Hi Alex, Hi David,
> >>>>
> >>>> I see David's concern but his suggestion yet wont solve the problem,
> >>>> neither the current form , reason :-
> >>>>
> >>>> The emitted fence count and total submission count are fast transien=
ts
> >>>> which frequently become 0 in between video decodes (between jobs) ev=
en
> >>>> with the atomics and locks there can be a switch of video power prof=
ile,
> >>>> in the current form of patch that window is minimized, but still can
> >>>> happen if stress tested. But power state of any instance becoming ze=
ro
> >>> Can you explain how this can happen?  I'm not seeing it.
> >> Consider this situation, inst0 and inst1 actively decoding, inst0 deco=
de
> >> completes, delayed idle work starts.
> >> inst0 idle handler can read 0 total fences and 0 total submission coun=
t,
> >> even if inst1 is actively decoding,
> >> that's between the jobs,
> >>    - as begin_use increaments vcn.total_submission_cnt and end_use
> >> decreaments vcn.total_submission_cnt that can be 0.
> >>    - if outstanding fences are cleared and no new emitted fence, betwe=
en
> >> jobs , can be 0.
> >>    - both of the above conditions do not mean video decode is complete=
 on
> >> inst1, it is actively decoding.
> > How can there be active decoding without an outstanding fence?  In
> > that case, total_fences (fences from both instances) would be non-0.
>
> I mean on inst1 the job scheduled is already complete, so 0 outstanding
> fences, newer job is yet to be scheduled
>
> and commited to ring (inst1) , this doesn't mean decode has stopped on
> inst1 right (I am saying if timing of inst0 idle work coincides with this=
),
>
> Or am I wrong in assuming this ? Can't this ever happen ? Please correct
> my understanding here.

The flow looks like:

begin_use(inst)
emit_fence(inst)
end_use(inst)

...later
fence signals
...later
work handler

In begin_use we increment the global and per instance submission.
This protects the power gating and profile until end_use.  In end use
we decrement the submissions because we don't need to protect anything
any more as we have the fence that was submitted via the ring.  That
fence won't signal until the job is complete.  For power gating, we
only care about the submission count and fences for that instance, for
the profile, we care about submission count and fences all instances.
Once the fences have signalled, the outstanding fences will be 0 and
there won't be any active work.

Alex

>
> Regards,
>
> Sathish
>
> >
> > Alex
> >
> >> Whereas if instances are powered off we are sure idle time is past and
> >> it is powered off, no possible way of
> >> active video decode, when all instances are off we can safely assume n=
o
> >> active decode and global lock protects
> >> it against new begin_use on any instance. But the only distant concern
> >> is global common locks w.r.t perf, but we
> >> are already having a global workprofile mutex , so there shouldn't be
> >> any drop in perf, with just one single
> >> global lock for all instances.
> >>
> >> Just sending out a patch with this fix, will leave it to you to decide
> >> the right method. If you think outstanding total fences
> >> can never be 0 during decode, then your previous version (v3) itself i=
s
> >> good, there is no real benefit of splitting the handlers as such.
> >>
> >> Regards,
> >> Sathish
> >>> If it is possible, maybe it would be easier to just split the profile
> >>> and powergating into separate handlers.  The profile one would be
> >>> global and the powergating one would be per instance.  See the
> >>> attached patches.
> >>>
> >>> Alex
> >>>
> >>>> can be a sure shot indication of break in a video decode, the mistak=
e in
> >>>> my patch was using per instance mutex, I should have used a common
> >>>> global mutex, then that covers the situation David is trying to brin=
g out.
> >>>>
> >>>> Using one global vcn.pg_lock for idle and begin_use and using flags =
to
> >>>> track power state could help us totally avoid this situation.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Sathish
> >>>>
> >>>> On 8/13/2025 11:46 PM, Wu, David wrote:
> >>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
> >>>>>> On Wed, Aug 13, 2025 at 12:39=E2=80=AFPM Wu, David <davidwu2@amd.c=
om> wrote:
> >>>>>>> Hi Alex,
> >>>>>>>
> >>>>>>> The addition of  total_submission_cnt should work - in that
> >>>>>>> it is unlikely to have a context switch right after the begin_use=
().
> >>>>>>> The suggestion of moving it inside the lock (which I prefer in ca=
se
> >>>>>>> someone
> >>>>>>> adds more before the lock and not reviewed thoroughly)
> >>>>>>>      - up to you to decide.
> >>>>>>>
> >>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> David
> >>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> >>>>>>>> If there are multiple instances of the VCN running,
> >>>>>>>> we may end up switching the video profile while another
> >>>>>>>> instance is active because we only take into account
> >>>>>>>> the current instance's submissions.  Look at all
> >>>>>>>> outstanding fences for the video profile.
> >>>>>>>>
> >>>>>>>> v2: drop early exit in begin_use()
> >>>>>>>> v3: handle possible race between begin_use() work handler
> >>>>>>>>
> >>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
> >>>>>>>> handling")
> >>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (=
v1)
> >>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
> >>>>>>>> ++++++++++++-------------
> >>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >>>>>>>>      2 files changed, 21 insertions(+), 20 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>> @@ -415,19 +415,25 @@ static void
> >>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>          struct amdgpu_vcn_inst *vcn_inst =3D
> >>>>>>>>                  container_of(work, struct amdgpu_vcn_inst,
> >>>>>>>> idle_work.work);
> >>>>>>>>          struct amdgpu_device *adev =3D vcn_inst->adev;
> >>>>>>>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES]=
 =3D {0};
> >>>>>>>> -     unsigned int i =3D vcn_inst->inst, j;
> >>>>>>>> +     unsigned int total_fences =3D 0,
> >>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0};
> >>>>>>>> +     unsigned int i, j;
> >>>>>>>>          int r =3D 0;
> >>>>>>>>
> >>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
> >>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
> >>>>>>>>                  return;
> >>>>>>>>
> >>>>>>>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> >>>>>>>> -             fence[i] +=3D
> >>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> >>>>>>>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>>>>>> +             struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i];
> >>>>>>>> +
> >>>>>>>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>>>>>>> +                     fence[i] +=3D
> >>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
> >>>>>>>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v->ring_=
dec);
> >>>>>>>> +             total_fences +=3D fence[i];
> >>>>>>>> +     }
> >>>>>>>>
> >>>>>>>>          /* Only set DPG pause for VCN3 or below, VCN4 and above=
 will
> >>>>>>>> be handled by FW */
> >>>>>>>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>>>>>>> +         !vcn_inst->using_unified_queue) {
> >>>>>>>>                  struct dpg_pause_state new_state;
> >>>>>>>>
> >>>>>>>>                  if (fence[i] ||
> >>>>>>>> @@ -436,18 +442,18 @@ static void
> >>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>                  else
> >>>>>>>>                          new_state.fw_based =3D VCN_DPG_STATE__U=
NPAUSE;
> >>>>>>>>
> >>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_st=
ate);
> >>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
> >>>>>>>>          }
> >>>>>>>>
> >>>>>>>> -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_d=
ec);
> >>>>>>>> -     fences +=3D fence[i];
> >>>>>>>> -
> >>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cn=
t)) {
> >>>>>>>> +     if (!fence[vcn_inst->inst] &&
> >>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
> >>>>>>>> +             /* This is specific to this instance */
> >>>>>>>>                  mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>                  vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_G=
ATE);
> >>>>>>>>                  mutex_unlock(&vcn_inst->vcn_pg_lock);
> >>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>> -             if (adev->vcn.workload_profile_active) {
> >>>>>>>> +             /* This is global and depends on all VCN instances=
 */
> >>>>>>>> +             if (adev->vcn.workload_profile_active &&
> >>>>>>>> !total_fences &&
> >>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
> >>>>>>>>                          r =3D amdgpu_dpm_switch_power_profile(a=
dev,
> >>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>> false);
> >>>>>>>>                          if (r)
> >>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>> amdgpu_ring *ring)
> >>>>>>>>          int r =3D 0;
> >>>>>>>>
> >>>>>>>>          atomic_inc(&vcn_inst->total_submission_cnt);
> >>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>> move this addition down inside the mutex lock
> >>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
> >>>>>>>>
> >>>>>>>> -     /* We can safely return early here because we've cancelled=
 the
> >>>>>>>> -      * the delayed work so there is no one else to set it to f=
alse
> >>>>>>>> -      * and we don't care if someone else sets it to true.
> >>>>>>>> -      */
> >>>>>>>> -     if (adev->vcn.workload_profile_active)
> >>>>>>>> -             goto pg_lock;
> >>>>>>>> -
> >>>>>>>>          mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>> move to here:
> >>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>> I think this should work for multiple instances.
> >>>>>> Why does this need to be protected by the mutex?
> >>>>> hmm.. OK - no need and it is actually better before the mutex.
> >>>>> David
> >>>>>> Alex
> >>>>>>
> >>>>>>> David
> >>>>>>>>          if (!adev->vcn.workload_profile_active) {
> >>>>>>>>                  r =3D amdgpu_dpm_switch_power_profile(adev,
> >>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>> amdgpu_ring *ring)
> >>>>>>>>          }
> >>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>
> >>>>>>>> -pg_lock:
> >>>>>>>>          mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>          vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> >>>>>>>>
> >>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_r=
ing
> >>>>>>>> *ring)
> >>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cn=
t);
> >>>>>>>>
> >>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt)=
;
> >>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >>>>>>>>
> >>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> >>>>>>>>                                VCN_IDLE_TIMEOUT);
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >>>>>>>>
> >>>>>>>>          uint16_t inst_mask;
> >>>>>>>>          uint8_t num_inst_per_aid;
> >>>>>>>> +     atomic_t                total_submission_cnt;
> >>>>>>>>
> >>>>>>>>          /* IP reg dump */
> >>>>>>>>          uint32_t                *ip_dump;
