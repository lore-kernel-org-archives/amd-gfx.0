Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA947D30CC2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 21:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE8A10E545;
	Tue, 13 Jan 2026 21:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHvZgxWI";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D6F10E545
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:18:02 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-122008d4dc0so367680c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768339081; cv=none;
 d=google.com; s=arc-20240605;
 b=hC7W37syOlbdpFxUEQgN7FtAkuuTAR/x//794f/2auQ+hD5LYRuYQlWH60+TS+seZO
 MauhND8KIj5ESa84DPOfr9x+3QX01cWlTRD66n5npsFm27iUEqeEDkxtel0UItdNDh/0
 oLSX5LYvpU01Lqb1fJK8gOMQTmpzMkISLUAvxmj0CGzWl1qYLb7r2rvgx7d6xUKgjr96
 IOKI896ngg3SXrZNLZCoOB9+807XBXEvDF8hC14X+7CpOMxO/BkGtWJdeVnrWkJv7o62
 P23zgrLkzNyrfsfhRdtbXnKFFQqATp2nJ7N0aPH2S3XmeFR3Pld6PGe0UvP0kJgKdgs7
 pj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rEkOeypElh+EQg+ZtZlUpHCQY3UZz1s2aYnzxLqX4Cg=;
 fh=5A1m1VHLavlJN1mnGU9kk24c07k6uiVT41ucp15ImOg=;
 b=FxdbKajx5DLXqPekuiVbIM4MXmmdlK8jNol30SMD+J0dEfvvDz9PbPsKa7ztmWH1R6
 25rBvg8t8/4WpZBcL5kghAvpsLeCD6LtWI0wrlFtKw+M9x8i7vl7Mbs1XkHqmS1poMyJ
 G1uzxLEoKT6rvTsT8pA4lOhxjVU7L5Cerw6fuE4tEm6Ze+8Vz2W7HHzzCT9XmKToU4Lu
 vwIOBsHQ8PRRR3Tmfrmag4JdueM2hUofDDR05SFWqJeSaPFU95G2q9YvEZkfXpC67Sz0
 FtfBVcGDnTf0URTsBC+EuQhfYbhC0nitK3VggVAB7FQSbyYkAhY6DjE+hyesrsO4g3qh
 uPmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768339081; x=1768943881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEkOeypElh+EQg+ZtZlUpHCQY3UZz1s2aYnzxLqX4Cg=;
 b=PHvZgxWIAlJVmXEwGobFxI2fraTsfcV3Xje0154ngI7FaAK1QBLuy8E75yDfREMWxO
 A6ROItC28WRDRx0plX6tXCa0qJtEcw0pr7gecwp4/GM3HzkiXdd63vrmroM2kvc6/zvl
 6jj3V2C8029NVXy33anx42lp3VEHq3asbuBYDTkj34BFUYWvsmq9bY1MRXncAgbiMIaz
 JCGgvG8v8KUnD2b/v2Qm7dCgP1t/d9MfBwvpd09RJUmbE1fti9r2cxbSq1l1b+40UJDs
 zzrOuoW3Q2C2Lrci57J6VZQcdH+fGftWPDKLw/do8XRUWiG9U1vnSzoyL90b2KK9oYxF
 Fzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768339081; x=1768943881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rEkOeypElh+EQg+ZtZlUpHCQY3UZz1s2aYnzxLqX4Cg=;
 b=JlqvU3PSLkdcjTrpf/Mz1X/VmJq7VL4J55N393uUcWI/q3BmY6iOKvzaZBYLXoFguX
 lU3YXjDzYDx42TX8M6VQ2m3JhJsk3w5RtddNV1sLd0HCES+pp3hj2f7DZjlbGqgJQxfu
 X7RZGtlH9LoFHYeJ65AbhfXbdzJLqSHs4tneVHMBxGJU3IhWroEjkbR0RE71T5NsfPky
 uiTODxHbMQn6i5bRprmkh9+R+SHwsIMS6vkUhqTfJKYhUKvo3E3vXYz+PcvF2orD8w1U
 ocAWzvDEQCBa7LLWKdXStbHvNySk+GIu1+2HPdSF5oseGq9P1Dx8SVjg0Y6TCOWNqSVR
 S3Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFi1yfq77O4QX77KPDNAkrXvhNyYdeU357OAOLeMlXo89pTaC0UksAEzRcGbn42ElN4Mxo18wH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRF575KOWO2g4lyJilBia0xjhmVgohaZFXxzPX4X6obj4tiAQY
 mpHP8govRnC//b4HJUA4DCQQnRPHIO5pgR0049m4mMBQCvyXI8WyNNTSxtErveCQs5BplU9Gplk
 CVnXalxvcpZSBnUruhELM3WRm4ZpsOlONCg==
X-Gm-Gg: AY/fxX6kc+Us1U+2zGCu11CUTKo1VT0laoprhOZ+JYT3yirR4zJpbNfiLoTi4LcySaw
 DbGuWKXYGYWQjofqr/ptjRS1dhOxb8Lnh36qrvmkHFLPdUGdkcYjli6N6JQ13kaI3oNop6KONk5
 92VUYbIi/PqG+0K2BZec5meVyjAfMWg29/5YscQVkkQZ0BVsPWBK+G0MLKxezMouNUUQUHGZPo9
 7KiwczPBHrZvRAgxBnfbS8euoyJ1Zmb905MaxoHzM2vVzrEFJv/LzME9ZuW5q08clS77EGabqES
 Y9VmkYo=
X-Received: by 2002:a05:7022:6613:b0:11a:344f:7a74 with SMTP id
 a92af1059eb24-12336a89b27mr204340c88.3.1768339081016; Tue, 13 Jan 2026
 13:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
In-Reply-To: <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 16:17:49 -0500
X-Gm-Features: AZwV_QgjTrpv2Qfc32cmKZNJ7Tams4tLUU9FP_n6hcbUmmSVSvqbORhad3E_6SU
Message-ID: <CADnq5_M8DE5N=c3zZbFHtL6GPq_zJCk9P1VN+gMTCPR5dy7KSw@mail.gmail.com>
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

What was your comment on patch 4?  I don't see that reply on the mailing li=
st.

Alex

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
