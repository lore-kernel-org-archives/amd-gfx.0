Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2F7CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 16:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C2F10E8A9;
	Thu, 14 Aug 2025 16:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5TTCObT";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B0A10E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 16:02:10 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-24458051ac6so1903745ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755187330; x=1755792130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/RGgZM28RKJ1sEy+ZaT5QK/5cf6rcV2WRYA3q43U38=;
 b=R5TTCObT9gsBHusnAOjDXPfML17M5Qvjh85yf3AxYhSMctuG+ixj+5qnzNAtkl3UQR
 MmLTMiyoErJeiP6sYFfqgqMa6o1qgDJoCjnH6f3st5ww+zlFJZRMjeu+EN1BvyAPOLwz
 I+zkGfHxbej6B7MXPBgAbYpBJn5XIWLnxAmjpWVxpNEdikG5v8UaMhibkFz+2YzYDJzu
 U4PjU5dF9L58CS9Q+pEewN2Cc8wAd8o74tbrwgUcRknhABKWEjh7zaEilAB2LMnkMBkX
 9CeZb2crXaxqtf9o2MPh7neAzB0SnyPWOMNm3wk9GSAFAcH/7PL/JFdXxtjq6fta6yNY
 iPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755187330; x=1755792130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/RGgZM28RKJ1sEy+ZaT5QK/5cf6rcV2WRYA3q43U38=;
 b=lOXnEnnpTwGHt9KtLWUtXpefukfLXQG8wGA6KdCGb3WvhfSQ9YQHhJtnKBB0fzOyEs
 WG8cvoQQ1nowCeWcl8Pv9zrVxMpQ71d9lEQj5tspfxudm2ZBy0o6zR3VjDGkxky6vIAf
 B+ktPhIPKVG5vEJ+HaZ0344isXQh77/+EWNblJg65ijsQ437kT8/ehCMH7juM8UOX9bj
 YgNZiU3Auu+4kRKGTEjO6ReZ0jwiOJxE7JIoYf3o0TfdQm8V27qv4isTMkYJpaLBNrZV
 naKye0KPY2645+qr5c0xbIWhrgj7ohZrofQ8IPnNwEBpYTlo9mejwrZdcziqNLU9SDpf
 Dsvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhXqZ6aXFORBzNB8Ajxy1tFlQ7bo8zVE0rChg/tNI2sKnteTyOYdggtdBDRd17/6mtyQOt6/sA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZ+niUw4pJC2Du/3eh/PWkuviSAOAjDBhqi8cBgiSXeLXFr2uq
 jFSmfPWj7Xpo4Fxt6DZjNV6Lau36rFbKxwBJzscyjKp7UirLj5JS9NasKkTxL+cmGYM9izPSnkI
 1Le0X/MTUXNryYW/jaToZAesDpkA2ZORZCw==
X-Gm-Gg: ASbGncuE22V9/YUlazqXVQubBD6R91BxTJDeEiR1/kKYrd1kvvM4PmYbr0X5NV06AXn
 QDvD4g1qxV4UrCATjx6bw2PttNFZft0NUBKYEjzj0H8hSDtUNWlloU8XrGepK8+BOKsPf/gBFXm
 Jz+FddRP7+itrz/4UuD2OU0ibxQ+wNyeE9ulz274HfYapW0l6wKJf1Bw4CspnjkZPD7xjF222Ir
 7ZqDqA=
X-Google-Smtp-Source: AGHT+IGFP4KnYuWxnJmukbI724MeZgEuGn9tPakUKJD3XS4sNJ72WS0M0zLwv1ar3E5fFMvywigQVCRwadfR7il3aMk=
X-Received: by 2002:a17:903:2352:b0:240:3c1d:cbe3 with SMTP id
 d9443c01a7336-24458556985mr25352515ad.4.1755187329071; Thu, 14 Aug 2025
 09:02:09 -0700 (PDT)
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
 <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
 <7a8991f7-1eb7-4307-ac72-1281a50bf4d5@amd.com>
In-Reply-To: <7a8991f7-1eb7-4307-ac72-1281a50bf4d5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Aug 2025 12:01:56 -0400
X-Gm-Features: Ac12FXxADc_7VFJwTVNuRuuJpFMliCxcXG0U7ZI9zzTQAnSL1YL07RNCrTWz40Y
Message-ID: <CADnq5_NutFtDzq3xwcfLr6dHtWaEKDwV5-kXrDpNBCM2DjWb-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: David Wu <davidwu2@amd.com>
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

On Thu, Aug 14, 2025 at 11:35=E2=80=AFAM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-08-14 08:56, Alex Deucher wrote:
> > On Wed, Aug 13, 2025 at 7:06=E2=80=AFPM Wu, David <davidwu2@amd.com> wr=
ote:
> >> On 8/13/2025 6:11 PM, Alex Deucher wrote:
> >>> On Wed, Aug 13, 2025 at 5:47=E2=80=AFPM Wu, David <davidwu2@amd.com> =
wrote:
> >>>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
> >>>>> On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Sundararaju, Sathishkumar
> >>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
> >>>>>>> On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkumar
> >>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>>>> Hi Alex, Hi David,
> >>>>>>>>
> >>>>>>>> I see David's concern but his suggestion yet wont solve the prob=
lem,
> >>>>>>>> neither the current form , reason :-
> >>>>>>>>
> >>>>>>>> The emitted fence count and total submission count are fast tran=
sients
> >>>>>>>> which frequently become 0 in between video decodes (between jobs=
) even
> >>>>>>>> with the atomics and locks there can be a switch of video power =
profile,
> >>>>>>>> in the current form of patch that window is minimized, but still=
 can
> >>>>>>>> happen if stress tested. But power state of any instance becomin=
g zero
> >>>>>>> Can you explain how this can happen?  I'm not seeing it.
> >>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0 =
decode
> >>>>>> completes, delayed idle work starts.
> >>>>>> inst0 idle handler can read 0 total fences and 0 total submission =
count,
> >>>>>> even if inst1 is actively decoding,
> >>>>>> that's between the jobs,
> >>>>>>      - as begin_use increaments vcn.total_submission_cnt and end_u=
se
> >>>>>> decreaments vcn.total_submission_cnt that can be 0.
> >>>>>>      - if outstanding fences are cleared and no new emitted fence,=
 between
> >>>>>> jobs , can be 0.
> >>>>>>      - both of the above conditions do not mean video decode is co=
mplete on
> >>>>>> inst1, it is actively decoding.
> >>>>> How can there be active decoding without an outstanding fence?  In
> >>>>> that case, total_fences (fences from both instances) would be non-0=
.
> >>>> I think it should be non-0.
> >>>> I do see a hiccup possible - i.e the power switching from ON to OFF =
then
> >>>> ON in the
> >>>> middle of decoding, i.e inst0 idle handler turns it off then inst1 t=
urns
> >>>> it on.
> >>> How would that happen? As long as there submission cnt is non-0 and
> >>> there are outstanding fences on any instance, the video profile will
> >>> stay active.
> >> there could be no jobs but it doesn't timeout yet and new jobs will co=
me in
> >> any ms - note all fences are done at this time. The idle handler sees =
no
> >> fences
> >> and no jobs so it turns off the power - but just ms later a new job is
> >> submitted
> >> from the same decode session which could be mpv player as it does not
> >> need to
> >> submit jobs without delays. This will turn on the power.
> > I'm not following.  Every submission will start with begin_use().
> yes - it does - it can power on vcn but this happens in the middle of a
> decode session which has 10s timeout to call its own idle handler - in fa=
ct
> the other instance's idle handler will power off vcn because it does not
> know it needs
> to wait until the decoding session times out.

I don't follow.  If there are no outstanding fences, there is no
reason to not power down the VCN instance and disable the video
profile. If there are still outstanding fences, then the VCN instance
those fences are associated with will stay on and the video profile
will stay enabled.  If the engine hangs and eventually gets reset, the
fence will be signalled and then there will be no outstanding fences
so the idle handler will eventually disable the power profile.  The
idle handler will keep getting rescheduled as long as there is still
oustanding work.

Alex


> > Alex
> >
> >> David
> >>> Alex
> >>>
> >>>> We should avoid this glitch. This requires the idle handler sets/cle=
ars
> >>>> a flag for
> >>>> done for this instance as Sathish's original patch. When all instanc=
es
> >>>> set/clear the
> >>>> flag then we can safely power off.
> >>>> David
> >>>>> Alex
> >>>>>
> >>>>>> Whereas if instances are powered off we are sure idle time is past=
 and
> >>>>>> it is powered off, no possible way of
> >>>>>> active video decode, when all instances are off we can safely assu=
me no
> >>>>>> active decode and global lock protects
> >>>>>> it against new begin_use on any instance. But the only distant con=
cern
> >>>>>> is global common locks w.r.t perf, but we
> >>>>>> are already having a global workprofile mutex , so there shouldn't=
 be
> >>>>>> any drop in perf, with just one single
> >>>>>> global lock for all instances.
> >>>>>>
> >>>>>> Just sending out a patch with this fix, will leave it to you to de=
cide
> >>>>>> the right method. If you think outstanding total fences
> >>>>>> can never be 0 during decode, then your previous version (v3) itse=
lf is
> >>>>>> good, there is no real benefit of splitting the handlers as such.
> >>>>>>
> >>>>>> Regards,
> >>>>>> Sathish
> >>>>>>> If it is possible, maybe it would be easier to just split the pro=
file
> >>>>>>> and powergating into separate handlers.  The profile one would be
> >>>>>>> global and the powergating one would be per instance.  See the
> >>>>>>> attached patches.
> >>>>>>>
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>> can be a sure shot indication of break in a video decode, the mi=
stake in
> >>>>>>>> my patch was using per instance mutex, I should have used a comm=
on
> >>>>>>>> global mutex, then that covers the situation David is trying to =
bring out.
> >>>>>>>>
> >>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using fl=
ags to
> >>>>>>>> track power state could help us totally avoid this situation.
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>>
> >>>>>>>> Sathish
> >>>>>>>>
> >>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
> >>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
> >>>>>>>>>> On Wed, Aug 13, 2025 at 12:39=E2=80=AFPM Wu, David <davidwu2@a=
md.com> wrote:
> >>>>>>>>>>> Hi Alex,
> >>>>>>>>>>>
> >>>>>>>>>>> The addition of  total_submission_cnt should work - in that
> >>>>>>>>>>> it is unlikely to have a context switch right after the begin=
_use().
> >>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer i=
n case
> >>>>>>>>>>> someone
> >>>>>>>>>>> adds more before the lock and not reviewed thoroughly)
> >>>>>>>>>>>        - up to you to decide.
> >>>>>>>>>>>
> >>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>> David
> >>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> >>>>>>>>>>>> If there are multiple instances of the VCN running,
> >>>>>>>>>>>> we may end up switching the video profile while another
> >>>>>>>>>>>> instance is active because we only take into account
> >>>>>>>>>>>> the current instance's submissions.  Look at all
> >>>>>>>>>>>> outstanding fences for the video profile.
> >>>>>>>>>>>>
> >>>>>>>>>>>> v2: drop early exit in begin_use()
> >>>>>>>>>>>> v3: handle possible race between begin_use() work handler
> >>>>>>>>>>>>
> >>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profil=
e
> >>>>>>>>>>>> handling")
> >>>>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.co=
m> (v1)
> >>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
> >>>>>>>>>>>> ++++++++++++-------------
> >>>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >>>>>>>>>>>>        2 files changed, 21 insertions(+), 20 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
> >>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
> >>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>>>            struct amdgpu_vcn_inst *vcn_inst =3D
> >>>>>>>>>>>>                    container_of(work, struct amdgpu_vcn_inst=
,
> >>>>>>>>>>>> idle_work.work);
> >>>>>>>>>>>>            struct amdgpu_device *adev =3D vcn_inst->adev;
> >>>>>>>>>>>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTAN=
CES] =3D {0};
> >>>>>>>>>>>> -     unsigned int i =3D vcn_inst->inst, j;
> >>>>>>>>>>>> +     unsigned int total_fences =3D 0,
> >>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0};
> >>>>>>>>>>>> +     unsigned int i, j;
> >>>>>>>>>>>>            int r =3D 0;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
> >>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
> >>>>>>>>>>>>                    return;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j=
)
> >>>>>>>>>>>> -             fence[i] +=3D
> >>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> >>>>>>>>>>>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[=
i];
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>>>>>>>>>>> +                     fence[i] +=3D
> >>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
> >>>>>>>>>>>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v->r=
ing_dec);
> >>>>>>>>>>>> +             total_fences +=3D fence[i];
> >>>>>>>>>>>> +     }
> >>>>>>>>>>>>
> >>>>>>>>>>>>            /* Only set DPG pause for VCN3 or below, VCN4 and=
 above will
> >>>>>>>>>>>> be handled by FW */
> >>>>>>>>>>>>            if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
> >>>>>>>>>>>>                    struct dpg_pause_state new_state;
> >>>>>>>>>>>>
> >>>>>>>>>>>>                    if (fence[i] ||
> >>>>>>>>>>>> @@ -436,18 +442,18 @@ static void
> >>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>>>                    else
> >>>>>>>>>>>>                            new_state.fw_based =3D VCN_DPG_ST=
ATE__UNPAUSE;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &ne=
w_state);
> >>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state)=
;
> >>>>>>>>>>>>            }
> >>>>>>>>>>>>
> >>>>>>>>>>>> -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ri=
ng_dec);
> >>>>>>>>>>>> -     fences +=3D fence[i];
> >>>>>>>>>>>> -
> >>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submissio=
n_cnt)) {
> >>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
> >>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
> >>>>>>>>>>>> +             /* This is specific to this instance */
> >>>>>>>>>>>>                    mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>                    vcn_inst->set_pg_state(vcn_inst, AMD_PG_S=
TATE_GATE);
> >>>>>>>>>>>>                    mutex_unlock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
> >>>>>>>>>>>> +             /* This is global and depends on all VCN insta=
nces */
> >>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
> >>>>>>>>>>>> !total_fences &&
> >>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
> >>>>>>>>>>>>                            r =3D amdgpu_dpm_switch_power_pro=
file(adev,
> >>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>>>>>> false);
> >>>>>>>>>>>>                            if (r)
> >>>>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>>>>>> amdgpu_ring *ring)
> >>>>>>>>>>>>            int r =3D 0;
> >>>>>>>>>>>>
> >>>>>>>>>>>>            atomic_inc(&vcn_inst->total_submission_cnt);
> >>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>>>>>> move this addition down inside the mutex lock
> >>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
> >>>>>>>>>>>>
> >>>>>>>>>>>> -     /* We can safely return early here because we've cance=
lled the
> >>>>>>>>>>>> -      * the delayed work so there is no one else to set it =
to false
> >>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
> >>>>>>>>>>>> -      */
> >>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
> >>>>>>>>>>>> -             goto pg_lock;
> >>>>>>>>>>>> -
> >>>>>>>>>>>>            mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>> move to here:
> >>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>>>>>> I think this should work for multiple instances.
> >>>>>>>>>> Why does this need to be protected by the mutex?
> >>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
> >>>>>>>>> David
> >>>>>>>>>> Alex
> >>>>>>>>>>
> >>>>>>>>>>> David
> >>>>>>>>>>>>            if (!adev->vcn.workload_profile_active) {
> >>>>>>>>>>>>                    r =3D amdgpu_dpm_switch_power_profile(ade=
v,
> >>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>>>>>> amdgpu_ring *ring)
> >>>>>>>>>>>>            }
> >>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>>
> >>>>>>>>>>>> -pg_lock:
> >>>>>>>>>>>>            mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>            vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNG=
ATE);
> >>>>>>>>>>>>
> >>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdg=
pu_ring
> >>>>>>>>>>>> *ring)
> >>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submissio=
n_cnt);
> >>>>>>>>>>>>
> >>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_=
cnt);
> >>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >>>>>>>>>>>>
> >>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_w=
ork,
> >>>>>>>>>>>>                                  VCN_IDLE_TIMEOUT);
> >>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
> >>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >>>>>>>>>>>>
> >>>>>>>>>>>>            uint16_t inst_mask;
> >>>>>>>>>>>>            uint8_t num_inst_per_aid;
> >>>>>>>>>>>> +     atomic_t                total_submission_cnt;
> >>>>>>>>>>>>
> >>>>>>>>>>>>            /* IP reg dump */
> >>>>>>>>>>>>            uint32_t                *ip_dump;
