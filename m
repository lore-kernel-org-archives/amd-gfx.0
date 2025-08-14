Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD20ACA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 12:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DF810E888;
	Thu, 14 Aug 2025 12:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kSXR0hcc";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D6D10E888
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 12:57:09 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b4716f9a467so136789a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755176229; x=1755781029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ytyvaNodtnAN9ZXY/DB1NXaOpls0B9PIftaDHdoeqI=;
 b=kSXR0hcc4SdWiLGA0RxWEQZNfAaiknJTltMb6RHGOa42agEZTfUljPFKDN1Vt5AWgj
 cZOGr64Q+5y67sl1+NyByaQ8ZPMeifz3Z5IHbyRPftiXRkfUQjGIMW19ZFNX2SB4zfPx
 dyLHjOB54RcmH7Ks8WCMbbIdaTPG7PaP964OIASOT2jgWIcaVw2b1v1g06VMbMF/gu0J
 jGwuFswsTNLB3bO77N0xiBiSdVP/EROveOmlEhioxRkoqGAzKTJdQywSqkHYvCHjI+Nu
 xsMZUKU0v00n/cgB4WrHa+hKS0/f3LcP+g5AdtQtHSeEHwX8l40a1J3+dGk9r0cxAVMU
 xyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176229; x=1755781029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ytyvaNodtnAN9ZXY/DB1NXaOpls0B9PIftaDHdoeqI=;
 b=gFbQorHPUECP9wjhQq/jkc6TPrxXCViHZ1eo8XHcO6g19ZyQe6L8jpgldOv7Nzmamq
 tkukJft+KkEhlU/DI+00S2EIIYFjJVm7aikdKWT/JsN3zT3Tm9OMeKgtjMhxbmMbaJ/D
 X7PudDpGOvgJN2zRBkvZus3KP+LN0yBmWjhQxh4Rtw9tFejRHkkHEsR4G9seQOGegqsM
 7P/x+7inExA9KVZFuN5L/a2tRY31GN23kqQ6/sKkptaNDugDffv7a/yOAOT7yo/ub0RB
 VN5cJfQzAPad4CZM+EOOz2gSVRcbNFpE3D2PdCYR/YmxeWos/xNSX4CzISW2HxU5xeEF
 HbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUysSwvNtAlC8Fz3fs6EpLqPrM6dJojNZ2yLHQlBLs6mltlafBmQosf4pdG+Zhl/NRZSAlPjMKx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzs/jscf4VK8xWGOyu+2lJyFpXe6IaSC6vunRV4ZSMDKrUPyhZp
 Jzy0zMFNIR0DS/mUEIIEMtnb4Zx+87jgauFr1J+HHANFTLMFKXTliUcGX8TxLGN60oetY8JXJVu
 kTzonVR2ARIw0VYUNmq6YF1G6Pt/FA0jEZQ==
X-Gm-Gg: ASbGncuQPPDdcWRiG/RrVKA4gfv8P05F2iKStQCtsOx4lSWajY7gUz7MzC+AM5OXuCR
 uoEWzSmIY08uX+VYJDvqcaGa+iwJcAEWcJWr87BNLA7wilgV8B6UlV4MMWx5bST5UDDG5ZkxhA+
 Fb2RRrIIDZjfoMjY85kSP9Jqtwb3ZcY+EUSP5M0E/wqVPYFQGgEf/V9Dsh93pAWjaRtgTA/F7wX
 zE46QOUdbIgumQIe/k=
X-Google-Smtp-Source: AGHT+IFCWN/g0z7NjqmsyWEYv6b2mUgcesdVIdfNXSWRyoyYXv0/vDUdSzPSVMxBnQeLDRSaBQLoUMqEegpPFl27zGI=
X-Received: by 2002:a17:902:db12:b0:240:8a87:a187 with SMTP id
 d9443c01a7336-244582c2540mr23103565ad.0.1755176229112; Thu, 14 Aug 2025
 05:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
 <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
 <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
In-Reply-To: <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Aug 2025 08:56:57 -0400
X-Gm-Features: Ac12FXwzue6aDeFfWgIzeuBIYT2tiRGF9XJEEp6BaL_zRupJEWaYg7Y-kac5fW4
Message-ID: <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: "Wu, David" <davidwu2@amd.com>
Cc: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Aug 13, 2025 at 7:06=E2=80=AFPM Wu, David <davidwu2@amd.com> wrote:
>
> On 8/13/2025 6:11 PM, Alex Deucher wrote:
> > On Wed, Aug 13, 2025 at 5:47=E2=80=AFPM Wu, David <davidwu2@amd.com> wr=
ote:
> >> On 8/13/2025 5:03 PM, Alex Deucher wrote:
> >>> On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Sundararaju, Sathishkumar
> >>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
> >>>>> On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkumar
> >>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>> Hi Alex, Hi David,
> >>>>>>
> >>>>>> I see David's concern but his suggestion yet wont solve the proble=
m,
> >>>>>> neither the current form , reason :-
> >>>>>>
> >>>>>> The emitted fence count and total submission count are fast transi=
ents
> >>>>>> which frequently become 0 in between video decodes (between jobs) =
even
> >>>>>> with the atomics and locks there can be a switch of video power pr=
ofile,
> >>>>>> in the current form of patch that window is minimized, but still c=
an
> >>>>>> happen if stress tested. But power state of any instance becoming =
zero
> >>>>> Can you explain how this can happen?  I'm not seeing it.
> >>>> Consider this situation, inst0 and inst1 actively decoding, inst0 de=
code
> >>>> completes, delayed idle work starts.
> >>>> inst0 idle handler can read 0 total fences and 0 total submission co=
unt,
> >>>> even if inst1 is actively decoding,
> >>>> that's between the jobs,
> >>>>     - as begin_use increaments vcn.total_submission_cnt and end_use
> >>>> decreaments vcn.total_submission_cnt that can be 0.
> >>>>     - if outstanding fences are cleared and no new emitted fence, be=
tween
> >>>> jobs , can be 0.
> >>>>     - both of the above conditions do not mean video decode is compl=
ete on
> >>>> inst1, it is actively decoding.
> >>> How can there be active decoding without an outstanding fence?  In
> >>> that case, total_fences (fences from both instances) would be non-0.
> >> I think it should be non-0.
> >> I do see a hiccup possible - i.e the power switching from ON to OFF th=
en
> >> ON in the
> >> middle of decoding, i.e inst0 idle handler turns it off then inst1 tur=
ns
> >> it on.
> > How would that happen? As long as there submission cnt is non-0 and
> > there are outstanding fences on any instance, the video profile will
> > stay active.
> there could be no jobs but it doesn't timeout yet and new jobs will come =
in
> any ms - note all fences are done at this time. The idle handler sees no
> fences
> and no jobs so it turns off the power - but just ms later a new job is
> submitted
> from the same decode session which could be mpv player as it does not
> need to
> submit jobs without delays. This will turn on the power.

I'm not following.  Every submission will start with begin_use().

Alex

> David
> > Alex
> >
> >> We should avoid this glitch. This requires the idle handler sets/clear=
s
> >> a flag for
> >> done for this instance as Sathish's original patch. When all instances
> >> set/clear the
> >> flag then we can safely power off.
> >> David
> >>> Alex
> >>>
> >>>> Whereas if instances are powered off we are sure idle time is past a=
nd
> >>>> it is powered off, no possible way of
> >>>> active video decode, when all instances are off we can safely assume=
 no
> >>>> active decode and global lock protects
> >>>> it against new begin_use on any instance. But the only distant conce=
rn
> >>>> is global common locks w.r.t perf, but we
> >>>> are already having a global workprofile mutex , so there shouldn't b=
e
> >>>> any drop in perf, with just one single
> >>>> global lock for all instances.
> >>>>
> >>>> Just sending out a patch with this fix, will leave it to you to deci=
de
> >>>> the right method. If you think outstanding total fences
> >>>> can never be 0 during decode, then your previous version (v3) itself=
 is
> >>>> good, there is no real benefit of splitting the handlers as such.
> >>>>
> >>>> Regards,
> >>>> Sathish
> >>>>> If it is possible, maybe it would be easier to just split the profi=
le
> >>>>> and powergating into separate handlers.  The profile one would be
> >>>>> global and the powergating one would be per instance.  See the
> >>>>> attached patches.
> >>>>>
> >>>>> Alex
> >>>>>
> >>>>>> can be a sure shot indication of break in a video decode, the mist=
ake in
> >>>>>> my patch was using per instance mutex, I should have used a common
> >>>>>> global mutex, then that covers the situation David is trying to br=
ing out.
> >>>>>>
> >>>>>> Using one global vcn.pg_lock for idle and begin_use and using flag=
s to
> >>>>>> track power state could help us totally avoid this situation.
> >>>>>>
> >>>>>> Regards,
> >>>>>>
> >>>>>> Sathish
> >>>>>>
> >>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
> >>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
> >>>>>>>> On Wed, Aug 13, 2025 at 12:39=E2=80=AFPM Wu, David <davidwu2@amd=
.com> wrote:
> >>>>>>>>> Hi Alex,
> >>>>>>>>>
> >>>>>>>>> The addition of  total_submission_cnt should work - in that
> >>>>>>>>> it is unlikely to have a context switch right after the begin_u=
se().
> >>>>>>>>> The suggestion of moving it inside the lock (which I prefer in =
case
> >>>>>>>>> someone
> >>>>>>>>> adds more before the lock and not reviewed thoroughly)
> >>>>>>>>>       - up to you to decide.
> >>>>>>>>>
> >>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> David
> >>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> >>>>>>>>>> If there are multiple instances of the VCN running,
> >>>>>>>>>> we may end up switching the video profile while another
> >>>>>>>>>> instance is active because we only take into account
> >>>>>>>>>> the current instance's submissions.  Look at all
> >>>>>>>>>> outstanding fences for the video profile.
> >>>>>>>>>>
> >>>>>>>>>> v2: drop early exit in begin_use()
> >>>>>>>>>> v3: handle possible race between begin_use() work handler
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
> >>>>>>>>>> handling")
> >>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>=
 (v1)
> >>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>> ---
> >>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
> >>>>>>>>>> ++++++++++++-------------
> >>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >>>>>>>>>>       2 files changed, 21 insertions(+), 20 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>> @@ -415,19 +415,25 @@ static void
> >>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>           struct amdgpu_vcn_inst *vcn_inst =3D
> >>>>>>>>>>                   container_of(work, struct amdgpu_vcn_inst,
> >>>>>>>>>> idle_work.work);
> >>>>>>>>>>           struct amdgpu_device *adev =3D vcn_inst->adev;
> >>>>>>>>>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCE=
S] =3D {0};
> >>>>>>>>>> -     unsigned int i =3D vcn_inst->inst, j;
> >>>>>>>>>> +     unsigned int total_fences =3D 0,
> >>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0};
> >>>>>>>>>> +     unsigned int i, j;
> >>>>>>>>>>           int r =3D 0;
> >>>>>>>>>>
> >>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
> >>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
> >>>>>>>>>>                   return;
> >>>>>>>>>>
> >>>>>>>>>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> >>>>>>>>>> -             fence[i] +=3D
> >>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> >>>>>>>>>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>>>>>>>> +             struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i]=
;
> >>>>>>>>>> +
> >>>>>>>>>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>>>>>>>>> +                     fence[i] +=3D
> >>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
> >>>>>>>>>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v->rin=
g_dec);
> >>>>>>>>>> +             total_fences +=3D fence[i];
> >>>>>>>>>> +     }
> >>>>>>>>>>
> >>>>>>>>>>           /* Only set DPG pause for VCN3 or below, VCN4 and ab=
ove will
> >>>>>>>>>> be handled by FW */
> >>>>>>>>>>           if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>>>>>>>>> +         !vcn_inst->using_unified_queue) {
> >>>>>>>>>>                   struct dpg_pause_state new_state;
> >>>>>>>>>>
> >>>>>>>>>>                   if (fence[i] ||
> >>>>>>>>>> @@ -436,18 +442,18 @@ static void
> >>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>                   else
> >>>>>>>>>>                           new_state.fw_based =3D VCN_DPG_STATE=
__UNPAUSE;
> >>>>>>>>>>
> >>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_=
state);
> >>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
> >>>>>>>>>>           }
> >>>>>>>>>>
> >>>>>>>>>> -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring=
_dec);
> >>>>>>>>>> -     fences +=3D fence[i];
> >>>>>>>>>> -
> >>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_=
cnt)) {
> >>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
> >>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
> >>>>>>>>>> +             /* This is specific to this instance */
> >>>>>>>>>>                   mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>                   vcn_inst->set_pg_state(vcn_inst, AMD_PG_STAT=
E_GATE);
> >>>>>>>>>>                   mutex_unlock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
> >>>>>>>>>> +             /* This is global and depends on all VCN instanc=
es */
> >>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
> >>>>>>>>>> !total_fences &&
> >>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
> >>>>>>>>>>                           r =3D amdgpu_dpm_switch_power_profil=
e(adev,
> >>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>>>> false);
> >>>>>>>>>>                           if (r)
> >>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>>>> amdgpu_ring *ring)
> >>>>>>>>>>           int r =3D 0;
> >>>>>>>>>>
> >>>>>>>>>>           atomic_inc(&vcn_inst->total_submission_cnt);
> >>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>>>> move this addition down inside the mutex lock
> >>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
> >>>>>>>>>>
> >>>>>>>>>> -     /* We can safely return early here because we've cancell=
ed the
> >>>>>>>>>> -      * the delayed work so there is no one else to set it to=
 false
> >>>>>>>>>> -      * and we don't care if someone else sets it to true.
> >>>>>>>>>> -      */
> >>>>>>>>>> -     if (adev->vcn.workload_profile_active)
> >>>>>>>>>> -             goto pg_lock;
> >>>>>>>>>> -
> >>>>>>>>>>           mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>> move to here:
> >>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>>>> I think this should work for multiple instances.
> >>>>>>>> Why does this need to be protected by the mutex?
> >>>>>>> hmm.. OK - no need and it is actually better before the mutex.
> >>>>>>> David
> >>>>>>>> Alex
> >>>>>>>>
> >>>>>>>>> David
> >>>>>>>>>>           if (!adev->vcn.workload_profile_active) {
> >>>>>>>>>>                   r =3D amdgpu_dpm_switch_power_profile(adev,
> >>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>>>> amdgpu_ring *ring)
> >>>>>>>>>>           }
> >>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>
> >>>>>>>>>> -pg_lock:
> >>>>>>>>>>           mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>           vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE=
);
> >>>>>>>>>>
> >>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu=
_ring
> >>>>>>>>>> *ring)
> >>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_=
cnt);
> >>>>>>>>>>
> >>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cn=
t);
> >>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >>>>>>>>>>
> >>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_wor=
k,
> >>>>>>>>>>                                 VCN_IDLE_TIMEOUT);
> >>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >>>>>>>>>>
> >>>>>>>>>>           uint16_t inst_mask;
> >>>>>>>>>>           uint8_t num_inst_per_aid;
> >>>>>>>>>> +     atomic_t                total_submission_cnt;
> >>>>>>>>>>
> >>>>>>>>>>           /* IP reg dump */
> >>>>>>>>>>           uint32_t                *ip_dump;
>
