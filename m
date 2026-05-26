Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30FFCD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 22:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195FF10E280;
	Tue, 26 May 2026 22:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cg18e8/7";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C0C10E280
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 22:31:49 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f13ae64db1so799772eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 15:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779834709; cv=none;
 d=google.com; s=arc-20240605;
 b=OGkJyDIgvLnOFypx5PQI61mKg1FRRUmco2P9n8MyfgSUGWkyhC3qsO0tNh26FFalLH
 vt5ZJQr2i2CHOx5CoJ2ueT9BSt1UnKkEXHUvwDGosQja9SCNteyJtNQZzwPiu5OfrHpb
 Mc94fjM7L6CKMrozRIgH6SLSGBvD6ZHwMeQAOaNZDTArpEbU9kB9CdiOCHHXvDaIhEFG
 DCAmCotKF5Yt5cx3SE8bkP2z5WPivHtd0dU3e8RElSl5vFvxrvexU59DQsQjeiSVgJxY
 F6ySeCcpDGCD0Knqo+q5bUc9iQgzITXoE7QgnS02LtE7nvZ4REoqRTySknFP4dHO8pSN
 MJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=plRHtvIJdHpBI+08fH5YNhsjFabw9A+q4SEEFD9Ivps=;
 fh=qEf/ApDnHeZ/k10TNbkyBSggaqqefkm8rwnXPgBeilg=;
 b=hxV62thwVaI5LcJQq7unQgcp/NRAWll+VXVN3r+bN0p3n1vQNHg6rHINIGnEeqcRWJ
 Zc8GoC2R9Vlpcdm6TcAF9aSg1WnMq4jleolgVvRfXtVVOP3qm7we/D01D2eKgpACdRjE
 EQe7aRiAyt237LVCA3GZw/Qxgckj4DmGlfPizw/341+ksFYZRFg6BG1JO9ZyUHIyHc5e
 xaIp6QO0ofuTDiofUE1Kz4n1UIRISuU8wSp0o8QOHAGaD+cwzAZKa/x+KuN6LEzTYLG2
 4NwPQe3/XyUHxOdnbVluKM/SbHnohl8wZHICf1yBv/sVMdWHjI2VGp/vSMn2EQ638vU5
 bmkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779834709; x=1780439509; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plRHtvIJdHpBI+08fH5YNhsjFabw9A+q4SEEFD9Ivps=;
 b=Cg18e8/75akgWnd79bnXaYh4aI9n8SGMqpUDHvSCKbz16T19YlbmaU1iVPWR5Q5kDL
 jXSyb9+7tyTZAWA5Nd6yZQkokvNZZpDR7fwycu9Mpac3uc6UyBHGzKGw703wmKFY6kOB
 p9WKNy2LI4AhapkSI2wIRPs/8bq2wCaOQ0PAyrAZ84zuQmnjD5eygg6LiNV+OAEfM89z
 6V77VTYBYmdbV/rEA3alOgGLvyzQcUid0tClLrkxWgWs5ZaX3XwsjbHaEy/+VU7rv5/j
 JeyrOknJyQXq9SPP/NaZ4XYEAD+FZo19Lo6n+4vd6lT02p/yjLjrqi8DTIBNcBc5EuKl
 B0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779834709; x=1780439509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plRHtvIJdHpBI+08fH5YNhsjFabw9A+q4SEEFD9Ivps=;
 b=N/T8jmV//wp2hWTMbzVqB3hZeAb2R8/nx6l3cwjjeqG4aM5K1ogX33hxT01hQwh313
 DMwgyPr5X2S0fuOZE6RLZX0OwzRG+EbCtzNSFxDZluQqxRNGxLeEXb1q+QB+ihAm25On
 Z74uLpbiKBaU8288ttidWFZuUWYkuMZMcwRLW2f40sbibDe9ipglxAB6P53h6OKBru+Z
 z60B/hXR4RYRTXa3tHJtnJt89nr0hDDIjz6yq+45IAMcmzK/jjztvoXqNqmur0rTHaw1
 V/2KggSw0UCPK6nGFgwK39Ni4TF/uExch1m3lqHjrCW5XGOfcxZfhqS36IGZkW2x1FAH
 yhPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wZ+4yTmSrATbNLsJdNt+kvEfnntOQ+Ou7p+4CmMlfeUlqeRIP1XjUkUhkHZ/s0ov7HI8E63I4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywowk2K8RLRDai8sPdVbER8xg7nskerPNyFdLZ3rbI+m2/0fNqh
 dnviHhBxy0Et/IYCQC52NYGlWfm6jfjYzNjJ5WUelFI2fKMsO+Iu28mOYWt6um0opnWLG0JMfZC
 iQngE15wlivG9PXTzYRAaH9UC0Ecn6xI=
X-Gm-Gg: Acq92OHZkYfNWFfJYUsfB305HDHbm2dyz/CSRo174DSHuMYUHWZZ+D91e6rgLawnwOR
 eDqogTw5EN399lIy0Fu7B5B13ehjPTVDEOqg9FefMD7LmrbK6s6UG3y7Ropq+EUC573Bj8ZkD6P
 72fW/uXysxA8cntMaXh7/nOJcD8MmlJ2h3xc8j9yh96CPljO1W/UtjzJmxlVe91piWZibRKyfcT
 +V+hFvDy49Md+zouDMfKT4Wq9oNsQGkyVb3lBRmC2i5HbRU4dyQ63Ed+ITEcBhGaM+MIQk12xpZ
 JTc7KmuLZu0+tBuw5AWiNTJPUqYatp3CtuiO5FBP/C9OaIFMtcPxGFn6kvOwBWEdndI5Ug==
X-Received: by 2002:a05:7022:f30d:b0:130:a719:a680 with SMTP id
 a92af1059eb24-1365fe823c7mr1529991c88.7.1779834708788; Tue, 26 May 2026
 15:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <ahYAIzazFpb0YsDP@tardis.local>
In-Reply-To: <ahYAIzazFpb0YsDP@tardis.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 18:31:37 -0400
X-Gm-Features: AVHnY4LJ9iZuzmHdaT4SZJqft-QUxQVtxBh86pXlbO8zQwdnLg7GAM8TRSQlhCM
Message-ID: <CADnq5_PxpNQpfaey4OmqfFXcfG5ttMeauQ43eHEmnKYVnXWAfQ@mail.gmail.com>
Subject: Re: [PATCH 00/42] Enable pipe reset for compute
To: Boqun Feng <boqun@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sunil.khatri@amd.com, Amber.Lin@amd.com, 
 Jesse.Zhang@amd.com, Shaoyun.Liu@amd.com
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

On Tue, May 26, 2026 at 4:29=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> Hi Alex,
>
> On Thu, May 21, 2026 at 08:20:06PM -0400, Alex Deucher wrote:
> > There are certain corner cases where a queue reset is not
> > able to recover a hung queue.  A pipe reset can recover
> > some of those cases, however, when the pipe is reset
> > all queues on that pipe are reset.  This requires
> > coordination across all components using compute queues.
> > There is quite a bit of prep work in this series, some
> > of which I sent out previously. Another prerequisite
> > for this was reworking the userq reset path.  It should
> > be more straight-forward now.  The final patch also
> > needs to be updated once the new MES firmware is relased so
> > we can check the proper firmware versions. Using older
> > MES firmware may fail and end up in an adapter reset in some
> > cases where the pipe reset would have worked so it should
> > be comparable to the current behavior.
> >
>
> Do you have a branch somewhere I can test with? Or what's the base
> commit of this patchset? Thanks!

I've pushed it here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/pipe_reset?ref_type=3D=
heads

Alex

>
> Regards,
> Boqun
>
> > Alex Deucher (34):
> >   drm/amdkfd: always resume_all after suspend_all
> >   drm/amdgpu: don't reemit if there is nothing to reemit
> >   drm/amdgpu: track guilty fence for queue reset
> >   drm/amdgpu/fence: add helper to extract the guilty fence
> >   drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL
> >     fence
> >   drm/amdgpu/vcn: handle pipe reset more gracefully
> >   drm/amdgpu/sdma: handle pipe reset more gracefully
> >   drm/amdgpu/mes12: use proper grbm_select function
> >   drm/amdgpu/gfx11: only need to remap KCQs when reset via MMIO
> >   drm/amdgpu/gfx12: only need to remap KCQs when reset via MMIO
> >   drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
> >   drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
> >   drm/amdgpu/mes: add userq reset helper
> >   drm/amdgpu/mes: add a MMIO queue reset helper
> >   drm/amdgpu/userq: split the queue reset from adapter reset
> >   drm/amdgpu/userq: add per queue reset callback
> >   drm/amdgpu/userq: add mes userq reset callback
> >   drm/amdgpu/userq: switch to per queue reset
> >   drm/amdgpu/userq: drop detect_and_reset callback
> >   drm/amdkfd: rework MES queue reset sequence
> >   drm/amdgpu/gfx: add a helper for MQD restore
> >   drm/amdgpu/gfx11: use the new MQD helper for queue reset
> >   drm/amdgpu/gfx12: use the new MQD helper for queue reset
> >   drm/amdgpu/gfx11: unmap the queue via MES on reset for MMIO path
> >   drm/amdgpu/gfx12: unmap the queue via MES on reset for MMIO path
> >   drm/amdgpu: store whether to use MMIO or MES for reset
> >   drm/amdgpu: Use a common KGQ and KCQ reset helper for gfx11/12
> >   drm/amdkfd: split out mes queue reset sequence into standalone
> >     function
> >   drm/amdkfd: plumb a helper to reset a KFD user queue
> >   drm/amdgpu/userq: add MES userq reset helper
> >   drm/amdgpu/gfx: add a common helper to handle MES compute resets
> >   drm/amdgpu: use a single entry point for mes compute reset
> >   drm/amdgpu/mes11: enable compute MMIO pipe reset
> >   drm/amdgpu/mes12: enable compute MMIO pipe reset
> >
> > Amber Lin (3):
> >   drm/amdgpu: Allocate enough space for hpd info on gfx11
> >   drm/amdkfd: Update queue reset support on KFD topology
> >   drm/amdgpu: Expand MES queue/pipe reset support
> >
> > Jesse Zhang (4):
> >   drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy queues on
> >     unified MES
> >   drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy queues on
> >     unified MES
> >   drm/amdgpu/gfx11: Refactor compute pipe reset and add HQD cleanup
> >   drm/amdgpu/gfx12: Refactor compute pipe reset and add HQD cleanup
> >
> > Shaoyun Liu (1):
> >   drm/amd/amdgpu/include : update mes api header v11/v12
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  16 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  54 +++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 193 +++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  16 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  67 ++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  14 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   3 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  19 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  84 +++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  64 +++--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 264 +-----------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 216 +-------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   2 +
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 111 ++++----
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.h    |   9 +
> >  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 250 ++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 263 +++++++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  22 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  24 ++
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 ++++-----
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   3 +-
> >  drivers/gpu/drm/amd/include/mes_v11_api_def.h |   5 +-
> >  drivers/gpu/drm/amd/include/mes_v12_api_def.h |   5 +-
> >  26 files changed, 1150 insertions(+), 708 deletions(-)
> >
> > --
> > 2.54.0
> >
