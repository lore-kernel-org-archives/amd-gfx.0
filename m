Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C89C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 13:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EFC10E13C;
	Fri, 19 Jul 2024 13:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6NyD0Q3";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7945310E13C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 13:39:51 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-70b2a0542c2so804615b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721396391; x=1722001191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UzEifXkv9r6+izuT6DB06QsHnYUg7HQlnJ+4adrCYY=;
 b=J6NyD0Q3QE4ys7iKzZeAyjjI8cCoaTNzuoF79Xun/PkRKXmEsxeyGppiWNYQl3BiMD
 IgBJSj17jllP2xIOPR3C2MiDej7Ru2yp4R979Wt4/YBEboBhg029qZa/yhMHQsMJqDKK
 KU+yKPmnldnR475nRty5r8/OrOZk77/ThXMH4y2HAhs3gev8QUrwHpflbcMWMsHE8FYh
 1cmR22NURdveYwENZQY7aA3eWe2nPFqsvmaoA6cFNjFIVvQqhv4wITWHyZ1pUEzM11+H
 oeWHAvpS4ShAkovXKf3iUF9lFP6fC8V5Bs+2rhbwpmKgdoPRiPzRFpX4P81sPY9gcUbq
 Zvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721396391; x=1722001191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UzEifXkv9r6+izuT6DB06QsHnYUg7HQlnJ+4adrCYY=;
 b=Oqo0H2qRbIVRWk1TfC/WOo80S+NGaiyskljCH60zxNhNXKdYZ7syOt/LpNHzAL9frc
 XWi1fH4EOFoV47kHUzfcjz8x4FHcTGBeim/ZsKDsS3QN10jz7HFDFQaOaARBgYOPzAlP
 SPkpyA3NKRXNXq+o4MLtecFrz5XY+8fk75mPZaGk2jRn9Qc+aj/3JNybEc3cgCRnlt+u
 tJ0pOERSrXRnqoqpAQgu61njtgC9SS/2pWVT95wNZTpoaBQp1P7zltgRG2eUMhV2IU94
 7PpheL4rIkJv4Z44ZdXmwE+4MnOE3BOHbuEVmRv3OrjQSG6Q/F2wY8Hp8Im3PVz60hAv
 HqIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFq97io81SFIAynD8DIitEIDQYSZ8dtSihyybUimxzZX/DsXlh2iBJbQv38Q3ylWeho8K6k39nxdENhbo1UvokBBXKwBJXfaFq2w3BnQ==
X-Gm-Message-State: AOJu0YzQsHPixP0svoTqsVKhNkTNtRyFXYP2xyvxGsq1QKulT8INhfZr
 jC/VM/onJI8qGp/4moFjW3aGTwzoDrImUf2GUcLCahBxqdpMR+X8Jm5kXP8sczeYLxtEQNLiuat
 nI6d5Gvr0p8Yc1SMmhu/jL5eNQRU=
X-Google-Smtp-Source: AGHT+IE0XQ/jtbsQB8vBLYBxCUEawn6X/LslWH4yp42JesKR8wBs5I97enQN5j5hauyW6qlvlve/osgCE5RNb7hPpNs=
X-Received: by 2002:a05:6a21:33a0:b0:1c0:e4d6:9bec with SMTP id
 adf61e73a8af0-1c4228557ebmr27461637.7.1721396390618; Fri, 19 Jul 2024
 06:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
 <95387eeb-d81e-4a09-8475-820317605f49@gmx.de>
In-Reply-To: <95387eeb-d81e-4a09-8475-820317605f49@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jul 2024 09:39:37 -0400
Message-ID: <CADnq5_NaXHNz_AO9YJbe5X7qKP8h7CQqUVd5BwxDh4rbg2nBkw@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 1:00=E2=80=AFPM Friedrich Vock <friedrich.vock@gmx.=
de> wrote:
>
> Hi,
>
> On 18.07.24 16:06, Alex Deucher wrote:
> > This adds preliminary support for GC per queue reset.  In this
> > case, only the jobs currently in the queue are lost.  If this
> > fails, we fall back to a full adapter reset.
>
> First of all, thank you so much for working on this! It's great to
> finally see progress in making GPU resets better.
>
> I've just taken this patchset (together with your other
> patchsets[1][2][3]) for a quick spin on my
> Navi21 with the GPU reset tests[4] I had written a while ago - the
> current patchset sadly seems to have some regressions WRT recovery there.
>
> I ran the tests under my Plasma Wayland session once - this triggered a
> list double-add in drm_sched_stop (calltrace follows):

I think this should fix the double add:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7107c4d3a3b6..555d3b671bdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -88,6 +88,8 @@ static enum drm_gpu_sched_stat
amdgpu_job_timedout(struct drm_sched_job *s_job)
                                drm_sched_start(&ring->sched, true);
                        goto exit;
                }
+               if (amdgpu_ring_sched_ready(ring))
+                       drm_sched_start(&ring->sched, true);
        }

        if (amdgpu_device_should_recover_gpu(ring->adev)) {


>
> ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 ar=
ch/x86/kernel/dumpstack.c:447)
> ? do_trap (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154)
> ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.=
c:175)
> ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> ? exc_invalid_op (arch/x86/kernel/traps.c:266)
> ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
> ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1))
> drm_sched_stop (./include/linux/list.h:151 ./include/linux/list.h:169 dri=
vers/gpu/drm/scheduler/sched_main.c:617)
> amdgpu_device_gpu_recover (drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:580=
8)
> amdgpu_job_timedout (drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:103)
> drm_sched_job_timedout (drivers/gpu/drm/scheduler/sched_main.c:569)
> process_one_work (kernel/workqueue.c:2633)
> worker_thread (kernel/workqueue.c:2700 (discriminator 2) kernel/workqueue=
.c:2787 (discriminator 2))
> ? __pfx_worker_thread (kernel/workqueue.c:2733)
> kthread (kernel/kthread.c:388)
> ? __pfx_kthread (kernel/kthread.c:341)
> ret_from_fork (arch/x86/kernel/process.c:147)
> ? __pfx_kthread (kernel/kthread.c:341)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:251)
>
> When running the tests without a desktop environment active, the
> double-add disappeared, but the GPU reset still didn't go well - the TTY
> remained frozen and the kernel log contained a few messages like:
>
> [drm] *ERROR* [CRTC:90:crtc-0] flip_done timed out

I don't think the display hardware is hung, I think it's a fence
signalling issue after the reset.  We are investigating some
limitations we are seeing in the handling of fences.

>
> which I guess means at least the display subsystem is hung.
>
> Hope this info is enough to repro/investigate.

Thanks for testing!

Alex

>
> Thanks,
> Friedrich
>
> [1] https://lore.kernel.org/amd-gfx/20240717203740.14059-1-alexander.deuc=
her@amd.com/T/#t
> [2] https://lore.kernel.org/amd-gfx/20240717203847.14600-1-alexander.deuc=
her@amd.com/T/#t
> [3] https://lore.kernel.org/amd-gfx/230ee72e-4f7f-4894-a789-2e1e5788344f@=
amd.com/T/#t
> [4] https://gitlab.steamos.cloud/holo/HangTestSuite
>
>
> >
> > Alex Deucher (19):
> >    drm/amdgpu/mes: add API for legacy queue reset
> >    drm/amdgpu/mes11: add API for legacy queue reset
> >    drm/amdgpu/mes12: add API for legacy queue reset
> >    drm/amdgpu/mes: add API for user queue reset
> >    drm/amdgpu/mes11: add API for user queue reset
> >    drm/amdgpu/mes12: add API for user queue reset
> >    drm/amdgpu: add new ring reset callback
> >    drm/amdgpu: add per ring reset support (v2)
> >    drm/amdgpu/gfx11: add ring reset callbacks
> >    drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
> >    drm/amdgpu/gfx10: add ring reset callbacks
> >    drm/amdgpu/gfx10: rework reset sequence
> >    drm/amdgpu/gfx9: add ring reset callback
> >    drm/amdgpu/gfx9.4.3: add ring reset callback
> >    drm/amdgpu/gfx12: add ring reset callbacks
> >    drm/amdgpu/gfx12: fallback to driver reset compute queue directly
> >    drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
> >    drm/amdgpu/gfx11: add a mutex for the gfx semaphore
> >    drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
> >
> > Jiadong Zhu (13):
> >    drm/amdgpu/gfx11: wait for reset done before remap
> >    drm/amdgpu/gfx10: remap queue after reset successfully
> >    drm/amdgpu/gfx10: wait for reset done before remap
> >    drm/amdgpu/gfx9: remap queue after reset successfully
> >    drm/amdgpu/gfx9: wait for reset done before remap
> >    drm/amdgpu/gfx9.4.3: remap queue after reset successfully
> >    drm/amdgpu/gfx_9.4.3: wait for reset done before remap
> >    drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
> >    drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
> >    drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
> >    drm/amdgpu/mes: modify mes api for mmio queue reset
> >    drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
> >    drm/amdgpu/mes11: implement mmio queue reset for gfx11
> >
> > Prike Liang (2):
> >    drm/amdgpu: increase the reset counter for the queue reset
> >    drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v=
2)
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  18 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 158 ++++++++++++++++++++=
-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 117 +++++++++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  95 ++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 126 +++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 125 +++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 132 +++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++++
> >   14 files changed, 930 insertions(+), 32 deletions(-)
> >
>
>
>
