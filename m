Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42B0CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 19:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE1010E211;
	Thu, 14 Aug 2025 19:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bL+s3Yqs";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03E610E211
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 19:43:30 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-244580692f3so1823835ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755200610; x=1755805410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De3y00ByKUaLYblifJx19nLo8pB3yGYHdopy7sKOzNA=;
 b=bL+s3YqsmNv0fmq8B/xYyUYZHzVrfzUkB8nTA4+L+hKrrPVfjNJGcZK8Rawsg2Pb4g
 cuok4F6NZhpuQ+8YWFdIUfAwm2EJD9Vq7s1o4mbcETOAkdJ+lAxdZtYh2hvMGDUZwE//
 8a7s3ftWoPUwWWAbCsxtNiCVmI1mXSnT2W4cRnLgPJS1kUSA/SHAYUCUBJimyaxNQpVO
 a/lM/u8i9gT86Tu2mWkTacNl4uHOD8k/y5cjrQhOaeashjeRw6kl/5Xx2rdvGgr3zy7i
 3vv2PaYgFnXcbHRp9BJjzv0BNdLdNiCKnKEsXAimUZQ3STqBrxL3dCpnxjM5CtQst1ml
 mNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755200610; x=1755805410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=De3y00ByKUaLYblifJx19nLo8pB3yGYHdopy7sKOzNA=;
 b=UDuSq42FVf/mAqTgjxEojlge298B+mndOY3zGJqsXsEgxAUJF/3jrgM+0ODf47IPGd
 EkPjnK12SCRoM40+BdPQv19toej2w8RhC9XNvvjBj/uh6/rbqMqP/ekkSoR4YUmAFglQ
 54LQs/MCovRILn7fYOosQ2UtAx/m82fgrLkOiUw8DddY0MOOPp/B3nY0FjC1gs6mCKn7
 74pQfWoHbJZdkrMH9sk6Z8jh0V16NxrRicGOp4gszEed4d5I+zr4VdYqpFXkeV7hc8OX
 rFkCFuwdzJWolNhFXzc9G6AVuEznyJ6JhSYfvXo+YoOf+dHRjAZfO6/IT6+Nk1V0//au
 1LSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4OVeoSapQFXKnHc/Eev8lHGOxFw6VKe432Q+NGM6Xb40D4zCv+kwk5mDRXj7y2ycnCKzwlAU4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkUOOYv33V73us6HZSxI8YSA9SH78ukJwDYR9YTjIAqdu7GV0U
 mAf+U552NkFF5FFoj7AnVicfypluI0Kspefq0x6kzc7qIsIWVTq9f9wsEGqEMdtw5zy1ZlK+6x9
 BIwrn4i7stMDHqGKqWkODV0F8jC7OavU=
X-Gm-Gg: ASbGncsj1zw7OtNM/i0P4pUHTzjrS48eyP2Ha25LjuyKgg+ce6h5mn6aMrrAEtpgHfu
 cSzTCgN6ApYucdGPzRLgHDwCBu/KBTSpFj2NoQI0/ezZOyOePXOfGsGPXVTJYfsQuFWLH1sAgBQ
 jBRQ4sAe5f5lgoesQOMmZsXFqTiXrpbvP+/NdOSqx2PZm4iAajv5918+++pvnslaWlRbOleCjUs
 fdAFko=
X-Google-Smtp-Source: AGHT+IFB1XZzL5PUxoCBIihOs9MuAcBfSQ+DWwaK6itkfZpyH+vC3GTKVtdZAKcow619MnDaswlvQRUaKhTQe9qDbFk=
X-Received: by 2002:a17:902:e748:b0:240:764e:afab with SMTP id
 d9443c01a7336-2430d1e54e3mr63891515ad.6.1755200610168; Thu, 14 Aug 2025
 12:43:30 -0700 (PDT)
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
 <CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com>
 <31283d92-805f-49a2-a0b2-20146b79354b@amd.com>
In-Reply-To: <31283d92-805f-49a2-a0b2-20146b79354b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Aug 2025 15:43:18 -0400
X-Gm-Features: Ac12FXwQnKpEAaMdlPjKkXTue9qlQWSDpwKRKsWSWA6J2VnVNQL-_Safnl4FdIk
Message-ID: <CADnq5_OH9Jpkfm0b2keQRO6Wx1nj-dGfFs5mvkfQ83ZC3ox5xQ@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 3:18=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-08-14 14:00, Alex Deucher wrote:
>
> On Thu, Aug 14, 2025 at 12:44=E2=80=AFPM David Wu <davidwu2@amd.com> wrot=
e:
>
> On 2025-08-14 12:01, Alex Deucher wrote:
>
> On Thu, Aug 14, 2025 at 11:35=E2=80=AFAM David Wu <davidwu2@amd.com> wrot=
e:
>
> On 2025-08-14 08:56, Alex Deucher wrote:
>
> On Wed, Aug 13, 2025 at 7:06=E2=80=AFPM Wu, David <davidwu2@amd.com> wrot=
e:
>
> On 8/13/2025 6:11 PM, Alex Deucher wrote:
>
> On Wed, Aug 13, 2025 at 5:47=E2=80=AFPM Wu, David <davidwu2@amd.com> wrot=
e:
>
> On 8/13/2025 5:03 PM, Alex Deucher wrote:
>
> On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>
> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>
> On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>
> Hi Alex, Hi David,
>
> I see David's concern but his suggestion yet wont solve the problem,
> neither the current form , reason :-
>
> The emitted fence count and total submission count are fast transients
> which frequently become 0 in between video decodes (between jobs) even
> with the atomics and locks there can be a switch of video power profile,
> in the current form of patch that window is minimized, but still can
> happen if stress tested. But power state of any instance becoming zero
>
> Can you explain how this can happen?  I'm not seeing it.
>
> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
> completes, delayed idle work starts.
> inst0 idle handler can read 0 total fences and 0 total submission count,
> even if inst1 is actively decoding,
> that's between the jobs,
>       - as begin_use increaments vcn.total_submission_cnt and end_use
> decreaments vcn.total_submission_cnt that can be 0.
>       - if outstanding fences are cleared and no new emitted fence, betwe=
en
> jobs , can be 0.
>       - both of the above conditions do not mean video decode is complete=
 on
> inst1, it is actively decoding.
>
> How can there be active decoding without an outstanding fence?  In
> that case, total_fences (fences from both instances) would be non-0.
>
> I think it should be non-0.
> I do see a hiccup possible - i.e the power switching from ON to OFF then
> ON in the
> middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
> it on.
>
> How would that happen? As long as there submission cnt is non-0 and
> there are outstanding fences on any instance, the video profile will
> stay active.
>
> there could be no jobs but it doesn't timeout yet and new jobs will come =
in
> any ms - note all fences are done at this time. The idle handler sees no
> fences
> and no jobs so it turns off the power - but just ms later a new job is
> submitted
> from the same decode session which could be mpv player as it does not
> need to
> submit jobs without delays. This will turn on the power.
>
> I'm not following.  Every submission will start with begin_use().
>
> yes - it does - it can power on vcn but this happens in the middle of a
> decode session which has 10s timeout to call its own idle handler - in fa=
ct
> the other instance's idle handler will power off vcn because it does not
> know it needs
> to wait until the decoding session times out.
>
> I don't follow.  If there are no outstanding fences, there is no
> reason to not power down the VCN instance and disable the video
> profile. If there are still outstanding fences, then the VCN instance
> those fences are associated with will stay on and the video profile
> will stay enabled.  If the engine hangs and eventually gets reset, the
> fence will be signalled and then there will be no outstanding fences
> so the idle handler will eventually disable the power profile.  The
> idle handler will keep getting rescheduled as long as there is still
> oustanding work.
>
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
>
> I still don't follow.  Here's a sample flow.  Job comes in on inst 0
> and then slightly later on inst 1.
>
> Inst 0 job submission
> Inst 0 calls begin_use().  This cancels the current inst worker
> thread.  It enables the video profile and ungates the instance.
> IBs and fence packets get submitted to instance 0 of the engine
> Inst 0 calls end_use().  This schedules the worker thread for
> VCN_IDLE_TIMEOUT jiffies in the future.
>
> Inst 1 job submission:
> Inst 1 calls begin_use().  This cancels the current inst worker
> thread.  It sees the video profile is enabled and ungates the
> instance.
> IBs and fence packets get submitted to instance 1 of the engine
> Inst 1 calls end_use().  This schedules the worker thread for
> VCN_IDLE_TIMEOUT jiffies in the future.
>
> inst 0 work hander runs.  Sees outstanding fences on inst 0; skips
> powergating inst 0, skips disabling video profile. Schedules the
> worker thread for VCN_IDLE_TIMEOUT jiffies in the future.
>
> inst 0 IB completes and fence signals
>
> inst 1 IB completes and fence signals
>
> inst 1 work hander runs.  Sees no outstanding fences on inst 1.
> powergates inst 1.  Check if there are any outstanding fences on other
> instances.  Sees the no fences from inst 0 so disables the video
> profile.
>
> now there are jobs coming from inst0, so inst 0 idle handler won't run.
>
> inst 0 work hander runs.  Sees no outstanding fences on inst 0.
> powergates inst 0.  Check if there are any outstanding fences on other
> instances.  Sees the no fences from inst 1, sees that video profile is
> already disabled.
>
> inst 0 work handler runs? could or could not - right? depends on if there=
 are more jobs for inst0 and also
> if  VCN_IDLE_TIMEOUT jiffies has passed for inst0. There is possibly a po=
int in the sequence that inst0
> stops submit jobs but its idle handler has not run yet. Should we wait un=
til all instances have finished their idle handlers?

The work handler will run unless it is cancelled in begin_use(), but
in that case, it will get scheduled again in end_use().  If it runs,
but there is still outstanding work (fences), then it will get
scheduled to run again in the work handler.  All we are about from the
power and video profile perspective is whether or not there are still
outstanding fences.  Once all fences are completed on all instances,
we can disable the video profile regardless of whether then the idle
handlers have run or not because the hw is already idle.

> if not then we will run into a power OFF(by inst1) -> ON(by inst0) for th=
e active instance(inst0, expected ON). (active - I mean
> those have not timed out in VCN_IDLE_TIMEOUT jiffies and still can submit=
 jobs in any time.)
> if this could happen then we powered off too early. (I did not say we can=
not do it but it is not expected)
>

VCN_IDLE_TIMEOUT is not a timeout.  We could call it something else.
VCN_IDLE_CHECK_PERIOD is a better description.  It just runs in the
future to check if all of the fences are signalled.  If they are not
signalled, we schedule the worker to run again further in the future.
If you reduce the time, it will check more often, you can potentially
save more power, but you add more CPU overhead because the handler may
run more often.

Alex

> You can insert additional job submissions anywhere you want in the timeli=
ne.
>
> Alex
>
>
