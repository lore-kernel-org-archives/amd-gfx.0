Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F59DCA0EE6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 18:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3283C10E8CC;
	Thu, 14 Aug 2025 18:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPUkKvro";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D06110E8CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 18:00:56 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-323267b7985so192692a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755194456; x=1755799256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PfFsaj4cCfcD4nAy0/r3FBAcPtULMoE0uvGvvWmgac=;
 b=nPUkKvroFJKVBOoi6s0R96YvIF014Sg0l/VKtofynLvqjDN15+GDaeBQF8vJguL/mH
 /ew6YEW/xtCpvPRiENVRXEQSC7r18ppwYh9xvQ2TWgzGpU6h/cuQa7U+lcauTXD7To9i
 Z8EdTMGVgxD595aCP+5LjIXfNZSn50GkcpDlH4z3vXnXBZ2X4dozw10K9JZ1VFqr9Veu
 4vRpJoM4k0MkXPQqy2+unzhh4RKuFtpbin6nUfZLZi43c1wp0Y513HjNdO743z+F5mos
 rWSRKJY1X7suLydYbU/QDEp8e4WtOIghluVaMfJibHD76Q6wgcldXpdx57RyK/grfZch
 7HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194456; x=1755799256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PfFsaj4cCfcD4nAy0/r3FBAcPtULMoE0uvGvvWmgac=;
 b=CEuLRZjKOWRIQbwdNyLdpe3zGweEU6VA7EiD1Z2eN+XgrpgDfofOMzbRWDo0GPjCCp
 TUTt0zvs5yZuWw4Boo1kaUH6pHPGLz2BKEN1WX//xBV5WBHn34uq4JqilIm0X33XEly/
 oqfHmgwyDADeaDbqpZCDRV3nPPROtyN9uMjvq83exM0w3KehY/fFBDvh79bLKnaEovrt
 +W2wQtuakI7Y2REz0yc4ZkI+wO6jwAxGPpQwbEcsi2HZSj1XprCVx6YmRobDkBKCMhhn
 d2kRNM2QZaf4kR2bCd2yz9mp0Z3jG05y/zNeqI5By3CrDwbC4VuvZ4MjWaXTQJKjgIeA
 pzfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFHvuB6zF65bdH5T0r8QcF1mTPQPcFf2s21QrDNoYYnV/LuixWVPPH6+OaxCPZUj6cjJFfyT0q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKHJO5l3b1q5ilcqsf77JW6vpwCkayuvCdEfyiOpG5ooXl9XzW
 Sd8ZRsbJmM/aXQJ96OvER81OlwTapO4jFGFGt/xQAZbSMLb6zTU8N9cyqq2rhHQV0PRpFaalTex
 QwKEDytCcilgZbliwPSFrKffHn5pw850=
X-Gm-Gg: ASbGncspiRW4Ro5wqdljhD/UdmFkPzzt+L+jh8NncPu6+9AVoRNNcqzWWyug0Lpm6hQ
 Qj8VAb7djqU0btu5gTf5SHUoug7wgrEqmyT1QRb7xBfYL/vTwRPhr32rFrlkGeG7HV2/B6z8+2l
 E3JmWchYbGfchnRQjIxv9UnEHDF6yVWeRgq28c1+mYjkyHTK+WS/XAfYf75jrIr5b/U36+UfU1b
 OR1eE1Pa8waP4VjZg==
X-Google-Smtp-Source: AGHT+IFmqEupZyLAqUU6kbRMGKO1z5jSQ3YXMfyBW6RTXWpJ0AjVmRXphvQvqOxRlN+uJijkIbpeBv9rRGy5RuIaZrw=
X-Received: by 2002:a17:90b:4d82:b0:31f:3353:471e with SMTP id
 98e67ed59e1d1-32327c893c7mr2974149a91.4.1755194455414; Thu, 14 Aug 2025
 11:00:55 -0700 (PDT)
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
 <CADnq5_NutFtDzq3xwcfLr6dHtWaEKDwV5-kXrDpNBCM2DjWb-Q@mail.gmail.com>
 <04e0a9f2-d8ea-4383-8fb6-b7422d6f9ff6@amd.com>
In-Reply-To: <04e0a9f2-d8ea-4383-8fb6-b7422d6f9ff6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Aug 2025 14:00:42 -0400
X-Gm-Features: Ac12FXw3VoHQVoaqL_IHIiryBLUeCuD8yG2jJrn3t0D260iBic07qWduIk_Iahk
Message-ID: <CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 12:44=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
>
> On 2025-08-14 12:01, Alex Deucher wrote:
> > On Thu, Aug 14, 2025 at 11:35=E2=80=AFAM David Wu <davidwu2@amd.com> wr=
ote:
> >> On 2025-08-14 08:56, Alex Deucher wrote:
> >>> On Wed, Aug 13, 2025 at 7:06=E2=80=AFPM Wu, David <davidwu2@amd.com> =
wrote:
> >>>> On 8/13/2025 6:11 PM, Alex Deucher wrote:
> >>>>> On Wed, Aug 13, 2025 at 5:47=E2=80=AFPM Wu, David <davidwu2@amd.com=
> wrote:
> >>>>>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
> >>>>>>> On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Sundararaju, Sathishkumar
> >>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
> >>>>>>>>> On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkum=
ar
> >>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>>>>>> Hi Alex, Hi David,
> >>>>>>>>>>
> >>>>>>>>>> I see David's concern but his suggestion yet wont solve the pr=
oblem,
> >>>>>>>>>> neither the current form , reason :-
> >>>>>>>>>>
> >>>>>>>>>> The emitted fence count and total submission count are fast tr=
ansients
> >>>>>>>>>> which frequently become 0 in between video decodes (between jo=
bs) even
> >>>>>>>>>> with the atomics and locks there can be a switch of video powe=
r profile,
> >>>>>>>>>> in the current form of patch that window is minimized, but sti=
ll can
> >>>>>>>>>> happen if stress tested. But power state of any instance becom=
ing zero
> >>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
> >>>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst=
0 decode
> >>>>>>>> completes, delayed idle work starts.
> >>>>>>>> inst0 idle handler can read 0 total fences and 0 total submissio=
n count,
> >>>>>>>> even if inst1 is actively decoding,
> >>>>>>>> that's between the jobs,
> >>>>>>>>       - as begin_use increaments vcn.total_submission_cnt and en=
d_use
> >>>>>>>> decreaments vcn.total_submission_cnt that can be 0.
> >>>>>>>>       - if outstanding fences are cleared and no new emitted fen=
ce, between
> >>>>>>>> jobs , can be 0.
> >>>>>>>>       - both of the above conditions do not mean video decode is=
 complete on
> >>>>>>>> inst1, it is actively decoding.
> >>>>>>> How can there be active decoding without an outstanding fence?  I=
n
> >>>>>>> that case, total_fences (fences from both instances) would be non=
-0.
> >>>>>> I think it should be non-0.
> >>>>>> I do see a hiccup possible - i.e the power switching from ON to OF=
F then
> >>>>>> ON in the
> >>>>>> middle of decoding, i.e inst0 idle handler turns it off then inst1=
 turns
> >>>>>> it on.
> >>>>> How would that happen? As long as there submission cnt is non-0 and
> >>>>> there are outstanding fences on any instance, the video profile wil=
l
> >>>>> stay active.
> >>>> there could be no jobs but it doesn't timeout yet and new jobs will =
come in
> >>>> any ms - note all fences are done at this time. The idle handler see=
s no
> >>>> fences
> >>>> and no jobs so it turns off the power - but just ms later a new job =
is
> >>>> submitted
> >>>> from the same decode session which could be mpv player as it does no=
t
> >>>> need to
> >>>> submit jobs without delays. This will turn on the power.
> >>> I'm not following.  Every submission will start with begin_use().
> >> yes - it does - it can power on vcn but this happens in the middle of =
a
> >> decode session which has 10s timeout to call its own idle handler - in=
 fact
> >> the other instance's idle handler will power off vcn because it does n=
ot
> >> know it needs
> >> to wait until the decoding session times out.
> > I don't follow.  If there are no outstanding fences, there is no
> > reason to not power down the VCN instance and disable the video
> > profile. If there are still outstanding fences, then the VCN instance
> > those fences are associated with will stay on and the video profile
> > will stay enabled.  If the engine hangs and eventually gets reset, the
> > fence will be signalled and then there will be no outstanding fences
> > so the idle handler will eventually disable the power profile.  The
> > idle handler will keep getting rescheduled as long as there is still
> > oustanding work.
> inst0 and inst1:
> inst0 sends jobA, then ends jobA and no more job submitted in 500ms and
> job queue is empty - at this point  inst1's idle handler sees no
> outstanding fences/jobs
> then power off.  However inst0 starts to submit job after 500ms - inst0'
> idle handler
> has not started/scheduled to run but inst1's has finished already which
> does not know inst0 has not timed out or called its own idle handler.
> This violates the
> logic for idle handler's timeout condition. (i.e 10s timeout designed
> but timed out in 500ms)
> all this means it powered down too early for inst0.

I still don't follow.  Here's a sample flow.  Job comes in on inst 0
and then slightly later on inst 1.

Inst 0 job submission
Inst 0 calls begin_use().  This cancels the current inst worker
thread.  It enables the video profile and ungates the instance.
IBs and fence packets get submitted to instance 0 of the engine
Inst 0 calls end_use().  This schedules the worker thread for
VCN_IDLE_TIMEOUT jiffies in the future.

Inst 1 job submission:
Inst 1 calls begin_use().  This cancels the current inst worker
thread.  It sees the video profile is enabled and ungates the
instance.
IBs and fence packets get submitted to instance 1 of the engine
Inst 1 calls end_use().  This schedules the worker thread for
VCN_IDLE_TIMEOUT jiffies in the future.

inst 0 work hander runs.  Sees outstanding fences on inst 0; skips
powergating inst 0, skips disabling video profile. Schedules the
worker thread for VCN_IDLE_TIMEOUT jiffies in the future.

inst 0 IB completes and fence signals

inst 1 IB completes and fence signals

inst 1 work hander runs.  Sees no outstanding fences on inst 1.
powergates inst 1.  Check if there are any outstanding fences on other
instances.  Sees the no fences from inst 0 so disables the video
profile.

inst 0 work hander runs.  Sees no outstanding fences on inst 0.
powergates inst 0.  Check if there are any outstanding fences on other
instances.  Sees the no fences from inst 1, sees that video profile is
already disabled.

You can insert additional job submissions anywhere you want in the timeline=
.

Alex

> > Alex
> >
> >
> >>> Alex
> >>>
> >>>> David
> >>>>> Alex
> >>>>>
> >>>>>> We should avoid this glitch. This requires the idle handler sets/c=
lears
> >>>>>> a flag for
> >>>>>> done for this instance as Sathish's original patch. When all insta=
nces
> >>>>>> set/clear the
> >>>>>> flag then we can safely power off.
> >>>>>> David
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>> Whereas if instances are powered off we are sure idle time is pa=
st and
> >>>>>>>> it is powered off, no possible way of
> >>>>>>>> active video decode, when all instances are off we can safely as=
sume no
> >>>>>>>> active decode and global lock protects
> >>>>>>>> it against new begin_use on any instance. But the only distant c=
oncern
> >>>>>>>> is global common locks w.r.t perf, but we
> >>>>>>>> are already having a global workprofile mutex , so there shouldn=
't be
> >>>>>>>> any drop in perf, with just one single
> >>>>>>>> global lock for all instances.
> >>>>>>>>
> >>>>>>>> Just sending out a patch with this fix, will leave it to you to =
decide
> >>>>>>>> the right method. If you think outstanding total fences
> >>>>>>>> can never be 0 during decode, then your previous version (v3) it=
self is
> >>>>>>>> good, there is no real benefit of splitting the handlers as such=
.
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Sathish
> >>>>>>>>> If it is possible, maybe it would be easier to just split the p=
rofile
> >>>>>>>>> and powergating into separate handlers.  The profile one would =
be
> >>>>>>>>> global and the powergating one would be per instance.  See the
> >>>>>>>>> attached patches.
> >>>>>>>>>
> >>>>>>>>> Alex
> >>>>>>>>>
> >>>>>>>>>> can be a sure shot indication of break in a video decode, the =
mistake in
> >>>>>>>>>> my patch was using per instance mutex, I should have used a co=
mmon
> >>>>>>>>>> global mutex, then that covers the situation David is trying t=
o bring out.
> >>>>>>>>>>
> >>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using =
flags to
> >>>>>>>>>> track power state could help us totally avoid this situation.
> >>>>>>>>>>
> >>>>>>>>>> Regards,
> >>>>>>>>>>
> >>>>>>>>>> Sathish
> >>>>>>>>>>
> >>>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
> >>>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
> >>>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39=E2=80=AFPM Wu, David <davidwu2=
@amd.com> wrote:
> >>>>>>>>>>>>> Hi Alex,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
> >>>>>>>>>>>>> it is unlikely to have a context switch right after the beg=
in_use().
> >>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer=
 in case
> >>>>>>>>>>>>> someone
> >>>>>>>>>>>>> adds more before the lock and not reviewed thoroughly)
> >>>>>>>>>>>>>         - up to you to decide.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>> David
> >>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> >>>>>>>>>>>>>> If there are multiple instances of the VCN running,
> >>>>>>>>>>>>>> we may end up switching the video profile while another
> >>>>>>>>>>>>>> instance is active because we only take into account
> >>>>>>>>>>>>>> the current instance's submissions.  Look at all
> >>>>>>>>>>>>>> outstanding fences for the video profile.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> v2: drop early exit in begin_use()
> >>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload prof=
ile
> >>>>>>>>>>>>>> handling")
> >>>>>>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.=
com> (v1)
> >>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
> >>>>>>>>>>>>>> ++++++++++++-------------
> >>>>>>>>>>>>>>         drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >>>>>>>>>>>>>>         2 files changed, 21 insertions(+), 20 deletions(-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
> >>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
> >>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>>>>>             struct amdgpu_vcn_inst *vcn_inst =3D
> >>>>>>>>>>>>>>                     container_of(work, struct amdgpu_vcn_i=
nst,
> >>>>>>>>>>>>>> idle_work.work);
> >>>>>>>>>>>>>>             struct amdgpu_device *adev =3D vcn_inst->adev;
> >>>>>>>>>>>>>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INST=
ANCES] =3D {0};
> >>>>>>>>>>>>>> -     unsigned int i =3D vcn_inst->inst, j;
> >>>>>>>>>>>>>> +     unsigned int total_fences =3D 0,
> >>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0};
> >>>>>>>>>>>>>> +     unsigned int i, j;
> >>>>>>>>>>>>>>             int r =3D 0;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
> >>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst)=
)
> >>>>>>>>>>>>>>                     return;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; +=
+j)
> >>>>>>>>>>>>>> -             fence[i] +=3D
> >>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> >>>>>>>>>>>>>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =3D &adev->vcn.ins=
t[i];
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>>>>>>>>>>>>> +                     fence[i] +=3D
> >>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
> >>>>>>>>>>>>>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v-=
>ring_dec);
> >>>>>>>>>>>>>> +             total_fences +=3D fence[i];
> >>>>>>>>>>>>>> +     }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>             /* Only set DPG pause for VCN3 or below, VCN4 =
and above will
> >>>>>>>>>>>>>> be handled by FW */
> >>>>>>>>>>>>>>             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >>>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
> >>>>>>>>>>>>>>                     struct dpg_pause_state new_state;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>                     if (fence[i] ||
> >>>>>>>>>>>>>> @@ -436,18 +442,18 @@ static void
> >>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>>>>>                     else
> >>>>>>>>>>>>>>                             new_state.fw_based =3D VCN_DPG=
_STATE__UNPAUSE;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &=
new_state);
> >>>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_stat=
e);
> >>>>>>>>>>>>>>             }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->=
ring_dec);
> >>>>>>>>>>>>>> -     fences +=3D fence[i];
> >>>>>>>>>>>>>> -
> >>>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submiss=
ion_cnt)) {
> >>>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
> >>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
> >>>>>>>>>>>>>> +             /* This is specific to this instance */
> >>>>>>>>>>>>>>                     mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>>>                     vcn_inst->set_pg_state(vcn_inst, AMD_P=
G_STATE_GATE);
> >>>>>>>>>>>>>>                     mutex_unlock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
> >>>>>>>>>>>>>> +             /* This is global and depends on all VCN ins=
tances */
> >>>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
> >>>>>>>>>>>>>> !total_fences &&
> >>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
> >>>>>>>>>>>>>>                             r =3D amdgpu_dpm_switch_power_=
profile(adev,
> >>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>>>>>>>> false);
> >>>>>>>>>>>>>>                             if (r)
> >>>>>>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struc=
t
> >>>>>>>>>>>>>> amdgpu_ring *ring)
> >>>>>>>>>>>>>>             int r =3D 0;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>             atomic_inc(&vcn_inst->total_submission_cnt);
> >>>>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>>>>>>>> move this addition down inside the mutex lock
> >>>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -     /* We can safely return early here because we've can=
celled the
> >>>>>>>>>>>>>> -      * the delayed work so there is no one else to set i=
t to false
> >>>>>>>>>>>>>> -      * and we don't care if someone else sets it to true=
.
> >>>>>>>>>>>>>> -      */
> >>>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
> >>>>>>>>>>>>>> -             goto pg_lock;
> >>>>>>>>>>>>>> -
> >>>>>>>>>>>>>>             mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>>> move to here:
> >>>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
> >>>>>>>>>>>>> I think this should work for multiple instances.
> >>>>>>>>>>>> Why does this need to be protected by the mutex?
> >>>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex=
.
> >>>>>>>>>>> David
> >>>>>>>>>>>> Alex
> >>>>>>>>>>>>
> >>>>>>>>>>>>> David
> >>>>>>>>>>>>>>             if (!adev->vcn.workload_profile_active) {
> >>>>>>>>>>>>>>                     r =3D amdgpu_dpm_switch_power_profile(=
adev,
> >>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>>>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>>>>>>>>>>>> amdgpu_ring *ring)
> >>>>>>>>>>>>>>             }
> >>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -pg_lock:
> >>>>>>>>>>>>>>             mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>>>             vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_=
UNGATE);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct am=
dgpu_ring
> >>>>>>>>>>>>>> *ring)
> >>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submiss=
ion_cnt);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submissio=
n_cnt);
> >>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle=
_work,
> >>>>>>>>>>>>>>                                   VCN_IDLE_TIMEOUT);
> >>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
> >>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>             uint16_t inst_mask;
> >>>>>>>>>>>>>>             uint8_t num_inst_per_aid;
> >>>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>             /* IP reg dump */
> >>>>>>>>>>>>>>             uint32_t                *ip_dump;
