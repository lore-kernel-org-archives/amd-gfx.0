Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84739D2D10A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 14:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2979510E4E2;
	Tue, 13 Jan 2026 14:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkUDJLxf";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0041510E4E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 14:10:58 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-121a15dacd1so584615c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 06:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768313458; cv=none;
 d=google.com; s=arc-20240605;
 b=hEk+aeJMGoP9P1A++Bfohi/4xyB52qp4rWwIMLv05dcl+72TGzs/h4sGLvsg10bowC
 SWx/NbStcil2cZZpMTwjSRyPxQUflDnUgUm1Ly1ulTLZoPxQhbxEUjYuqPLD8MT1NDYe
 yDrqHvUfF9QhbXmeIOpVN3R5CYAmgb6qhWGCD1v0Ocfa7LckxQAFxHD//fWlJaHQOIG4
 6lxEUjfqy7aDVGLvzLVhqewh/hcLQqrzWbBoYd77y337f91TsI7dZC//dc2uI/bc1w4E
 jjcmdAGFvcPmZDzX6oIIw3FLUtIgwKawNK7iuYBHtS0nBQ6Ws+xwhzFNfcQmb69GpmrJ
 dPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hg9L97aSLRGgmKZdwWz7vMiJPoVaskdKbDCWRwSnc58=;
 fh=2kaI/x6wPug+NecnSj/Ut1VNNT7hxTK8j5A2z2BrD84=;
 b=UOsOF3Gfy/OXoDu6iou7QpEcevbAgWg7c8S3xX7zVMwK5B7T8BF45owoKSoscz4Sb/
 1QTmA9tXnPmNdpFlHF7+gn6Uk4/XtsrgOrgesvpM8QtUeApJlDkTnSRN1maTKVJQSP6K
 UkF8YNlxCb1/sJG/n7V3NeAgGB+ZQNIGABjKqIjUKQpEEWEH1Afok5/8B474FphNjS/l
 56vQDAp9suxwCAIODTvmn5YqYfhhEDQbSkTunbKgEInwGQRSiArbcGf/GLNiI+AfbVFg
 mf8i/dpNKmgpIsucPl6TIBXN6qU+xrEboJ0m28K/bZ3U3dHU9btZZN4JKux8PgOis6GJ
 O7hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768313458; x=1768918258; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hg9L97aSLRGgmKZdwWz7vMiJPoVaskdKbDCWRwSnc58=;
 b=QkUDJLxf5XkYrG2MZvp+1dNMISQU9UeAweMa6Aq8s2qemcWQrMx3ACY0aJ70bawrCk
 H028BnwAoJaZfZxqxjdCZZGGdgTj44oQPavypL0kc0EG4JrHKZJud9tkySAdazqbDdTs
 6V+WneCQ/IGPcy1omGMN6nwUi906ys/3SILffhzErIhgmP2OM53C7svS0LeHZVS/Z2ri
 Vl2oOh4kJc0PQ1iBVVFJfaGMtgA1bXX7dkcqqmoX2lJWPVwoELSxZaDumRipOtEsqBz+
 /r8XFLNuS7/d58aaNO29MshETu+RrjSzDTWbgib5/EY7BdS73XsowcW8m9hYBzr3J/d8
 pFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768313458; x=1768918258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hg9L97aSLRGgmKZdwWz7vMiJPoVaskdKbDCWRwSnc58=;
 b=Jn4kWBZWyk/GI6KGGuFWdq6xAcs0s9YTLUczmuq9yAqK/vpo7zg/VODy+B9FOkNUjY
 oN3hDJBqkDO95ZIIDo6Qp5gU267KAk0qvHiMmtSRgPYdwHF9z5GcxyzhTMnaYecBh92P
 6YzCgUClWeznn/lRR7Z1MN4woCwG2nOvbWT8KSRlqtWMtcbXcKJzWm75YY9Iia6lyFVA
 iJ26kuuW4PWody9sQ3Md2f+2y5qQ80KSkkoS4IVXDIxxgKEYfAKjoAfqPhww+p6as7z6
 BnjR4vqB2oofsqBo2JFhGg4hpN9ngBFcAx1vbXDT99NFd1ykFtUXdM2BIMzXUD/oc3PL
 C9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXka0ZXMapkFtTQqFPJWljYl5gXU64zZABxV9HZ7RMFnTkoQABrjATvCb+Ml6/Qmzr133hf6zV3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDyjxQkbJxSdQHuZy6KB8S4mxq5JJEAFaVGpIz246GE9aBAFNF
 l1APJOD6RNdrZ4j8F0xB5ifweO/ZShalmBWhw/Xnkl5KR207paIDTYmwskNoHC5TBH6M7V3DEeS
 92ghq4AIRsd76DHixTAzdzuP/EzQ+HXAslA==
X-Gm-Gg: AY/fxX6NVUY7ZTBc4+cUoBnilydIPMD+3RjLG+uPBiS7bgw+69v4Za/M/J3Of/6NwAP
 px3kRMrrwQY5kED1INVrKRKsWk2l8DaoBD2Zyujr3OJpiHEjIrHFMNNNm8T+6AmZlUszlxqUs4t
 aP7T48p/rgxOfWuUNwYU84AkYjNvP1YmzuqNXS8lIQy/Kgvd8cWTKaTi7lg6+j5243UoJvfkaXa
 BmwAQsQK91pgDzKA3eMVKN7LJAX5lJ0NUFrs0G5nu8CIuc06Wq0xhCozE0+qdpNrbhHSlqG
X-Google-Smtp-Source: AGHT+IFtS7zEo+kWtG7bRjZSkqMyxWII3pYWZQPM6zCGROc/ixAvABnHE1/za0j0LBSK9eQx5iXC97TpdePyohzcbe8=
X-Received: by 2002:a05:7022:238b:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-121f8b45a84mr11985327c88.4.1768313457304; Tue, 13 Jan 2026
 06:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
In-Reply-To: <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 09:10:45 -0500
X-Gm-Features: AZwV_QiA3S0erv8xw2WORPpIQhsG-iM5RfFURnuJCf28A7xdp65z2CoKUcQhlGQ
Message-ID: <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
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

On Tue, Jan 13, 2026 at 8:57=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Patches #1-#3: Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>
>
> Comment on patch #4 which also affects patches #5-#26.
>
> Comment on patch #27 and #28. When #28 comes before #27 then that would p=
otentially solve the issue with #27.
>
> Patches #31: Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Patches #32-#40 that looks extremely questionable to me. I've intentional=
ly removed that state from the job because it isn't job dependent and somet=
imes has inter-job meaning.
>
> Patch #41: Absolutely clear NAK! We have exercised that nonsense to the m=
ax and I'm clearly against doing that over and over again. Saving the ring =
content clearly seems to be the saver approach.
>

I disagree.  If the ring emit functions are purely just emitting
packets to the ring, it's a much cleaner approach than trying to save
and restore packet sequences repeatedly.  If the relevant state is
stored in the job, you can re-emit it and get the same ring state each
time.  If you end up with multiple queue resets in a row, it gets
really complex to try and save and restore opaque ring contents.  By
the time you fix up the state tracking to handle that, you end up
pretty close to this solution.

Alex

> Regards,
> Christian.
>
> On 1/8/26 15:48, Alex Deucher wrote:
> > This set contains a number of bug fixes and cleanups for
> > IB handling that I worked on over the holidays.
> >
> > Patches 1-2:
> > Simple bug fixes.
> >
> > Patches 3-26:
> > Removes the direct submit path for IBs and requires
> > that all IB submissions use a job structure.  This
> > greatly simplifies the IB submission code.
> >
> > Patches 27-42:
> > Split IB state setup and ring emission.  This keeps all
> > of the IB state in the job.  This greatly simplifies
> > re-emission of non-timed-out jobs after a ring reset and
> > allows for re-emission multiple times if multiple resets
> > happen in a row.  It also properly handles the dma fence
> > error handling for timedout jobs with adapter resets.
> >
> > Alex Deucher (42):
> >   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
> >   drm/amdgpu: fix error handling in ib_schedule()
> >   drm/amdgpu: add new job ids
> >   drm/amdgpu/vpe: switch to using job for IBs
> >   drm/amdgpu/gfx6: switch to using job for IBs
> >   drm/amdgpu/gfx7: switch to using job for IBs
> >   drm/amdgpu/gfx8: switch to using job for IBs
> >   drm/amdgpu/gfx9: switch to using job for IBs
> >   drm/amdgpu/gfx9.4.2: switch to using job for IBs
> >   drm/amdgpu/gfx9.4.3: switch to using job for IBs
> >   drm/amdgpu/gfx10: switch to using job for IBs
> >   drm/amdgpu/gfx11: switch to using job for IBs
> >   drm/amdgpu/gfx12: switch to using job for IBs
> >   drm/amdgpu/gfx12.1: switch to using job for IBs
> >   drm/amdgpu/si_dma: switch to using job for IBs
> >   drm/amdgpu/cik_sdma: switch to using job for IBs
> >   drm/amdgpu/sdma2.4: switch to using job for IBs
> >   drm/amdgpu/sdma3: switch to using job for IBs
> >   drm/amdgpu/sdma4: switch to using job for IBs
> >   drm/amdgpu/sdma4.4.2: switch to using job for IBs
> >   drm/amdgpu/sdma5: switch to using job for IBs
> >   drm/amdgpu/sdma5.2: switch to using job for IBs
> >   drm/amdgpu/sdma6: switch to using job for IBs
> >   drm/amdgpu/sdma7: switch to using job for IBs
> >   drm/amdgpu/sdma7.1: switch to using job for IBs
> >   drm/amdgpu: require a job to schedule an IB
> >   drm/amdgpu: mark fences with errors before ring reset
> >   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
> >   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
> >   drm/amdgpu: drop drm_sched_increase_karma()
> >   drm/amdgpu: plumb timedout fence through to force completion
> >   drm/amdgpu: change function signature for emit_pipeline_sync()
> >   drm/amdgpu: drop extra parameter for vm_flush
> >   drm/amdgpu: move need_ctx_switch into amdgpu_job
> >   drm/amdgpu: store vm flush state in amdgpu_job
> >   drm/amdgpu: split fence init and emit logic
> >   drm/amdgpu: split vm flush and vm flush emit logic
> >   drm/amdgpu: split ib schedule and ib emit logic
> >   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
> >   drm/amdgpu: add an all_instance_rings_reset ring flag
> >   drm/amdgpu: rework reset reemit handling
> >   drm/amdgpu: simplify per queue reset code
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
> >  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
> >  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
> >  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
> >  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> >  54 files changed, 952 insertions(+), 966 deletions(-)
> >
>
