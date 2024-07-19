Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D415C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 22:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711C210E11D;
	Fri, 19 Jul 2024 22:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lluYO7Ge";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3071C10E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 22:53:02 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-70b1808dee9so990387b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721429582; x=1722034382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyglj9uh4IM+c0yXnPW/T7KLuNUXNSLZ2WL5L59Ws/Y=;
 b=lluYO7GeB39S4+pFLJ1bAwFS7/hbAqOeJvv9SGzM0svWDuCDZIRzkeNhrcdHUzLQBT
 i3mLxG5/fz5535eFDPG2mVH/oIoob9i+dWfj6PPj0e8z1HJzIDy/8jNKWJixbcQSj6OC
 N4vmtyB8L2BGinBPcMKb5DU0BHjdcOkVjy8mYyurn86gEPaEB2N9v0tstnRDsVlgFGIi
 f2kzLwvxDosn/maF5sDJMZ3+dMc+m7Ixx/aCb0cWTY51+iQ6U7hO+M+kpEiVj+OyWceZ
 rF7BmFua8LvjIJZ963XyYJS2/Q3i4OGssqRALC6wuzUwlHcn05oMLE/0z0a9o7B4jl1X
 okeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721429582; x=1722034382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyglj9uh4IM+c0yXnPW/T7KLuNUXNSLZ2WL5L59Ws/Y=;
 b=RmZFq8SD/gWxqabA+E8zvJhB+ESIZzoxP0RMta8YxKxWYW2t+WL8s+7i8F+84iyIbf
 sLWA+0B1T2oWMC0N4EYXq3fehquxckYELYY0yJfjdHpFAbZbfJv9ifJpjfE2QIgtVpnE
 MC9H5sOixw/NZUcaIcmO2E5wOes1Kmwo8AbIBj3I9nH8x8Dh9lByj1lpnmXnPDgnGlj9
 WLCDdmrpPtY6ShUXPtqV494MhvXBgOETbULTuU2fJd17zfJg/EYu6Lwk8Y1gzzg/xN8m
 LKh216fn7AcOsItSyBtfg2gkBS5JUaUMf5bQLaHM9J+Bw5+tDwU7HbOg+HR8NKIeYTFE
 4p8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxZ5i6Oq+ZF8Zxqqt1ni4vAgX8aqGa2wQZBpQStvIqKfUvbKHqtljRa8VXlOg/eUITSfQJoJTgGuxmd0NBJmTtUs1dsux7Pg0hBeRbZQ==
X-Gm-Message-State: AOJu0YzgpvzeaTZ+t6KOt2bOX3Uqm+u2qNPx94gqG+5okWMcAOvmlzjP
 6Un8++LHa3nq5X7VWmukju+Dz9KtGBLEYFr8CRbpeUsJN8tB37+muXUMqsIoX2lKtFjKCrShiw9
 uWZLZ6p42NZ1VnRT65b9MBGAgBO0VcHXz
X-Google-Smtp-Source: AGHT+IHIa8Qo/r6FXekr2aZLzPV9/iUjyA2CYDq9ELCN0a+SuvOUsO60Fkhg+GrOOJd3MTR6vtjzGhyCgXwK7mN0fp4=
X-Received: by 2002:a05:6a20:734e:b0:1be:c86e:7a4d with SMTP id
 adf61e73a8af0-1c3fdddafa4mr12808055637.53.1721429581503; Fri, 19 Jul 2024
 15:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
 <95387eeb-d81e-4a09-8475-820317605f49@gmx.de>
 <CADnq5_NaXHNz_AO9YJbe5X7qKP8h7CQqUVd5BwxDh4rbg2nBkw@mail.gmail.com>
In-Reply-To: <CADnq5_NaXHNz_AO9YJbe5X7qKP8h7CQqUVd5BwxDh4rbg2nBkw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jul 2024 18:52:49 -0400
Message-ID: <CADnq5_N5mYBrdSnz96EyC-qqJV7gNCg-hLdDAz-nN4b18uZ2Bg@mail.gmail.com>
Subject: Re: [PATCH 00/34] GC per queue reset
To: Friedrich Vock <friedrich.vock@gmx.de>
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

On Fri, Jul 19, 2024 at 9:39=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Jul 18, 2024 at 1:00=E2=80=AFPM Friedrich Vock <friedrich.vock@gm=
x.de> wrote:
> >
> > Hi,
> >
> > On 18.07.24 16:06, Alex Deucher wrote:
> > > This adds preliminary support for GC per queue reset.  In this
> > > case, only the jobs currently in the queue are lost.  If this
> > > fails, we fall back to a full adapter reset.
> >
> > First of all, thank you so much for working on this! It's great to
> > finally see progress in making GPU resets better.
> >
> > I've just taken this patchset (together with your other
> > patchsets[1][2][3]) for a quick spin on my
> > Navi21 with the GPU reset tests[4] I had written a while ago - the
> > current patchset sadly seems to have some regressions WRT recovery ther=
e.
> >
> > I ran the tests under my Plasma Wayland session once - this triggered a
> > list double-add in drm_sched_stop (calltrace follows):
>
> I think this should fix the double add:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 7107c4d3a3b6..555d3b671bdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -88,6 +88,8 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>                                 drm_sched_start(&ring->sched, true);
>                         goto exit;
>                 }
> +               if (amdgpu_ring_sched_ready(ring))
> +                       drm_sched_start(&ring->sched, true);
>         }
>
>         if (amdgpu_device_should_recover_gpu(ring->adev)) {
>
>

FWIW, I think I've fixed a lot of this up.  there are a lot of patches
to resend, for now so just grab the latest from:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next-q=
ueue-reset
This updated patch is the important one:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/ddad62a355b7650f05862c8=
8c2f7979e938071f2

Alex

> >
> > ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 =
arch/x86/kernel/dumpstack.c:447)
> > ? do_trap (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154)
> > ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> > ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/trap=
s.c:175)
> > ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> > ? exc_invalid_op (arch/x86/kernel/traps.c:266)
> > ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> > ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
> > ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> > ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> > drm_sched_stop (./include/linux/list.h:151 ./include/linux/list.h:169 d=
rivers/gpu/drm/scheduler/sched_main.c:617)
> > amdgpu_device_gpu_recover (drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5=
808)
> > amdgpu_job_timedout (drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:103)
> > drm_sched_job_timedout (drivers/gpu/drm/scheduler/sched_main.c:569)
> > process_one_work (kernel/workqueue.c:2633)
> > worker_thread (kernel/workqueue.c:2700 (discriminator 2) kernel/workque=
ue.c:2787 (discriminator 2))
> > ? __pfx_worker_thread (kernel/workqueue.c:2733)
> > kthread (kernel/kthread.c:388)
> > ? __pfx_kthread (kernel/kthread.c:341)
> > ret_from_fork (arch/x86/kernel/process.c:147)
> > ? __pfx_kthread (kernel/kthread.c:341)
> > ret_from_fork_asm (arch/x86/entry/entry_64.S:251)
> >
> > When running the tests without a desktop environment active, the
> > double-add disappeared, but the GPU reset still didn't go well - the TT=
Y
> > remained frozen and the kernel log contained a few messages like:
> >
> > [drm] *ERROR* [CRTC:90:crtc-0] flip_done timed out
>
> I don't think the display hardware is hung, I think it's a fence
> signalling issue after the reset.  We are investigating some
> limitations we are seeing in the handling of fences.
>
> >
> > which I guess means at least the display subsystem is hung.
> >
> > Hope this info is enough to repro/investigate.
>
> Thanks for testing!
>
> Alex
>
> >
> > Thanks,
> > Friedrich
> >
> > [1] https://lore.kernel.org/amd-gfx/20240717203740.14059-1-alexander.de=
ucher@amd.com/T/#t
> > [2] https://lore.kernel.org/amd-gfx/20240717203847.14600-1-alexander.de=
ucher@amd.com/T/#t
> > [3] https://lore.kernel.org/amd-gfx/230ee72e-4f7f-4894-a789-2e1e5788344=
f@amd.com/T/#t
> > [4] https://gitlab.steamos.cloud/holo/HangTestSuite
> >
> >
> > >
> > > Alex Deucher (19):
> > >    drm/amdgpu/mes: add API for legacy queue reset
> > >    drm/amdgpu/mes11: add API for legacy queue reset
> > >    drm/amdgpu/mes12: add API for legacy queue reset
> > >    drm/amdgpu/mes: add API for user queue reset
> > >    drm/amdgpu/mes11: add API for user queue reset
> > >    drm/amdgpu/mes12: add API for user queue reset
> > >    drm/amdgpu: add new ring reset callback
> > >    drm/amdgpu: add per ring reset support (v2)
> > >    drm/amdgpu/gfx11: add ring reset callbacks
> > >    drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
> > >    drm/amdgpu/gfx10: add ring reset callbacks
> > >    drm/amdgpu/gfx10: rework reset sequence
> > >    drm/amdgpu/gfx9: add ring reset callback
> > >    drm/amdgpu/gfx9.4.3: add ring reset callback
> > >    drm/amdgpu/gfx12: add ring reset callbacks
> > >    drm/amdgpu/gfx12: fallback to driver reset compute queue directly
> > >    drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
> > >    drm/amdgpu/gfx11: add a mutex for the gfx semaphore
> > >    drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
> > >
> > > Jiadong Zhu (13):
> > >    drm/amdgpu/gfx11: wait for reset done before remap
> > >    drm/amdgpu/gfx10: remap queue after reset successfully
> > >    drm/amdgpu/gfx10: wait for reset done before remap
> > >    drm/amdgpu/gfx9: remap queue after reset successfully
> > >    drm/amdgpu/gfx9: wait for reset done before remap
> > >    drm/amdgpu/gfx9.4.3: remap queue after reset successfully
> > >    drm/amdgpu/gfx_9.4.3: wait for reset done before remap
> > >    drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queu=
e
> > >    drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
> > >    drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
> > >    drm/amdgpu/mes: modify mes api for mmio queue reset
> > >    drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
> > >    drm/amdgpu/mes11: implement mmio queue reset for gfx11
> > >
> > > Prike Liang (2):
> > >    drm/amdgpu: increase the reset counter for the queue reset
> > >    drm/amdgpu/gfx11: fallback to driver reset compute queue directly =
(v2)
> > >
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  18 +++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 158 ++++++++++++++++++=
++-
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 117 +++++++++++++--
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  95 ++++++++++++-
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 126 +++++++++++++++-
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 125 +++++++++++++++-
> > >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 132 +++++++++++++++++
> > >   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++++
> > >   14 files changed, 930 insertions(+), 32 deletions(-)
> > >
> >
> >
> >
