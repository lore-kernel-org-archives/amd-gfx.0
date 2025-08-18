Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85E2CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 19:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A99510E14D;
	Mon, 18 Aug 2025 19:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RV+Vr4qi";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A473D10E14D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 19:31:32 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3234f8df749so283319a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755545492; x=1756150292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wIqp+APrkitRdOvKYgSnfNJjcNrqo48onzMgJ/NSKQ=;
 b=RV+Vr4qibcUFMtAS0/dLzCK9qzj+m7TNbgQ/fO2ErVxYijNeHUvCznXpHdFY4GST5L
 n5fQ1YryyyUF+nvXkAtDHYTY+4NNMDRiouYb+cMDewG0lhwrn+4XyeMcNUMCVCiBhH3W
 wzXwscPq4d2VW2d27+iPHsoneayBKqaLPEG0ZQLmLua0e+rcQ/z3gVh+YoYNUxva8du/
 mcew8cnmVdqMz4TPKt3MPFQJbsc+ly4cjh5/Jre4Npn2A9nLhC85t7efLh72LnYGdWrc
 jpyQUNxgTYETHy1smGP2yV5ILtoPBhA37j9T2EsVXo5GJQmsXLUlyMH8NhSP3+H3maA5
 Mziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755545492; x=1756150292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0wIqp+APrkitRdOvKYgSnfNJjcNrqo48onzMgJ/NSKQ=;
 b=bLanIwS04rsNmjz4sEcFjWVgDiSj1QZ+0QNLgzdgKo6CUP1KnQZMNWZQL6K5WAVtWE
 /w3EAgTjnEl9A49OU9ZB2zXSOoLppVTIQj7fbXCmu8HMF166OJ7pqAWVnSNQFWbOCsnJ
 z9XgCesfxC6tWgcAvQKjw7SG1BgiYpL6Z/OSrhwOZiNsBZtVWsUuJl7cpWXrvyze/HDy
 NecZz9IGe9PsC9ajGsM9zm8xlVlpmXbm2RtETHprOMTemBNJn41B6k5BUtSoT+7NqvjF
 AMSGUETNfrd0i1H5jGy37RJL7FNbYn9uW6OgNGQ4jdWjSyhC4WS/a9uRmXvBrukZd1pc
 9X6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dtPXkt3cEEo6Jp8zbiVC5o56E40RElOFDSEWFhhIpcXV55gcMaAtcKE3FwziM9KGR/7Eu44E@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyC5eOHX5IqedzlFAdt2Elntpjb0AXc4sT9Y/BPcgeW7M8/q7al
 m3hyVNbDA+NqOw24ZjDaPutvPIa6PnjzWa2vOMkihSV9aZFMYy2J3H/7cbfsKZ0BPgIZPosCRt3
 AL3ERLksvA5kvtshvqmfQfbnoaHRvX9Kbiw==
X-Gm-Gg: ASbGncsSNnYDb9zEufDL2HxKHz2QiPcjCFWDvwr3g/1AS8OW0KceV8CCPLbS8X4hS4n
 8dGAV6Ro3QPl1M4iEO8xuouMb4FvC0S4XeZPrEeBD2VfZNP7eql8Y1tyBVE14cqbQ2SPA1NrAKq
 IfbsHkQ5eehwtRntMyVOSe7JytCPB/f2EtBZ6Gwak5wW87QnU3ZtSij2OeNDJPbxKOM3mA7qBPT
 ht9tb8=
X-Google-Smtp-Source: AGHT+IFP2ZY/YdgJVVNK2AOh+GNPbdKjF6nHpPPzdHuVL28hkd8Hv5i/pUslc/89oe25jaijN4D50gJpeVWW2aNwBs8=
X-Received: by 2002:a17:902:d488:b0:234:f1b5:6e9b with SMTP id
 d9443c01a7336-2446d6d4c76mr94703305ad.1.1755545491906; Mon, 18 Aug 2025
 12:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
 <DS0PR12MB780432BEB1D74FE5685273F59735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <6ecd4ff4-d427-6c62-0c9f-21b7c601de79@amd.com>
 <DS0PR12MB780439434F2D1BD589ABC9359735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <3e0fe19f-68af-5802-0a33-bb5b63132f9e@amd.com>
 <DS0PR12MB78044AEE4BC81BD6338492DB9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <535641b0-6fb2-4541-ae89-c8f278869eb4@amd.com>
 <DS0PR12MB7804E1DB7C7882D3F0EA7EED9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <2d89d9f9-4dff-4de7-96c6-6176df98312f@amd.com>
 <8292ca54-d5f5-418f-82d0-7c70ac47c6a6@amd.com>
In-Reply-To: <8292ca54-d5f5-418f-82d0-7c70ac47c6a6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 15:31:19 -0400
X-Gm-Features: Ac12FXxpbDmIjnGF_I0IQzzxcVQgGLPIyTyDsaqdnc609ZR7QYbV-ju3ueqrdZ0
Message-ID: <CADnq5_MfS_zveTrcdRPX3efLcVmm20jv=iKyOwVkpTjyoaKXHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: David Wu <davidwu2@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wu, David" <David.Wu3@amd.com>, 
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Aug 18, 2025 at 3:23=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> Hi Lijo and Alex,
>
> I prefer Lijo's method as it should not cause unexpected power profile ch=
ange for the active session.
> Liji, could you make some adjustments for your patch such as removing ext=
ra blank line and function
> declaration such as using "void" instead of "int" for the new functions (=
should they be static?)

I still don't understand how you can get a case where the profile
would change for the active session with my patch.  That said, I think
Lijo's patch is nicer because it avoids the extra atomic.

Alex

>
> Thanks,
>
> David
>
> On 2025-08-14 14:42, David Wu wrote:
>
> hmm.. it is my concern for the same instance. but I got it now. Your patc=
h is good.
> Thanks,
> David
> On 2025-08-14 14:06, Lazar, Lijo wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> I didn't fully understand the question.
>
> For the same instance, begin_thread will set the power state only after c=
ancelling any idle worker for the instance. If idle worker is already under=
 progress, then it needs to complete as that's a cancel_sync (it's the exis=
ting logic).
>
> Basically, by the time begin_thread sets the PG state, no idle worker for=
 the same vcn instance would be active. If it's about context switch to ano=
ther vcn instance's begin_thread, I think that won't be a problem.
>
> Thanks,
> Lijo
> ________________________________
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, August 14, 2025 11:14:26 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Sundararaju, Sathishkumar <Sathishk=
umar.Sundararaju@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deucher@=
amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3=
)
>
> amdgpu_vcn_idle_work_handler():
>      if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> ----------- could it be possible a context switch here to
> amdgpu_vcn_ring_begin_use()?
>   if it could then AMD_PG_STATE_GATE will be set by mistake.
>
> David
>
> On 2025-08-14 08:54, Lazar, Lijo wrote:
> > [Public]
> >
> > The request profile can be moved outside the pg_lock in begin_use as in=
 the attached patch. It needs  set power state -> set profile order.
> >
> > This is the premise -
> >
> > Let's say there are two threads, begin_use thread and idle_work threads=
. begin_use and idle_work will need the workprofile mutex to request a prof=
ile.
> >
> > Case 1) Idle thread gets the lock first.
> >          a) Idle thread sees vinst power state as PG_UNGATE, no harm do=
ne. It exits without requesting power profile change. begin_use thread gets=
 the lock next, it sees profile as active and continues.
> >          b) Idle thread sees vinst power state as PG_GATE, it will make=
 workprofile_active to false and exit. Now when begin_use thread gets the m=
utex next, it's guaranteed to see the workprofile_active as false, hence it=
 will request the profile.
> >
> > Case 2) begin_use thread gets the lock first.
> >          a) Workload profile is active, hence it doesn't do anything an=
d exits. The change made by begin_use thread to vinst power state (state =
=3D on) will now be visible to idle thread which gets the lock next. It wil=
l do nothing and exit.
> >          b) Workload profile is inactive, hence it requests a profile c=
hange. Again, the change made by begin_use thread to vinst power state will=
 now be visible to idle thread which gets the lock next. It will do nothing=
 and exit.
> >
> > Thanks,
> > Lijo
> >
> > -----Original Message-----
> > From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> > Sent: Thursday, August 14, 2025 6:18 PM
> > To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.c=
om>
> > Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deuche=
r@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (=
v3)
> >
> >
> > On 8/14/2025 5:33 PM, Lazar, Lijo wrote:
> >> [Public]
> >>
> >> There is no need for nested lock. It only needs to follow the order
> >>           set instance power_state
> >>           set profile (this takes a global lock and hence instance pow=
er state will be visible to whichever thread that gets the work profile loc=
k).
> >>
> >> You are seeing nested lock just because I added the code just after po=
wer state setting.
> > Pasting your code from the file for ref :
> >
> > @@ -464,32 +509,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> > *ring)
> >
> > -pg_lock:
> >
> >        mutex_lock(&vcn_inst->vcn_pg_lock);
> >        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> >
> > +   amdgpu_vcn_get_profile(adev);
> >
> > vcn_pg_lock isn't  released here yet right ? And in-case you intend to =
only order the locks, then still there is an un-necessary OFF followed by O=
N, but yes that is acceptable,
> >
> > May be you want to move that vcn_pg_lock after amdgpu_vcn_get_profile t=
o protect concurrent dpg_state access in begin_use.
> >
> > The concern is, this patch access power_state that is protected by some=
 other mutex lock hoping it reflects right values also when holding powerpr=
ofile_lock.
> >
> > Or
> >
> > Have shared a patch with global workload_profile_mutex that simplifies =
this handling, and renamed pg_lock -> dpg_lock  and used
> >
> > that only for dpg_state changes per instance.
> >
> > Regards,
> >
> > Sathish
> >
> >> Thanks,
> >> Lijo
> >>
> >> -----Original Message-----
> >> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> >> Sent: Thursday, August 14, 2025 5:23 PM
> >> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
> >> <alexdeucher@gmail.com>
> >> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
> >> (v3)
> >>
> >>
> >> On 8/14/2025 3:16 PM, Lazar, Lijo wrote:
> >>> [Public]
> >>>
> >>> I see your point now. Attached should work, I guess. Is the concern m=
ore about having to take the lock for every begin?
> >> This is closer,  but the thing is, IMO we shouldn't have to use 2 lock=
s and go into nested locking, we can do with just one global lock.
> >>
> >> Power_state of each instance, and global workload_profile_active are
> >> inter-related, they need to be guarded together,
> >>
> >> nested could work , but why nested if single lock is enough ? nested c=
omplicates it.
> >>
> >> Regards,
> >>
> >> Sathish
> >>
> >>> Thanks,
> >>> Lijo
> >>>
> >>> -----Original Message-----
> >>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >>> Lazar, Lijo
> >>> Sent: Thursday, August 14, 2025 2:55 PM
> >>> To: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>;
> >>> Alex Deucher <alexdeucher@gmail.com>
> >>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
> >>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> >>> Subject: RE: [PATCH] drm/amdgpu/vcn: fix video profile race condition
> >>> (v3)
> >>>
> >>> [Public]
> >>>
> >>> That is not required I think. The power profile is set by an instance=
 *after* setting itself to power on. Also, it's switched back after changin=
g its power state to off.  If idle worker is run by another instance, it wo=
n't be seeing the inst0 as power gated and won't change power profile.
> >>>
> >>> Thanks,
> >>> Lijo
> >>> -----Original Message-----
> >>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> >>> Sent: Thursday, August 14, 2025 2:41 PM
> >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
> >>> <alexdeucher@gmail.com>
> >>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
> >>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> >>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
> >>> (v3)
> >>>
> >>> Hi Lijo,
> >>>
> >>> On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
> >>>> [Public]
> >>>>
> >>>> We already have a per instance power state that can be tracked. What=
 about something like attached?
> >>> This also has concurrent access of the power state ,
> >>> vcn.inst[i].cur_state is not protected by workload_profile_mutex
> >>>
> >>> every where, it can still change while you are holding workload_profi=
le_mutex and checking it.
> >>>
> >>> Regards,
> >>>
> >>> Sathish
> >>>
> >>>> Thanks,
> >>>> Lijo
> >>>> -----Original Message-----
> >>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >>>> Sundararaju, Sathishkumar
> >>>> Sent: Thursday, August 14, 2025 4:43 AM
> >>>> To: Alex Deucher <alexdeucher@gmail.com>
> >>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
> >>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> >>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race
> >>>> condition
> >>>> (v3)
> >>>>
> >>>>
> >>>> On 8/14/2025 3:38 AM, Alex Deucher wrote:
> >>>>> On Wed, Aug 13, 2025 at 5:1=E2=80=AFPM Sundararaju, Sathishkumar
> >>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
> >>>>>>> On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Sundararaju, Sathishkumar
> >>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
> >>>>>>>>> On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkum=
ar
> >>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
> >>>>>>>>>> Hi Alex, Hi David,
> >>>>>>>>>>
> >>>>>>>>>> I see David's concern but his suggestion yet wont solve the
> >>>>>>>>>> problem, neither the current form , reason :-
> >>>>>>>>>>
> >>>>>>>>>> The emitted fence count and total submission count are fast
> >>>>>>>>>> transients which frequently become 0 in between video decodes
> >>>>>>>>>> (between jobs) even with the atomics and locks there can be a
> >>>>>>>>>> switch of video power profile, in the current form of patch
> >>>>>>>>>> that window is minimized, but still can happen if stress
> >>>>>>>>>> tested. But power state of any instance becoming zero
> >>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
> >>>>>>>> Consider this situation, inst0 and inst1 actively decoding,
> >>>>>>>> inst0 decode completes, delayed idle work starts.
> >>>>>>>> inst0 idle handler can read 0 total fences and 0 total
> >>>>>>>> submission count, even if inst1 is actively decoding, that's bet=
ween the jobs,
> >>>>>>>>         - as begin_use increaments vcn.total_submission_cnt and
> >>>>>>>> end_use decreaments vcn.total_submission_cnt that can be 0.
> >>>>>>>>         - if outstanding fences are cleared and no new emitted
> >>>>>>>> fence, between jobs , can be 0.
> >>>>>>>>         - both of the above conditions do not mean video decode
> >>>>>>>> is complete on inst1, it is actively decoding.
> >>>>>>> How can there be active decoding without an outstanding fence?
> >>>>>>> In that case, total_fences (fences from both instances) would be =
non-0.
> >>>>>> I mean on inst1 the job scheduled is already complete, so 0
> >>>>>> outstanding fences, newer job is yet to be scheduled
> >>>>>>
> >>>>>> and commited to ring (inst1) , this doesn't mean decode has
> >>>>>> stopped on
> >>>>>> inst1 right (I am saying if timing of inst0 idle work coincides
> >>>>>> with this),
> >>>>>>
> >>>>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
> >>>>>> correct my understanding here.
> >>>>> The flow looks like:
> >>>>>
> >>>>> begin_use(inst)
> >>>>> emit_fence(inst)
> >>>>> end_use(inst)
> >>>>>
> >>>>> ...later
> >>>>> fence signals
> >>>>> ...later
> >>>>> work handler
> >>>>>
> >>>>> In begin_use we increment the global and per instance submission.
> >>>>> This protects the power gating and profile until end_use.  In end
> >>>>> use we decrement the submissions because we don't need to protect
> >>>>> anything any more as we have the fence that was submitted via the
> >>>>> ring.  That fence won't signal until the job is complete.
> >>>> Is a next begin_use always guaranteed to be run before current job f=
ence signals ?
> >>>>
> >>>> if not then both total submission and total fence are zero , example
> >>>> delayed job/packet submissions
> >>>>
> >>>> from user space, or next job schedule happens after current job fenc=
e signals.
> >>>>
> >>>> if this is never possible then (v3) is perfect.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Sathish
> >>>>
> >>>>> For power gating, we
> >>>>> only care about the submission count and fences for that instance,
> >>>>> for the profile, we care about submission count and fences all inst=
ances.
> >>>>> Once the fences have signalled, the outstanding fences will be 0
> >>>>> and there won't be any active work.
> >>>>>
> >>>>> Alex
> >>>>>
> >>>>>> Regards,
> >>>>>>
> >>>>>> Sathish
> >>>>>>
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>> Whereas if instances are powered off we are sure idle time is
> >>>>>>>> past and it is powered off, no possible way of active video
> >>>>>>>> decode, when all instances are off we can safely assume no
> >>>>>>>> active decode and global lock protects it against new begin_use =
on any instance.
> >>>>>>>> But the only distant concern is global common locks w.r.t perf,
> >>>>>>>> but we are already having a global workprofile mutex , so there
> >>>>>>>> shouldn't be any drop in perf, with just one single global lock
> >>>>>>>> for all instances.
> >>>>>>>>
> >>>>>>>> Just sending out a patch with this fix, will leave it to you to
> >>>>>>>> decide the right method. If you think outstanding total fences
> >>>>>>>> can never be 0 during decode, then your previous version (v3)
> >>>>>>>> itself is good, there is no real benefit of splitting the handle=
rs as such.
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Sathish
> >>>>>>>>> If it is possible, maybe it would be easier to just split the
> >>>>>>>>> profile and powergating into separate handlers.  The profile
> >>>>>>>>> one would be global and the powergating one would be per instan=
ce.
> >>>>>>>>> See the attached patches.
> >>>>>>>>>
> >>>>>>>>> Alex
> >>>>>>>>>
> >>>>>>>>>> can be a sure shot indication of break in a video decode, the
> >>>>>>>>>> mistake in my patch was using per instance mutex, I should
> >>>>>>>>>> have used a common global mutex, then that covers the situatio=
n David is trying to bring out.
> >>>>>>>>>>
> >>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
> >>>>>>>>>> flags to track power state could help us totally avoid this si=
tuation.
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
> >>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer
> >>>>>>>>>>>>> in case someone adds more before the lock and not reviewed
> >>>>>>>>>>>>> thoroughly)
> >>>>>>>>>>>>>           - up to you to decide.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>> David
> >>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> >>>>>>>>>>>>>> If there are multiple instances of the VCN running, we may
> >>>>>>>>>>>>>> end up switching the video profile while another instance
> >>>>>>>>>>>>>> is active because we only take into account the current
> >>>>>>>>>>>>>> instance's submissions.  Look at all outstanding fences
> >>>>>>>>>>>>>> for the video profile.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> v2: drop early exit in begin_use()
> >>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload
> >>>>>>>>>>>>>> profile
> >>>>>>>>>>>>>> handling")
> >>>>>>>>>>>>>> Reviewed-by: Sathishkumar S
> >>>>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
> >>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>           drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
> >>>>>>>>>>>>>> ++++++++++++-------------
> >>>>>>>>>>>>>>           drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >>>>>>>>>>>>>>           2 files changed, 21 insertions(+), 20
> >>>>>>>>>>>>>> deletions(-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
> >>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
> >>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>>>>>>>>>>>               struct amdgpu_vcn_inst *vcn_inst =3D
> >>>>>>>>>>>>>>                       container_of(work, struct
> >>>>>>>>>>>>>> amdgpu_vcn_inst, idle_work.work);
> >>>>>>>>>>>>>>               struct amdgpu_device *adev =3D vcn_inst->ade=
v;
> >>>>>>>>>>>>>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INST=
ANCES] =3D {0};
> >>>>>>>>>>>>>> -     unsigned int i =3D vcn_inst->inst, j;
> >>>>>>>>>>>>>> +     unsigned int total_fences =3D 0,
> >>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0};
> >>>>>>>>>>>>>> +     unsigned int i, j;
> >>>>>>>>>>>>>>               int r =3D 0;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
> >>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 <<
> >>>>>>>>>>>>>> + vcn_inst->inst))
> >>>>>>>>>>>>>>                       return;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; +=
+j)
> >>>>>>>>>>>>>> -             fence[i] +=3D
> >>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> >>>>>>>>>>>>>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =3D
> >>>>>>>>>>>>>> + &adev->vcn.inst[i];
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>>>>>>>>>>>>> +                     fence[i] +=3D
> >>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
> >>>>>>>>>>>>>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v-=
>ring_dec);
> >>>>>>>>>>>>>> +             total_fences +=3D fence[i];
> >>>>>>>>>>>>>> +     }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>               /* Only set DPG pause for VCN3 or below, VCN=
4
> >>>>>>>>>>>>>> and above will be handled by FW */
> >>>>>>>>>>>>>>               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG =
&&
> >>>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
> >>>>>>>>>>>>>>                       struct dpg_pause_state new_state;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>                       if (fence[i] || @@ -436,18 +442,18 @=
@
> >>>>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct
> >>>>>>>>>>>>>> work_struct
> >>>>>>>>>>>>>> *work)
> >>>>>>>>>>>>>>                       else
> >>>>>>>>>>>>>>                               new_state.fw_based =3D
> >>>>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &=
new_state);
> >>>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst,
> >>>>>>>>>>>>>> + &new_state);
> >>>>>>>>>>>>>>               }
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
> >>>>>>>>>>>>>>                       mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>>>                       vcn_inst->set_pg_state(vcn_inst, AMD=
_PG_STATE_GATE);
> >>>>>>>>>>>>>>                       mutex_unlock(&vcn_inst->vcn_pg_lock)=
;
> >>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
> >>>>>>>>>>>>>> +             /* This is global and depends on all VCN ins=
tances */
> >>>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
> >>>>>>>>>>>>>> !total_fences &&
> >>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
> >>>>>>>>>>>>>>                               r =3D
> >>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
> >>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, false);
> >>>>>>>>>>>>>>                               if (r) @@ -467,16 +473,10 @@
> >>>>>>>>>>>>>> void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> >>>>>>>>>>>>>>               int r =3D 0;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>               atomic_inc(&vcn_inst->total_submission_cnt);
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
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
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
> >>>>>>>>>>>>>>               if (!adev->vcn.workload_profile_active) {
> >>>>>>>>>>>>>>                       r =3D
> >>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
> >>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, @@ -487,7 +487,6 @@ void
> >>>>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> >>>>>>>>>>>>>>               }
> >>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -pg_lock:
> >>>>>>>>>>>>>>               mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>>>>>>>>>>>               vcn_inst->set_pg_state(vcn_inst,
> >>>>>>>>>>>>>> AMD_PG_STATE_UNGATE);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
> >>>>>>>>>>>>>> amdgpu_ring
> >>>>>>>>>>>>>> *ring)
> >>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submiss
> >>>>>>>>>>>>>> i
> >>>>>>>>>>>>>> o
> >>>>>>>>>>>>>> n
> >>>>>>>>>>>>>> _cnt);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submissio
> >>>>>>>>>>>>>> n
> >>>>>>>>>>>>>> _
> >>>>>>>>>>>>>> c
> >>>>>>>>>>>>>> nt);
> >>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle=
_work,
> >>>>>>>>>>>>>>                                     VCN_IDLE_TIMEOUT); dif=
f
> >>>>>>>>>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
> >>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>               uint16_t inst_mask;
> >>>>>>>>>>>>>>               uint8_t num_inst_per_aid;
> >>>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>               /* IP reg dump */
> >>>>>>>>>>>>>>               uint32_t                *ip_dump;
